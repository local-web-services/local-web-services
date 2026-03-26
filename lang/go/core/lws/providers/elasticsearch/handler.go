package elasticsearch

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

func (h *Handler) routeOperation(method, path string) string {
	// Elasticsearch Service uses REST API routing (no X-Amz-Target)
	// Paths start with /2015-01-01/
	path = strings.TrimPrefix(path, "/2015-01-01")
	switch {
	case path == "/es/domain" && method == http.MethodPost:
		return "CreateElasticsearchDomain"
	case path == "/es/domain" && method == http.MethodGet:
		return "ListDomainNames"
	case strings.HasPrefix(path, "/es/domain/") && strings.HasSuffix(path, "/config") && method == http.MethodPost:
		return "UpdateElasticsearchDomainConfig"
	case strings.HasPrefix(path, "/es/domain/") && method == http.MethodGet:
		return "DescribeElasticsearchDomain"
	case strings.HasPrefix(path, "/es/domain/") && method == http.MethodDelete:
		return "DeleteElasticsearchDomain"
	case path == "/tags" && method == http.MethodPost:
		return "AddTags"
	case path == "/tags" && method == http.MethodGet:
		return "ListTags"
	case path == "/tags-removal" && method == http.MethodPost:
		return "RemoveTags"
	default:
		return ""
	}
}

func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	operation := h.routeOperation(r.Method, r.URL.Path)

	if state.ApplyIAMAuth(h.state, "es", operation, r, w, false) {
		return
	}
	if state.ApplyChaos(h.state, "es", operation, w, false, false) {
		return
	}

	var body map[string]interface{}
	if r.Method == http.MethodPost || r.Method == http.MethodPut {
		json.NewDecoder(r.Body).Decode(&body) //nolint:errcheck
	}
	if body == nil {
		body = make(map[string]interface{})
	}

	h.handle(w, r, operation, body)
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
		"Created":    d.Created,
		"Deleted":    d.Deleted,
		"Processing": d.Processing,
		"Endpoint":   d.Endpoint,
	}
}

// domainNameFromPath extracts the domain name from a path like /2015-01-01/es/domain/{domain-name}
func domainNameFromPath(path string) string {
	path = strings.TrimPrefix(path, "/2015-01-01/es/domain/")
	return strings.SplitN(path, "/", 2)[0]
}

func (h *Handler) handle(w http.ResponseWriter, r *http.Request, operation string, body map[string]interface{}) {
	switch operation {
	case "CreateElasticsearchDomain":
		name := getString(body, "DomainName")
		arn := fmt.Sprintf("arn:aws:es:%s:%s:domain/%s", region, accountID, name)
		domain := &Domain{
			DomainId:   fmt.Sprintf("%s/%s", accountID, name),
			DomainName: name,
			ARN:        arn,
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

	case "DeleteElasticsearchDomain":
		name := domainNameFromPath(r.URL.Path)
		h.store.mu.Lock()
		domain := h.store.domains[name]
		delete(h.store.domains, name)
		h.store.mu.Unlock()
		if domain == nil {
			writeErr(w, 404, "ResourceNotFoundException", "Domain not found: "+name)
			return
		}
		writeOK(w, map[string]interface{}{"DomainStatus": domainDesc(domain)})

	case "DescribeElasticsearchDomain":
		name := domainNameFromPath(r.URL.Path)
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
		arn := r.URL.Query().Get("arn")
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
		var found bool
		for _, d := range h.store.domains {
			if d.ARN == arn {
				found = true
				if tagKeys, ok := body["TagKeys"].([]interface{}); ok {
					for _, k := range tagKeys {
						if ks, ok := k.(string); ok {
							if _, exists := d.Tags[ks]; !exists {
								h.store.mu.Unlock()
								writeErr(w, 400, "ValidationException", "Tag key not found: "+ks)
								return
							}
							delete(d.Tags, ks)
						}
					}
				}
				break
			}
		}
		h.store.mu.Unlock()
		if !found {
			writeErr(w, 404, "ResourceNotFoundException", "Domain not found")
			return
		}
		writeOK(w, map[string]interface{}{})

	case "UpdateElasticsearchDomainConfig":
		domainName := domainNameFromPath(r.URL.Path)
		h.store.mu.Lock()
		domain := h.store.domains[domainName]
		if domain == nil {
			h.store.mu.Unlock()
			writeErr(w, 404, "ResourceNotFoundException", "Domain not found: "+domainName)
			return
		}
		domain.Processing = true
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"DomainConfig": map[string]interface{}{}})

	default:
		writeErr(w, 400, "ValidationException", "Unknown operation: "+operation)
	}
}
