package ssm

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
	"sync"
	"time"

	"github.com/local-web-services/local-web-services-go-core/lws/state"
)

const accountID = "000000000000"
const region = "us-east-1"

type Parameter struct {
	Name      string
	Value     string
	Type      string
	ARN       string
	Version   int
	Tags      map[string]string
	CreatedAt time.Time
}

type Store struct {
	mu         sync.RWMutex
	parameters map[string]*Parameter
}

func NewStore() *Store {
	return &Store{parameters: make(map[string]*Parameter)}
}

func (s *Store) Reset() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.parameters = make(map[string]*Parameter)
}

func paramARN(name string) string {
	return fmt.Sprintf("arn:aws:ssm:%s:%s:parameter%s", region, accountID, name)
}

type Handler struct {
	state *state.ServerState
	store *Store
}

func NewHandler(state *state.ServerState) *Handler {
	store := NewStore()
	state.AddResetCallback(store.Reset)
	return &Handler{state: state, store: store}
}

func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	target := r.Header.Get("X-Amz-Target")
	operation := ""
	if strings.HasPrefix(target, "AmazonSSM.") {
		operation = strings.TrimPrefix(target, "AmazonSSM.")
	} else {
		parts := strings.SplitN(target, ".", 2)
		if len(parts) == 2 {
			operation = parts[1]
		}
	}

	if state.ApplyIAMAuth(h.state, "ssm", operation, r, w, false) {
		return
	}
	if state.ApplyChaos(h.state, "ssm", operation, w, false, false) {
		return
	}

	var body map[string]interface{}
	json.NewDecoder(r.Body).Decode(&body)
	if body == nil {
		body = make(map[string]interface{})
	}

	h.handle(w, operation, body)
}

func writeOK(w http.ResponseWriter, data interface{}) {
	w.Header().Set("Content-Type", "application/x-amz-json-1.1")
	w.WriteHeader(200)
	json.NewEncoder(w).Encode(data)
}

func writeErr(w http.ResponseWriter, code, msg string, status int) {
	w.Header().Set("Content-Type", "application/x-amz-json-1.1")
	w.WriteHeader(status)
	fmt.Fprintf(w, `{"__type":%q,"message":%q}`+"\n", code, msg)
}

func getString(m map[string]interface{}, key string) string {
	if v, ok := m[key]; ok {
		if s, ok := v.(string); ok {
			return s
		}
	}
	return ""
}

func paramDesc(p *Parameter) map[string]interface{} {
	return map[string]interface{}{
		"Name":             p.Name,
		"Value":            p.Value,
		"Type":             p.Type,
		"ARN":              p.ARN,
		"Version":          p.Version,
		"LastModifiedDate": p.CreatedAt.Unix(),
	}
}

func (h *Handler) handle(w http.ResponseWriter, operation string, body map[string]interface{}) {
	switch operation {
	case "PutParameter":
		name := getString(body, "Name")
		value := getString(body, "Value")
		pType := getString(body, "Type")
		if pType == "" {
			pType = "String"
		}
		// Parse Overwrite flag.
		var overwrite *bool
		if ov, ok := body["Overwrite"].(bool); ok {
			overwrite = &ov
		}
		h.store.mu.Lock()
		existing, exists := h.store.parameters[name]
		if overwrite == nil {
			// No Overwrite specified: create-only mode. Fail if parameter already exists.
			if exists {
				h.store.mu.Unlock()
				writeErr(w, "ParameterAlreadyExists", "Parameter already exists: "+name, 400)
				return
			}
		} else if *overwrite {
			// Overwrite=true: upsert mode — create if not present, update if present.
			_ = existing
		} else {
			// Overwrite=false: update-mode that records ParameterAlreadyExists.
			// Fail if parameter does NOT exist (nothing to conflict with).
			if !exists {
				h.store.mu.Unlock()
				writeErr(w, "ParameterNotFound", "Parameter not found: "+name, 400)
				return
			}
			// Parameter exists: return ParameterAlreadyExists (as expected error).
			h.store.mu.Unlock()
			writeErr(w, "ParameterAlreadyExists", "Parameter already exists: "+name, 400)
			return
		}
		version := 1
		if exists {
			version = existing.Version + 1
		}
		tags := make(map[string]string)
		if exists && existing.Tags != nil {
			tags = existing.Tags
		}
		h.store.parameters[name] = &Parameter{
			Name:      name,
			Value:     value,
			Type:      pType,
			ARN:       paramARN(name),
			Version:   version,
			Tags:      tags,
			CreatedAt: time.Now(),
		}
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"Version": version, "Tier": "Standard"})

	case "GetParameter":
		name := getString(body, "Name")
		h.store.mu.RLock()
		p, ok := h.store.parameters[name]
		h.store.mu.RUnlock()
		if !ok {
			writeErr(w, "ParameterNotFound", "Parameter not found: "+name, 400)
			return
		}
		writeOK(w, map[string]interface{}{"Parameter": paramDesc(p)})

	case "GetParameters":
		namesRaw, _ := body["Names"].([]interface{})
		var params []map[string]interface{}
		var invalidNames []string
		h.store.mu.RLock()
		for _, n := range namesRaw {
			name, ok := n.(string)
			if !ok {
				continue
			}
			p, found := h.store.parameters[name]
			if found {
				params = append(params, paramDesc(p))
			} else {
				invalidNames = append(invalidNames, name)
			}
		}
		h.store.mu.RUnlock()
		if params == nil {
			params = []map[string]interface{}{}
		}
		if invalidNames == nil {
			invalidNames = []string{}
		}
		writeOK(w, map[string]interface{}{"Parameters": params, "InvalidParameters": invalidNames})

	case "GetParametersByPath":
		path := getString(body, "Path")
		h.store.mu.RLock()
		var params []map[string]interface{}
		for name, p := range h.store.parameters {
			if strings.HasPrefix(name, path) {
				params = append(params, paramDesc(p))
			}
		}
		h.store.mu.RUnlock()
		if params == nil {
			params = []map[string]interface{}{}
		}
		writeOK(w, map[string]interface{}{"Parameters": params})

	case "DeleteParameter":
		name := getString(body, "Name")
		h.store.mu.Lock()
		if _, ok := h.store.parameters[name]; !ok {
			h.store.mu.Unlock()
			writeErr(w, "ParameterNotFound", "Parameter not found: "+name, 400)
			return
		}
		delete(h.store.parameters, name)
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{})

	case "DeleteParameters":
		namesRaw, _ := body["Names"].([]interface{})
		var deleted []string
		var invalid []string
		h.store.mu.Lock()
		for _, n := range namesRaw {
			name, ok := n.(string)
			if !ok {
				continue
			}
			if _, found := h.store.parameters[name]; found {
				delete(h.store.parameters, name)
				deleted = append(deleted, name)
			} else {
				invalid = append(invalid, name)
			}
		}
		h.store.mu.Unlock()
		// If ALL requested parameters were invalid (none found), return an error.
		if len(deleted) == 0 && len(invalid) > 0 {
			writeErr(w, "ParameterNotFound", "None of the requested parameters were found", 400)
			return
		}
		if deleted == nil {
			deleted = []string{}
		}
		if invalid == nil {
			invalid = []string{}
		}
		writeOK(w, map[string]interface{}{"DeletedParameters": deleted, "InvalidParameters": invalid})

	case "DescribeParameters":
		h.store.mu.RLock()
		var params []map[string]interface{}
		for _, p := range h.store.parameters {
			params = append(params, map[string]interface{}{
				"Name":    p.Name,
				"Type":    p.Type,
				"Version": p.Version,
			})
		}
		h.store.mu.RUnlock()
		if params == nil {
			params = []map[string]interface{}{}
		}
		writeOK(w, map[string]interface{}{"Parameters": params})

	case "AddTagsToResource":
		resourceID := getString(body, "ResourceId")
		tags, _ := body["Tags"].([]interface{})
		h.store.mu.Lock()
		p, ok := h.store.parameters[resourceID]
		if !ok {
			h.store.mu.Unlock()
			writeErr(w, "ParameterNotFound", "Parameter not found: "+resourceID, 400)
			return
		}
		for _, t := range tags {
			if tm, ok := t.(map[string]interface{}); ok {
				k := getString(tm, "Key")
				v := getString(tm, "Value")
				p.Tags[k] = v
			}
		}
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{})

	case "RemoveTagsFromResource":
		resourceID := getString(body, "ResourceId")
		tagKeys, _ := body["TagKeys"].([]interface{})
		h.store.mu.Lock()
		p, ok := h.store.parameters[resourceID]
		if !ok {
			h.store.mu.Unlock()
			writeErr(w, "ParameterNotFound", "Parameter not found: "+resourceID, 400)
			return
		}
		// Check that all requested tag keys exist.
		for _, k := range tagKeys {
			if ks, ok := k.(string); ok {
				if _, exists := p.Tags[ks]; !exists {
					h.store.mu.Unlock()
					writeErr(w, "InvalidResourceId", "Tag not found: "+ks, 400)
					return
				}
			}
		}
		for _, k := range tagKeys {
			if ks, ok := k.(string); ok {
				delete(p.Tags, ks)
			}
		}
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{})

	case "ListTagsForResource":
		resourceID := getString(body, "ResourceId")
		h.store.mu.RLock()
		p, ok := h.store.parameters[resourceID]
		if !ok {
			h.store.mu.RUnlock()
			writeErr(w, "ParameterNotFound", "Parameter not found: "+resourceID, 400)
			return
		}
		var tagList []map[string]string
		for k, v := range p.Tags {
			tagList = append(tagList, map[string]string{"Key": k, "Value": v})
		}
		h.store.mu.RUnlock()
		if tagList == nil {
			tagList = []map[string]string{}
		}
		writeOK(w, map[string]interface{}{"TagList": tagList})

	default:
		writeErr(w, "ValidationException", "Unknown operation: "+operation, 400)
	}
}
