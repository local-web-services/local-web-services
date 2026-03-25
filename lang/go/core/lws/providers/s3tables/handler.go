package s3tables

import (
	"encoding/json"
	"fmt"
	"net/http"
	"net/url"
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
	BucketARN string
	CreatedAt time.Time
}

type Table struct {
	Name      string
	Namespace string
	BucketARN string
	ARN       string
	TableType string
	CreatedAt time.Time
}

type Store struct {
	mu         sync.RWMutex
	buckets    map[string]*TableBucket // key: bucketARN
	namespaces map[string]*Namespace   // key: bucketARN/namespaceName
	tables     map[string]*Table       // key: bucketARN/namespace/tableName
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

// decodedPath returns the URL-decoded path, using RawPath if available.
func decodedPath(r *http.Request) string {
	if r.URL.RawPath != "" {
		decoded, err := url.PathUnescape(r.URL.RawPath)
		if err == nil {
			return decoded
		}
	}
	return r.URL.Path
}

// routeOperation determines the S3 Tables operation from method + decoded path.
//
// The AWS S3 Tables REST API uses these paths:
//
//	POST   /buckets                                       → CreateTableBucket
//	GET    /buckets                                       → ListTableBuckets
//	DELETE /buckets/{tableBucketARN}                      → DeleteTableBucket
//	GET    /buckets/{tableBucketARN}                      → GetTableBucket
//	POST   /namespaces/{tableBucketARN}                   → CreateNamespace
//	GET    /namespaces/{tableBucketARN}                   → ListNamespaces
//	DELETE /namespaces/{tableBucketARN}/{namespace}       → DeleteNamespace
//	POST   /tables/{tableBucketARN}/{namespace}           → CreateTable
//	GET    /tables/{tableBucketARN}/{namespace}           → ListTables
//	DELETE /tables/{tableBucketARN}/{namespace}/{name}    → DeleteTable
//	GET    /tables/{tableBucketARN}/{namespace}/{name}    → GetTable
//
// The tableBucketARN is a full ARN like
// arn:aws:s3tables:us-east-1:000000000000:bucket/test — the ARN itself
// contains a "/" so when decoded the path has many segments.  We therefore
// look only at the first path segment to determine the resource type.
func (h *Handler) routeOperation(method, path string) string {
	// Trim leading slash and split on first "/"
	path = strings.TrimPrefix(path, "/")
	idx := strings.IndexByte(path, '/')
	var first, rest string
	if idx < 0 {
		first = path
	} else {
		first = path[:idx]
		rest = path[idx+1:]
	}

	switch first {
	case "buckets":
		if rest == "" {
			switch method {
			case http.MethodPost:
				return "CreateTableBucket"
			case http.MethodGet:
				return "ListTableBuckets"
			}
		} else {
			// rest could be "<arn>" or "<arn>/..." but since ARN has slashes
			// we must check if there's a trailing resource segment after the ARN.
			// The ARN format is arn:aws:s3tables:<region>:<account>:bucket/<name>
			// so the full rest is just the ARN (no additional segments for bucket ops).
			switch method {
			case http.MethodDelete:
				return "DeleteTableBucket"
			case http.MethodGet:
				return "GetTableBucket"
			}
		}
	case "namespaces":
		// rest = "<tableBucketARN>" or "<tableBucketARN>/<namespace>"
		// The ARN itself ends with "bucket/<bucketName>". A namespace segment would
		// follow after that. We detect this by checking if rest has 6 slash-separated
		// segments (ARN = "arn:aws:s3tables:<r>:<a>:bucket/<name>") vs 7 (with namespace).
		parts := strings.Split(rest, "/")
		// ARN has exactly 6 parts when split by "/":
		// [0]=arn, [1]=aws, [2]=s3tables, [3]=<region>, [4]=<account>:<bucket>, [5]=<bucketName>, but wait
		// actually "arn:aws:s3tables:us-east-1:000000000000:bucket/name" split by "/" gives:
		// ["arn:aws:s3tables:us-east-1:000000000000:bucket", "name"]
		// So when the ARN is in the path, parts has 2 elements for just an ARN.
		// With a namespace appended: parts has 3 elements.
		if len(parts) == 2 {
			// Just bucket ARN (the ARN "bucket/name" gives 2 parts)
			switch method {
			case http.MethodPost:
				return "CreateNamespace"
			case http.MethodGet:
				return "ListNamespaces"
			}
		} else if len(parts) == 3 {
			// Bucket ARN + namespace
			if method == http.MethodDelete {
				return "DeleteNamespace"
			}
		}
	case "tables":
		parts := strings.Split(rest, "/")
		// ARN "bucket/name" = 2 parts
		// with namespace = 3 parts
		// with namespace+table = 4 parts
		// with namespace+table+sub-resource = 5 parts
		if len(parts) == 2 {
			// /tables/{tableBucketARN} → ListTables
			if method == http.MethodGet {
				return "ListTables"
			}
		} else if len(parts) == 3 {
			// /tables/{tableBucketARN}/{namespace} → CreateTable
			if method == http.MethodPost {
				return "CreateTable"
			}
		} else if len(parts) == 4 {
			// /tables/{tableBucketARN}/{namespace}/{name}
			switch method {
			case http.MethodDelete:
				return "DeleteTable"
			case http.MethodGet:
				return "GetTable"
			}
		} else if len(parts) == 5 {
			// /tables/{tableBucketARN}/{namespace}/{name}/{sub-resource}
			// e.g. policy, maintenance-job-status
			switch method {
			case http.MethodGet:
				return "GetTableSubResource"
			case http.MethodPut:
				return "PutTableSubResource"
			case http.MethodDelete:
				return "DeleteTableSubResource"
			}
		}
	case "get-table":
		// /get-table?tableBucketARN=...&namespace=...&name=...
		if method == http.MethodGet {
			return "GetTable"
		}
	}
	return "Unknown"
}

// extractBucketARNAndRest parses the path after the first segment.
// For /namespaces/<bucketARN>/<namespace>, it returns (bucketARN, namespace, "").
// For /tables/<bucketARN>/<namespace>/<table>, it returns (bucketARN, namespace, table).
// The bucketARN format is "arn:aws:s3tables:<r>:<acct>:bucket/<name>" which when
// embedded in a path looks like ".../arn:aws:s3tables:r:acct:bucket/name/...".
// We reconstruct the ARN by joining the first 2 slash-separated parts of rest
// (the ARN portion: "arn:aws:s3tables:r:acct:bucket" + "/" + "<name>").
func extractBucketARNAndRest(rest string) (bucketARN, seg1, seg2 string) {
	// rest = "<arn-prefix>/<bucketName>[/<namespace>[/<table>]]"
	// The ARN prefix up to the last colon looks like "arn:aws:s3tables:r:acct:bucket"
	// Then "/" bucketName.
	// So the first '/' separates the ARN prefix from the bucket name.
	// The ARN is everything up to (and including) the bucket name.
	// Format: "arn:aws:s3tables:<region>:<acct>:bucket" + "/" + "<name>" = 2 parts.
	parts := strings.SplitN(rest, "/", 4) // max 4 parts: arnPrefix, bucketName, [ns, [table]]
	if len(parts) < 2 {
		return rest, "", ""
	}
	bucketARN = parts[0] + "/" + parts[1]
	if len(parts) >= 3 {
		seg1 = parts[2]
	}
	if len(parts) >= 4 {
		seg2 = parts[3]
	}
	return
}

func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	path := decodedPath(r)
	operation := h.routeOperation(r.Method, path)

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

	h.handle(w, r, operation, path, body)
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
		"namespace": []string{ns.Name},
		"createdAt": ns.CreatedAt.Format(time.RFC3339),
	}
}

func tableDesc(t *Table) map[string]interface{} {
	return map[string]interface{}{
		"name":           t.Name,
		"namespace":      t.Namespace,
		"tableBucketARN": t.BucketARN,
		"arn":            t.ARN,
		"type":           t.TableType,
		"createdAt":      t.CreatedAt.Format(time.RFC3339),
	}
}

// restAfterFirstSegment returns the path after the first "/" segment.
func restAfterFirstSegment(path string) string {
	path = strings.TrimPrefix(path, "/")
	idx := strings.IndexByte(path, '/')
	if idx < 0 {
		return ""
	}
	return path[idx+1:]
}

func (h *Handler) handle(w http.ResponseWriter, r *http.Request, operation, path string, body map[string]interface{}) {
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
		h.store.buckets[arn] = bucket
		h.store.mu.Unlock()
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

	case "GetTableBucket":
		rest := restAfterFirstSegment(path)
		bucketARN := rest // rest is the full ARN
		h.store.mu.RLock()
		bucket := h.store.buckets[bucketARN]
		h.store.mu.RUnlock()
		if bucket == nil {
			sendError(w, 404, "NotFoundException", "Table bucket not found: "+bucketARN)
			return
		}
		sendJSON(w, 200, bucketDesc(bucket))

	case "DeleteTableBucket":
		rest := restAfterFirstSegment(path)
		bucketARN := rest
		h.store.mu.Lock()
		bucket := h.store.buckets[bucketARN]
		delete(h.store.buckets, bucketARN)
		h.store.mu.Unlock()
		if bucket == nil {
			sendError(w, 404, "NotFoundException", "Table bucket not found: "+bucketARN)
			return
		}
		w.WriteHeader(204)

	case "CreateNamespace":
		rest := restAfterFirstSegment(path)
		bucketARN, _, _ := extractBucketARNAndRest(rest)
		h.store.mu.RLock()
		bucket := h.store.buckets[bucketARN]
		h.store.mu.RUnlock()
		if bucket == nil {
			sendError(w, 404, "NotFoundException", "Table bucket not found: "+bucketARN)
			return
		}
		name := ""
		if nsArr, ok := body["namespace"].([]interface{}); ok && len(nsArr) > 0 {
			if s, ok := nsArr[0].(string); ok {
				name = s
			}
		}
		if name == "" {
			name = getString(body, "namespace")
		}
		key := bucketARN + "/" + name
		ns := &Namespace{
			Name:      name,
			BucketARN: bucketARN,
			CreatedAt: time.Now(),
		}
		h.store.mu.Lock()
		h.store.namespaces[key] = ns
		h.store.mu.Unlock()
		sendJSON(w, 200, nsDesc(ns))

	case "ListNamespaces":
		rest := restAfterFirstSegment(path)
		bucketARN, _, _ := extractBucketARNAndRest(rest)
		prefix := bucketARN + "/"
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

	case "DeleteNamespace":
		rest := restAfterFirstSegment(path)
		bucketARN, nsName, _ := extractBucketARNAndRest(rest)
		key := bucketARN + "/" + nsName
		h.store.mu.Lock()
		delete(h.store.namespaces, key)
		h.store.mu.Unlock()
		w.WriteHeader(204)

	case "CreateTable":
		rest := restAfterFirstSegment(path)
		bucketARN, nsName, _ := extractBucketARNAndRest(rest)
		h.store.mu.RLock()
		bucket := h.store.buckets[bucketARN]
		h.store.mu.RUnlock()
		if bucket == nil {
			sendError(w, 404, "NotFoundException", "Table bucket not found: "+bucketARN)
			return
		}
		name := getString(body, "name")
		if name == "" {
			name = getString(body, "Name")
		}
		key := bucketARN + "/" + nsName + "/" + name
		arn := fmt.Sprintf("%s/table/%s/%s", bucketARN, nsName, name)
		tbl := &Table{
			Name:      name,
			Namespace: nsName,
			BucketARN: bucketARN,
			ARN:       arn,
			TableType: "customer",
			CreatedAt: time.Now(),
		}
		h.store.mu.Lock()
		h.store.tables[key] = tbl
		h.store.mu.Unlock()
		sendJSON(w, 200, tableDesc(tbl))

	case "ListTables":
		rest := restAfterFirstSegment(path)
		bucketARN, _, _ := extractBucketARNAndRest(rest)
		nsFilter := r.URL.Query().Get("namespace")
		prefix := bucketARN + "/"
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

	case "GetTable":
		// GetTable can be called via /get-table?tableBucketARN=...&namespace=...&name=...
		// or via /tables/{tableBucketARN}/{namespace}/{name}
		var bucketARN, nsName, tableName string
		if strings.HasPrefix(path, "/get-table") {
			bucketARN = r.URL.Query().Get("tableBucketARN")
			nsName = r.URL.Query().Get("namespace")
			tableName = r.URL.Query().Get("name")
		} else {
			rest := restAfterFirstSegment(path)
			bucketARN, nsName, tableName = extractBucketARNAndRest(rest)
		}
		key := bucketARN + "/" + nsName + "/" + tableName
		h.store.mu.RLock()
		tbl := h.store.tables[key]
		h.store.mu.RUnlock()
		if tbl == nil {
			sendError(w, 404, "NotFoundException", "Table not found: "+tableName)
			return
		}
		sendJSON(w, 200, tableDesc(tbl))

	case "DeleteTable":
		rest := restAfterFirstSegment(path)
		bucketARN, nsName, tableName := extractBucketARNAndRest(rest)
		key := bucketARN + "/" + nsName + "/" + tableName
		h.store.mu.Lock()
		delete(h.store.tables, key)
		h.store.mu.Unlock()
		w.WriteHeader(204)

	case "GetTableSubResource":
		// No-op: return empty response for policy, maintenance-job-status, etc.
		sendJSON(w, 200, map[string]interface{}{})

	case "PutTableSubResource":
		// No-op: accept and ignore sub-resource PUT (policy, maintenance config, etc.)
		w.WriteHeader(204)

	case "DeleteTableSubResource":
		// No-op: accept and ignore sub-resource DELETE (policy, etc.)
		w.WriteHeader(204)

	default:
		sendError(w, 400, "ValidationException", "Unknown operation: "+operation)
	}
}
