package opensearch

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

type Domain struct {
	DomainId   string
	DomainName string
	ARN        string
	EngineType string
	Created    bool
	Deleted    bool
	Processing bool
	Endpoint   string
	Tags       map[string]string
	CreatedAt  time.Time
}

type Store struct {
	mu      sync.RWMutex
	domains map[string]*Domain
}

func NewStore() *Store {
	return &Store{domains: make(map[string]*Domain)}
}

func (s *Store) Reset() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.domains = make(map[string]*Domain)
}

type Handler struct {
	state *state.ServerState
	store *Store
}

func NewHandler(s *state.ServerState) *Handler {
	store := NewStore()
	s.AddResetCallback(store.Reset)
	return &Handler{state: s, store: store}
}

func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	target := r.Header.Get("X-Amz-Target")
	operation := ""
	if strings.HasPrefix(target, "OpenSearch_20210101.") {
		operation = strings.TrimPrefix(target, "OpenSearch_20210101.")
	} else {
		parts := strings.SplitN(target, ".", 2)
		if len(parts) == 2 {
			operation = parts[1]
		}
	}

	if state.ApplyIAMAuth(h.state, "opensearch", operation, r, w, false) {
		return
	}
	if state.ApplyChaos(h.state, "opensearch", operation, w, false, false) {
		return
	}

	var body map[string]interface{}
	json.NewDecoder(r.Body).Decode(&body) //nolint:errcheck
	if body == nil {
		body = make(map[string]interface{})
	}

	h.handle(w, operation, body)
}

func writeOK(w http.ResponseWriter, data interface{}) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(200)
	json.NewEncoder(w).Encode(data) //nolint:errcheck
}

func writeErr(w http.ResponseWriter, status int, code, msg string) {
	w.Header().Set("Content-Type", "application/json")
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

func domainDesc(d *Domain) map[string]interface{} {
	return map[string]interface{}{
		"DomainId":   d.DomainId,
		"DomainName": d.DomainName,
		"ARN":        d.ARN,
		"EngineType": d.EngineType,
		"Created":    d.Created,
		"Deleted":    d.Deleted,
		"Processing": d.Processing,
		"Endpoint":   d.Endpoint,
	}
}

func (h *Handler) handle(w http.ResponseWriter, operation string, body map[string]interface{}) {
	switch operation {
	case "CreateDomain":
		name := getString(body, "DomainName")
		arn := fmt.Sprintf("arn:aws:es:%s:%s:domain/%s", region, accountID, name)
		domain := &Domain{
			DomainId:   fmt.Sprintf("%s/%s", accountID, name),
			DomainName: name,
			ARN:        arn,
			EngineType: "OpenSearch",
			Created:    true,
			Deleted:    false,
			Processing: false,
			Endpoint:   "http://localhost:9200",
			Tags:       make(map[string]string),
			CreatedAt:  time.Now(),
		}
		h.store.mu.Lock()
		h.store.domains[name] = domain
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"DomainStatus": domainDesc(domain)})

	case "DeleteDomain":
		name := getString(body, "DomainName")
		h.store.mu.Lock()
		domain := h.store.domains[name]
		delete(h.store.domains, name)
		h.store.mu.Unlock()
		if domain == nil {
			writeErr(w, 404, "ResourceNotFoundException", "Domain not found: "+name)
			return
		}
		writeOK(w, map[string]interface{}{"DomainStatus": domainDesc(domain)})

	case "DescribeDomain":
		name := getString(body, "DomainName")
		h.store.mu.RLock()
		domain := h.store.domains[name]
		h.store.mu.RUnlock()
		if domain == nil {
			writeErr(w, 404, "ResourceNotFoundException", "Domain not found: "+name)
			return
		}
		writeOK(w, map[string]interface{}{"DomainStatus": domainDesc(domain)})

	case "ListDomainNames":
		h.store.mu.RLock()
		var names []map[string]string
		for _, d := range h.store.domains {
			names = append(names, map[string]string{"DomainName": d.DomainName})
		}
		h.store.mu.RUnlock()
		if names == nil {
			names = []map[string]string{}
		}
		writeOK(w, map[string]interface{}{"DomainNames": names})

	case "AddTags":
		arn := getString(body, "ARN")
		h.store.mu.Lock()
		for _, d := range h.store.domains {
			if d.ARN == arn {
				if tagList, ok := body["TagList"].([]interface{}); ok {
					for _, t := range tagList {
						if tm, ok := t.(map[string]interface{}); ok {
							d.Tags[getString(tm, "Key")] = getString(tm, "Value")
						}
					}
				}
				break
			}
		}
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{})

	case "ListTags":
		arn := getString(body, "ARN")
		h.store.mu.RLock()
		var tagList []map[string]string
		for _, d := range h.store.domains {
			if d.ARN == arn {
				for k, v := range d.Tags {
					tagList = append(tagList, map[string]string{"Key": k, "Value": v})
				}
				break
			}
		}
		h.store.mu.RUnlock()
		if tagList == nil {
			tagList = []map[string]string{}
		}
		writeOK(w, map[string]interface{}{"TagList": tagList})

	case "RemoveTags":
		arn := getString(body, "ARN")
		h.store.mu.Lock()
		for _, d := range h.store.domains {
			if d.ARN == arn {
				if tagKeys, ok := body["TagKeys"].([]interface{}); ok {
					for _, k := range tagKeys {
						if ks, ok := k.(string); ok {
							delete(d.Tags, ks)
						}
					}
				}
				break
			}
		}
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{})

	default:
		writeErr(w, 400, "ValidationException", "Unknown operation: "+operation)
	}
}
