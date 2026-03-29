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

// Connection represents a cross-cluster connection entry (both outbound and inbound).
type Connection struct {
	ConnectionID    string
	ConnectionAlias string
	LocalDomain     string
	RemoteDomain    string
	Status          string // PROVISIONING, ACTIVE, PENDING_ACCEPTANCE, APPROVED, REJECTED, DELETING, DELETED
}

type Store struct {
	mu          sync.RWMutex
	domains     map[string]*Domain
	outbound    map[string]*Connection // key: connectionID
	inbound     map[string]*Connection // key: connectionID
	connCounter int
}

func NewStore() *Store {
	return &Store{
		domains:  make(map[string]*Domain),
		outbound: make(map[string]*Connection),
		inbound:  make(map[string]*Connection),
	}
}

func (s *Store) Reset() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.domains = make(map[string]*Domain)
	s.outbound = make(map[string]*Connection)
	s.inbound = make(map[string]*Connection)
	s.connCounter = 0
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

// routeOperation maps (method, path) to an operation name.
// The AWS OpenSearch Service REST API uses /2021-01-01/ prefixed paths.
func routeOperation(method, path string) string {
	// Strip the version prefix.
	path = strings.TrimPrefix(path, "/2021-01-01")
	// Trim any remaining leading slash.
	path = strings.TrimPrefix(path, "/")

	switch {
	case method == http.MethodPost && path == "opensearch/domain":
		return "CreateDomain"
	case method == http.MethodGet && strings.HasPrefix(path, "opensearch/domain/") && !strings.Contains(strings.TrimPrefix(path, "opensearch/domain/"), "/"):
		return "DescribeDomain"
	case method == http.MethodDelete && strings.HasPrefix(path, "opensearch/domain/") && !strings.Contains(strings.TrimPrefix(path, "opensearch/domain/"), "/"):
		return "DeleteDomain"
	case method == http.MethodGet && path == "domain":
		return "ListDomainNames"
	case method == http.MethodPost && strings.HasSuffix(path, "/config"):
		return "UpdateDomainConfig"
	case method == http.MethodPost && path == "tags":
		return "AddTags"
	case method == http.MethodGet && path == "tags":
		return "ListTags"
	case method == http.MethodPost && path == "tags-removal":
		return "RemoveTags"
	case method == http.MethodPost && path == "opensearch/cc/outboundConnection":
		return "CreateOutboundConnection"
	case method == http.MethodDelete && strings.HasPrefix(path, "opensearch/cc/outboundConnection/"):
		return "DeleteOutboundConnection"
	case method == http.MethodPut && strings.HasSuffix(path, "/accept"):
		return "AcceptInboundConnection"
	case method == http.MethodPut && strings.HasSuffix(path, "/reject"):
		return "RejectInboundConnection"
	case method == http.MethodDelete && strings.HasPrefix(path, "opensearch/cc/inboundConnection/"):
		return "DeleteInboundConnection"
	default:
		return ""
	}
}

func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	path := r.URL.Path
	operation := routeOperation(r.Method, path)

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

	h.handle(w, r, operation, path, body)
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

func getNestedString(m map[string]interface{}, keys ...string) string {
	cur := m
	for i, k := range keys {
		v, ok := cur[k]
		if !ok {
			return ""
		}
		if i == len(keys)-1 {
			if s, ok := v.(string); ok {
				return s
			}
			return ""
		}
		if next, ok := v.(map[string]interface{}); ok {
			cur = next
		} else {
			return ""
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

// lastPathSegment returns the last "/" separated segment of path.
func lastPathSegment(path string) string {
	path = strings.TrimRight(path, "/")
	idx := strings.LastIndex(path, "/")
	if idx < 0 {
		return path
	}
	return path[idx+1:]
}

// domainNameFromPath extracts DomainName from paths like
// /2021-01-01/opensearch/domain/{DomainName} or /2021-01-01/opensearch/domain/{DomainName}/config
func domainNameFromPath(path string) string {
	path = strings.TrimPrefix(path, "/2021-01-01/opensearch/domain/")
	idx := strings.Index(path, "/")
	if idx >= 0 {
		return path[:idx]
	}
	return path
}

// connectionIDFromPath extracts the connection ID from paths like
// /2021-01-01/opensearch/cc/outboundConnection/{id} or inboundConnection/{id}/accept
func connectionIDFromPath(path string) string {
	path = strings.TrimPrefix(path, "/2021-01-01/opensearch/cc/outboundConnection/")
	path = strings.TrimPrefix(path, "/2021-01-01/opensearch/cc/inboundConnection/")
	// remove trailing /accept or /reject
	idx := strings.Index(path, "/")
	if idx >= 0 {
		return path[:idx]
	}
	return path
}

func (h *Handler) handle(w http.ResponseWriter, r *http.Request, operation, path string, body map[string]interface{}) {
	switch operation {
	case "CreateDomain":
		name := getString(body, "DomainName")
		if name == "" {
			writeErr(w, 400, "ValidationException", "DomainName is required")
			return
		}
		h.store.mu.Lock()
		if _, exists := h.store.domains[name]; exists {
			h.store.mu.Unlock()
			writeErr(w, 409, "ResourceAlreadyExistsException", "Domain already exists: "+name)
			return
		}
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
		h.store.domains[name] = domain
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"DomainStatus": domainDesc(domain)})

	case "DeleteDomain":
		name := domainNameFromPath(path)
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
		name := domainNameFromPath(path)
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
		if arn == "" {
			arn = getString(body, "ARN")
		}
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

	case "UpdateDomainConfig":
		name := domainNameFromPath(path)
		h.store.mu.Lock()
		domain := h.store.domains[name]
		if domain == nil {
			h.store.mu.Unlock()
			writeErr(w, 404, "ResourceNotFoundException", "Domain not found: "+name)
			return
		}
		domain.Processing = true
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"DomainConfig": map[string]interface{}{}})

	case "CreateOutboundConnection":
		alias := getString(body, "ConnectionAlias")
		localName := getNestedString(body, "LocalDomainInfo", "AWSDomainInformation", "DomainName")
		remoteName := getNestedString(body, "RemoteDomainInfo", "AWSDomainInformation", "DomainName")
		h.store.mu.Lock()
		if localName != "" {
			if _, ok := h.store.domains[localName]; !ok {
				h.store.mu.Unlock()
				writeErr(w, 409, "ResourceNotFoundException", "Local domain not found: "+localName)
				return
			}
		}
		if remoteName != "" {
			if _, ok := h.store.domains[remoteName]; !ok {
				h.store.mu.Unlock()
				writeErr(w, 409, "ResourceNotFoundException", "Remote domain not found: "+remoteName)
				return
			}
		}
		if localName != "" && remoteName != "" && localName == remoteName {
			h.store.mu.Unlock()
			writeErr(w, 409, "DisabledOperationException", "Local and remote domains must be different")
			return
		}
		h.store.connCounter++
		connID := fmt.Sprintf("conn-%d", h.store.connCounter)
		outConn := &Connection{
			ConnectionID:    connID,
			ConnectionAlias: alias,
			Status:          "ACTIVE",
		}
		inConn := &Connection{
			ConnectionID: connID,
			Status:       "PENDING_ACCEPTANCE",
		}
		h.store.outbound[connID] = outConn
		h.store.inbound[connID] = inConn
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{
			"ConnectionId":    connID,
			"ConnectionAlias": alias,
			"ConnectionStatus": map[string]interface{}{
				"StatusCode": "ACTIVE",
			},
		})

	case "DeleteOutboundConnection":
		connID := connectionIDFromPath(path)
		h.store.mu.Lock()
		conn := h.store.outbound[connID]
		if conn != nil && (conn.Status == "DELETING" || conn.Status == "DELETED") {
			h.store.mu.Unlock()
			writeErr(w, 409, "ResourceNotFoundException", "Outbound connection is already "+conn.Status+": "+connID)
			return
		}
		delete(h.store.outbound, connID)
		h.store.mu.Unlock()
		if conn == nil {
			writeErr(w, 404, "ResourceNotFoundException", "Outbound connection not found: "+connID)
			return
		}
		writeOK(w, map[string]interface{}{
			"ConnectionId": connID,
			"ConnectionStatus": map[string]interface{}{
				"StatusCode": "DELETING",
			},
		})

	case "AcceptInboundConnection":
		connID := connectionIDFromPath(path)
		h.store.mu.Lock()
		conn := h.store.inbound[connID]
		if conn != nil {
			if conn.Status != "PENDING_ACCEPTANCE" {
				h.store.mu.Unlock()
				writeErr(w, 409, "ResourceNotFoundException", "Connection not in PENDING_ACCEPTANCE state: "+connID)
				return
			}
			conn.Status = "ACTIVE"
		}
		h.store.mu.Unlock()
		if conn == nil {
			writeErr(w, 404, "ResourceNotFoundException", "Inbound connection not found: "+connID)
			return
		}
		writeOK(w, map[string]interface{}{
			"Connection": map[string]interface{}{
				"ConnectionId": connID,
				"ConnectionStatus": map[string]interface{}{
					"StatusCode": "ACTIVE",
				},
			},
		})

	case "RejectInboundConnection":
		connID := connectionIDFromPath(path)
		h.store.mu.Lock()
		conn := h.store.inbound[connID]
		if conn != nil {
			conn.Status = "REJECTED"
		}
		h.store.mu.Unlock()
		if conn == nil {
			writeErr(w, 404, "ResourceNotFoundException", "Inbound connection not found: "+connID)
			return
		}
		writeOK(w, map[string]interface{}{
			"Connection": map[string]interface{}{
				"ConnectionId": connID,
				"ConnectionStatus": map[string]interface{}{
					"StatusCode": "REJECTED",
				},
			},
		})

	case "DeleteInboundConnection":
		connID := connectionIDFromPath(path)
		h.store.mu.Lock()
		conn := h.store.inbound[connID]
		delete(h.store.inbound, connID)
		h.store.mu.Unlock()
		if conn == nil {
			writeErr(w, 404, "ResourceNotFoundException", "Inbound connection not found: "+connID)
			return
		}
		writeOK(w, map[string]interface{}{
			"Connection": map[string]interface{}{
				"ConnectionId": connID,
				"ConnectionStatus": map[string]interface{}{
					"StatusCode": "DELETED",
				},
			},
		})

	default:
		writeErr(w, 400, "ValidationException", "Unknown operation: "+operation)
	}
}
