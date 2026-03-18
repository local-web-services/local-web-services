package s3tables

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

type TableBucket struct {
	Name      string
	ARN       string
	CreatedAt time.Time
}

type Namespace struct {
	Name      string
	Bucket    string
	CreatedAt time.Time
}

type Table struct {
	Name      string
	Namespace string
	Bucket    string
	ARN       string
	TableType string
	CreatedAt time.Time
}

type Store struct {
	mu         sync.RWMutex
	buckets    map[string]*TableBucket // key: bucketName
	namespaces map[string]*Namespace   // key: bucketName/namespaceName
	tables     map[string]*Table       // key: bucketName/namespace/tableName
}

func NewStore() *Store {
	return &Store{
		buckets:    make(map[string]*TableBucket),
		namespaces: make(map[string]*Namespace),
		tables:     make(map[string]*Table),
	}
}

func (s *Store) Reset() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.buckets = make(map[string]*TableBucket)
	s.namespaces = make(map[string]*Namespace)
	s.tables = make(map[string]*Table)
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
	// Route by method + path
	// /buckets → CreateTableBucket (POST) or ListTableBuckets (GET)
	// /buckets/{b} → DeleteTableBucket (DELETE) or GetTableBucket (GET)
	// /buckets/{b}/namespaces → CreateNamespace (POST) or ListNamespaces (GET)
	// /buckets/{b}/namespaces/{ns} → DeleteNamespace (DELETE)
	// /buckets/{b}/tables → CreateTable (POST) or ListTables (GET)
	// /buckets/{b}/tables/{ns}/{table} → DeleteTable (DELETE) or GetTable (GET)

	parts := strings.Split(strings.TrimPrefix(r.URL.Path, "/"), "/")
	// parts[0] = "buckets"
	// parts[1] = bucketName (if present)
	// parts[2] = "namespaces" | "tables" (if present)
	// parts[3] = namespace or ns (if present)
	// parts[4] = table (if present for tables route)

	operation := h.routeOperation(r.Method, parts)

	if state.ApplyIAMAuth(h.state, "s3tables", operation, r, w, false) {
		return
	}
	if state.ApplyChaos(h.state, "s3tables", operation, w, false, false) {
		return
	}

	var body map[string]interface{}
	if r.Method == http.MethodPost || r.Method == http.MethodPut {
		json.NewDecoder(r.Body).Decode(&body) //nolint:errcheck
	}
	if body == nil {
		body = make(map[string]interface{})
	}

	h.handle(w, r, operation, parts, body)
}

func (h *Handler) routeOperation(method string, parts []string) string {
	n := len(parts)
	switch {
	case n == 1 && parts[0] == "buckets" && method == http.MethodPost:
		return "CreateTableBucket"
	case n == 1 && parts[0] == "buckets" && method == http.MethodGet:
		return "ListTableBuckets"
	case n == 2 && parts[0] == "buckets" && method == http.MethodDelete:
		return "DeleteTableBucket"
	case n == 2 && parts[0] == "buckets" && method == http.MethodGet:
		return "GetTableBucket"
	case n == 3 && parts[2] == "namespaces" && method == http.MethodPost:
		return "CreateNamespace"
	case n == 3 && parts[2] == "namespaces" && method == http.MethodGet:
		return "ListNamespaces"
	case n == 4 && parts[2] == "namespaces" && method == http.MethodDelete:
		return "DeleteNamespace"
	case n == 3 && parts[2] == "tables" && method == http.MethodPost:
		return "CreateTable"
	case n == 3 && parts[2] == "tables" && method == http.MethodGet:
		return "ListTables"
	case n == 5 && parts[2] == "tables" && method == http.MethodDelete:
		return "DeleteTable"
	case n == 5 && parts[2] == "tables" && method == http.MethodGet:
		return "GetTable"
	default:
		return "Unknown"
	}
}

func sendJSON(w http.ResponseWriter, status int, v interface{}) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	json.NewEncoder(w).Encode(v) //nolint:errcheck
}

func sendError(w http.ResponseWriter, status int, code, msg string) {
	sendJSON(w, status, map[string]string{"__type": code, "message": msg})
}

func getString(m map[string]interface{}, key string) string {
	if v, ok := m[key]; ok {
		if s, ok := v.(string); ok {
			return s
		}
	}
	return ""
}

func bucketDesc(b *TableBucket) map[string]interface{} {
	return map[string]interface{}{
		"name":      b.Name,
		"arn":       b.ARN,
		"createdAt": b.CreatedAt.Format(time.RFC3339),
	}
}

func nsDesc(ns *Namespace) map[string]interface{} {
	return map[string]interface{}{
		"namespace":  ns.Name,
		"bucketName": ns.Bucket,
		"createdAt":  ns.CreatedAt.Format(time.RFC3339),
	}
}

func tableDesc(t *Table) map[string]interface{} {
	return map[string]interface{}{
		"name":       t.Name,
		"namespace":  t.Namespace,
		"bucketName": t.Bucket,
		"arn":        t.ARN,
		"tableType":  t.TableType,
		"createdAt":  t.CreatedAt.Format(time.RFC3339),
	}
}

func (h *Handler) handle(w http.ResponseWriter, r *http.Request, operation string, parts []string, body map[string]interface{}) {
	var bucketName, nsName, tableName string
	if len(parts) >= 2 {
		bucketName = parts[1]
	}
	if len(parts) >= 4 {
		nsName = parts[3]
	}
	if len(parts) >= 5 {
		tableName = parts[4]
	}

	switch operation {
	case "CreateTableBucket":
		name := getString(body, "name")
		if name == "" {
			name = getString(body, "Name")
		}
		arn := fmt.Sprintf("arn:aws:s3tables:%s:%s:bucket/%s", region, accountID, name)
		bucket := &TableBucket{
			Name:      name,
			ARN:       arn,
			CreatedAt: time.Now(),
		}
		h.store.mu.Lock()
		h.store.buckets[name] = bucket
		h.store.mu.Unlock()
		sendJSON(w, 200, bucketDesc(bucket))

	case "DeleteTableBucket":
		h.store.mu.Lock()
		delete(h.store.buckets, bucketName)
		h.store.mu.Unlock()
		w.WriteHeader(204)

	case "GetTableBucket":
		h.store.mu.RLock()
		bucket := h.store.buckets[bucketName]
		h.store.mu.RUnlock()
		if bucket == nil {
			sendError(w, 404, "NotFoundException", "Table bucket not found: "+bucketName)
			return
		}
		sendJSON(w, 200, bucketDesc(bucket))

	case "ListTableBuckets":
		h.store.mu.RLock()
		var buckets []map[string]interface{}
		for _, b := range h.store.buckets {
			buckets = append(buckets, bucketDesc(b))
		}
		h.store.mu.RUnlock()
		if buckets == nil {
			buckets = []map[string]interface{}{}
		}
		sendJSON(w, 200, map[string]interface{}{"tableBuckets": buckets})

	case "CreateNamespace":
		name := getString(body, "namespace")
		if name == "" {
			// namespace may be in array form
			if nsArr, ok := body["namespace"].([]interface{}); ok && len(nsArr) > 0 {
				if s, ok := nsArr[0].(string); ok {
					name = s
				}
			}
		}
		key := bucketName + "/" + name
		ns := &Namespace{
			Name:      name,
			Bucket:    bucketName,
			CreatedAt: time.Now(),
		}
		h.store.mu.Lock()
		h.store.namespaces[key] = ns
		h.store.mu.Unlock()
		sendJSON(w, 200, nsDesc(ns))

	case "DeleteNamespace":
		key := bucketName + "/" + nsName
		h.store.mu.Lock()
		delete(h.store.namespaces, key)
		h.store.mu.Unlock()
		w.WriteHeader(204)

	case "ListNamespaces":
		prefix := bucketName + "/"
		h.store.mu.RLock()
		var namespaces []map[string]interface{}
		for key, ns := range h.store.namespaces {
			if strings.HasPrefix(key, prefix) {
				namespaces = append(namespaces, nsDesc(ns))
			}
		}
		h.store.mu.RUnlock()
		if namespaces == nil {
			namespaces = []map[string]interface{}{}
		}
		sendJSON(w, 200, map[string]interface{}{"namespaces": namespaces})

	case "CreateTable":
		name := getString(body, "name")
		if name == "" {
			name = getString(body, "Name")
		}
		ns := getString(body, "namespace")
		key := bucketName + "/" + ns + "/" + name
		arn := fmt.Sprintf("arn:aws:s3tables:%s:%s:bucket/%s/table/%s/%s", region, accountID, bucketName, ns, name)
		tbl := &Table{
			Name:      name,
			Namespace: ns,
			Bucket:    bucketName,
			ARN:       arn,
			TableType: "customer",
			CreatedAt: time.Now(),
		}
		h.store.mu.Lock()
		h.store.tables[key] = tbl
		h.store.mu.Unlock()
		sendJSON(w, 200, tableDesc(tbl))

	case "DeleteTable":
		key := bucketName + "/" + nsName + "/" + tableName
		h.store.mu.Lock()
		delete(h.store.tables, key)
		h.store.mu.Unlock()
		w.WriteHeader(204)

	case "GetTable":
		key := bucketName + "/" + nsName + "/" + tableName
		h.store.mu.RLock()
		tbl := h.store.tables[key]
		h.store.mu.RUnlock()
		if tbl == nil {
			sendError(w, 404, "NotFoundException", "Table not found: "+tableName)
			return
		}
		sendJSON(w, 200, tableDesc(tbl))

	case "ListTables":
		prefix := bucketName + "/"
		nsFilter := r.URL.Query().Get("namespace")
		h.store.mu.RLock()
		var tables []map[string]interface{}
		for key, tbl := range h.store.tables {
			if strings.HasPrefix(key, prefix) {
				if nsFilter == "" || tbl.Namespace == nsFilter {
					tables = append(tables, tableDesc(tbl))
				}
			}
		}
		h.store.mu.RUnlock()
		if tables == nil {
			tables = []map[string]interface{}{}
		}
		sendJSON(w, 200, map[string]interface{}{"tables": tables})

	default:
		sendError(w, 400, "ValidationException", "Unknown operation: "+operation)
	}
}
