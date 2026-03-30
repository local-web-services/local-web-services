package memorydb

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

type Cluster struct {
	Name        string
	Status      string
	NodeType    string
	Engine      string
	Description string
	ACLName     string
	CreatedAt   time.Time
}

type User struct {
	Name         string
	Status       string
	AccessString string
	CreatedAt    time.Time
}

type ACL struct {
	Name      string
	Status    string
	UserNames []string
	CreatedAt time.Time
}

type Snapshot struct {
	Name        string
	ClusterName string
	Status      string
	CreatedAt   time.Time
}

type Store struct {
	mu        sync.RWMutex
	clusters  map[string]*Cluster
	users     map[string]*User
	acls      map[string]*ACL
	snapshots map[string]*Snapshot
	tags      map[string]map[string]string // ARN → key → value
}

func NewStore() *Store {
	return &Store{
		clusters:  make(map[string]*Cluster),
		users:     make(map[string]*User),
		acls:      make(map[string]*ACL),
		snapshots: make(map[string]*Snapshot),
		tags:      make(map[string]map[string]string),
	}
}

func (s *Store) Reset() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.clusters = make(map[string]*Cluster)
	s.users = make(map[string]*User)
	s.acls = make(map[string]*ACL)
	s.snapshots = make(map[string]*Snapshot)
	s.tags = make(map[string]map[string]string)
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
	if strings.HasPrefix(target, "AmazonMemoryDB.") {
		operation = strings.TrimPrefix(target, "AmazonMemoryDB.")
	} else {
		parts := strings.SplitN(target, ".", 2)
		if len(parts) == 2 {
			operation = parts[1]
		}
	}

	if state.ApplyIAMAuth(h.state, "memorydb", operation, r, w, false) {
		return
	}
	if state.ApplyChaos(h.state, "memorydb", operation, w, false, false) {
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
	w.Header().Set("Content-Type", "application/x-amz-json-1.1")
	w.WriteHeader(200)
	json.NewEncoder(w).Encode(data) //nolint:errcheck
}

func writeErr(w http.ResponseWriter, code, msg string) {
	w.Header().Set("Content-Type", "application/x-amz-json-1.1")
	w.WriteHeader(400)
	fmt.Fprintf(w, `{"__type":%q,"message":%q}`+"\n", code, msg)
}

// arnExists checks if a MemoryDB resource ARN references an active resource.
// ARN format: arn:aws:memorydb:region:account:resource_type/name
func (h *Handler) arnExists(arn string) bool {
	if arn == "" {
		return false
	}
	parts := strings.SplitN(arn, ":", 6)
	if len(parts) < 6 {
		return false
	}
	resourcePart := parts[5]
	slashIdx := strings.Index(resourcePart, "/")
	if slashIdx < 0 {
		return false
	}
	resourceType := resourcePart[:slashIdx]
	resourceName := resourcePart[slashIdx+1:]
	h.store.mu.RLock()
	defer h.store.mu.RUnlock()
	switch resourceType {
	case "cluster":
		c := h.store.clusters[resourceName]
		return c != nil && c.Status != "deleting"
	case "user":
		u := h.store.users[resourceName]
		return u != nil && u.Status != "deleting"
	case "acl":
		a := h.store.acls[resourceName]
		return a != nil && a.Status != "deleting"
	case "snapshot":
		s := h.store.snapshots[resourceName]
		return s != nil && s.Status != "deleting"
	}
	return false
}

func getString(m map[string]interface{}, key string) string {
	if v, ok := m[key]; ok {
		if s, ok := v.(string); ok {
			return s
		}
	}
	return ""
}

func clusterDesc(c *Cluster) map[string]interface{} {
	return map[string]interface{}{
		"Name":          c.Name,
		"Status":        c.Status,
		"NodeType":      c.NodeType,
		"EngineVersion": c.Engine,
		"Description":   c.Description,
		"ACLName":       c.ACLName,
		"ARN":           fmt.Sprintf("arn:aws:memorydb:%s:%s:cluster/%s", region, accountID, c.Name),
	}
}

func userDesc(u *User) map[string]interface{} {
	return map[string]interface{}{
		"Name":         u.Name,
		"Status":       u.Status,
		"AccessString": u.AccessString,
		"ARN":          fmt.Sprintf("arn:aws:memorydb:%s:%s:user/%s", region, accountID, u.Name),
	}
}

func aclDesc(a *ACL) map[string]interface{} {
	return map[string]interface{}{
		"Name":      a.Name,
		"Status":    a.Status,
		"UserNames": a.UserNames,
		"ARN":       fmt.Sprintf("arn:aws:memorydb:%s:%s:acl/%s", region, accountID, a.Name),
	}
}

func snapshotDesc(s *Snapshot) map[string]interface{} {
	return map[string]interface{}{
		"Name":        s.Name,
		"ClusterName": s.ClusterName,
		"Status":      s.Status,
		"ARN":         fmt.Sprintf("arn:aws:memorydb:%s:%s:snapshot/%s", region, accountID, s.Name),
	}
}

func (h *Handler) handle(w http.ResponseWriter, operation string, body map[string]interface{}) {
	switch operation {
	case "CreateCluster":
		name := getString(body, "ClusterName")
		h.store.mu.Lock()
		if existing, exists := h.store.clusters[name]; exists && existing.Status != "deleting" {
			h.store.mu.Unlock()
			writeErr(w, "ClusterAlreadyExistsFault", "Cluster already exists: "+name)
			return
		}
		cluster := &Cluster{
			Name:        name,
			Status:      "creating",
			NodeType:    getString(body, "NodeType"),
			Engine:      getString(body, "EngineVersion"),
			Description: getString(body, "Description"),
			ACLName:     getString(body, "ACLName"),
			CreatedAt:   time.Now(),
		}
		h.store.clusters[name] = cluster
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"Cluster": clusterDesc(cluster)})

	case "DeleteCluster":
		name := getString(body, "ClusterName")
		h.store.mu.Lock()
		cluster := h.store.clusters[name]
		if cluster == nil {
			h.store.mu.Unlock()
			writeErr(w, "ClusterNotFoundFault", "Cluster not found: "+name)
			return
		}
		cluster.Status = "deleting"
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"Cluster": clusterDesc(cluster)})

	case "DescribeClusters":
		filterName := getString(body, "ClusterName")
		h.store.mu.RLock()
		var clusters []map[string]interface{}
		for _, c := range h.store.clusters {
			if filterName == "" || c.Name == filterName {
				clusters = append(clusters, clusterDesc(c))
			}
		}
		h.store.mu.RUnlock()
		if clusters == nil {
			clusters = []map[string]interface{}{}
		}
		writeOK(w, map[string]interface{}{"Clusters": clusters})

	case "CreateUser":
		name := getString(body, "UserName")
		h.store.mu.Lock()
		if existing, exists := h.store.users[name]; exists && existing.Status != "deleting" {
			h.store.mu.Unlock()
			writeErr(w, "UserAlreadyExistsFault", "User already exists: "+name)
			return
		}
		user := &User{
			Name:         name,
			Status:       "creating",
			AccessString: getString(body, "AccessString"),
			CreatedAt:    time.Now(),
		}
		h.store.users[name] = user
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"User": userDesc(user)})

	case "DeleteUser":
		name := getString(body, "UserName")
		h.store.mu.Lock()
		user := h.store.users[name]
		if user == nil {
			h.store.mu.Unlock()
			writeErr(w, "UserNotFoundFault", "User not found: "+name)
			return
		}
		user.Status = "deleting"
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"User": userDesc(user)})

	case "DescribeUsers":
		filterName := getString(body, "UserName")
		h.store.mu.RLock()
		var users []map[string]interface{}
		for _, u := range h.store.users {
			if filterName == "" || u.Name == filterName {
				users = append(users, userDesc(u))
			}
		}
		h.store.mu.RUnlock()
		if users == nil {
			users = []map[string]interface{}{}
		}
		writeOK(w, map[string]interface{}{"Users": users})

	case "CreateACL":
		name := getString(body, "ACLName")
		h.store.mu.Lock()
		if existing, exists := h.store.acls[name]; exists && existing.Status != "deleting" {
			h.store.mu.Unlock()
			writeErr(w, "ACLAlreadyExistsFault", "ACL already exists: "+name)
			return
		}
		acl := &ACL{
			Name:      name,
			Status:    "creating",
			UserNames: []string{},
			CreatedAt: time.Now(),
		}
		h.store.acls[name] = acl
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"ACL": aclDesc(acl)})

	case "DeleteACL":
		name := getString(body, "ACLName")
		h.store.mu.Lock()
		acl := h.store.acls[name]
		if acl == nil {
			h.store.mu.Unlock()
			writeErr(w, "ACLNotFoundFault", "ACL not found: "+name)
			return
		}
		acl.Status = "deleting"
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"ACL": aclDesc(acl)})

	case "DescribeACLs":
		filterName := getString(body, "ACLName")
		h.store.mu.RLock()
		var acls []map[string]interface{}
		for _, a := range h.store.acls {
			if filterName == "" || a.Name == filterName {
				acls = append(acls, aclDesc(a))
			}
		}
		h.store.mu.RUnlock()
		if acls == nil {
			acls = []map[string]interface{}{}
		}
		writeOK(w, map[string]interface{}{"ACLs": acls})

	case "CreateSnapshot":
		name := getString(body, "SnapshotName")
		clusterName := getString(body, "ClusterName")
		h.store.mu.Lock()
		cluster := h.store.clusters[clusterName]
		if cluster == nil || cluster.Status == "deleting" {
			h.store.mu.Unlock()
			writeErr(w, "ClusterNotFoundFault", "Cluster not found: "+clusterName)
			return
		}
		if existing, exists := h.store.snapshots[name]; exists && existing.Status != "deleting" {
			h.store.mu.Unlock()
			writeErr(w, "SnapshotAlreadyExistsFault", "Snapshot already exists: "+name)
			return
		}
		snap := &Snapshot{
			Name:        name,
			ClusterName: clusterName,
			Status:      "creating",
			CreatedAt:   time.Now(),
		}
		h.store.snapshots[name] = snap
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"Snapshot": snapshotDesc(snap)})

	case "DeleteSnapshot":
		name := getString(body, "SnapshotName")
		h.store.mu.Lock()
		snap := h.store.snapshots[name]
		if snap == nil {
			h.store.mu.Unlock()
			writeErr(w, "SnapshotNotFoundFault", "Snapshot not found: "+name)
			return
		}
		snap.Status = "deleting"
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"Snapshot": snapshotDesc(snap)})

	case "DescribeSnapshots":
		filterName := getString(body, "SnapshotName")
		clusterName := getString(body, "ClusterName")
		h.store.mu.RLock()
		var snaps []map[string]interface{}
		for _, s := range h.store.snapshots {
			if (filterName == "" || s.Name == filterName) &&
				(clusterName == "" || s.ClusterName == clusterName) {
				snaps = append(snaps, snapshotDesc(s))
			}
		}
		h.store.mu.RUnlock()
		if snaps == nil {
			snaps = []map[string]interface{}{}
		}
		writeOK(w, map[string]interface{}{"Snapshots": snaps})

	case "UpdateCluster":
		name := getString(body, "ClusterName")
		h.store.mu.Lock()
		cluster := h.store.clusters[name]
		if cluster == nil {
			h.store.mu.Unlock()
			writeErr(w, "ClusterNotFoundFault", "Cluster not found: "+name)
			return
		}
		if v := getString(body, "Description"); v != "" {
			cluster.Description = v
		}
		if v := getString(body, "NodeType"); v != "" {
			cluster.NodeType = v
		}
		if v := getString(body, "ACLName"); v != "" {
			acl := h.store.acls[v]
			if acl == nil || acl.Status == "deleting" {
				h.store.mu.Unlock()
				writeErr(w, "ACLNotFoundFault", "ACL not found: "+v)
				return
			}
			cluster.ACLName = v
		}
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"Cluster": clusterDesc(cluster)})

	case "UpdateUser":
		name := getString(body, "UserName")
		h.store.mu.Lock()
		user := h.store.users[name]
		if user == nil {
			h.store.mu.Unlock()
			writeErr(w, "UserNotFoundFault", "User not found: "+name)
			return
		}
		if v := getString(body, "AccessString"); v != "" {
			user.AccessString = v
		}
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"User": userDesc(user)})

	case "UpdateACL":
		name := getString(body, "ACLName")
		h.store.mu.Lock()
		acl := h.store.acls[name]
		if acl == nil {
			h.store.mu.Unlock()
			writeErr(w, "ACLNotFoundFault", "ACL not found: "+name)
			return
		}
		// Process UserNamesToAdd
		if toAdd, ok := body["UserNamesToAdd"].([]interface{}); ok {
			existing := make(map[string]bool, len(acl.UserNames))
			for _, u := range acl.UserNames {
				existing[u] = true
			}
			for _, v := range toAdd {
				uname, ok := v.(string)
				if !ok {
					continue
				}
				// Validate user exists
				user := h.store.users[uname]
				if user == nil || user.Status == "deleting" {
					h.store.mu.Unlock()
					writeErr(w, "UserNotFoundFault", "User not found: "+uname)
					return
				}
				// Reject if user is already a member
				if existing[uname] {
					h.store.mu.Unlock()
					writeErr(w, "DuplicateUserNameFault", "User already in ACL: "+uname)
					return
				}
				acl.UserNames = append(acl.UserNames, uname)
				existing[uname] = true
			}
		}
		// Process UserNamesToRemove
		if toRemove, ok := body["UserNamesToRemove"].([]interface{}); ok {
			memberSet := make(map[string]bool, len(acl.UserNames))
			for _, u := range acl.UserNames {
				memberSet[u] = true
			}
			removeSet := make(map[string]bool, len(toRemove))
			for _, v := range toRemove {
				if uname, ok := v.(string); ok {
					// Reject if user is not a member
					if !memberSet[uname] {
						h.store.mu.Unlock()
						writeErr(w, "UserNotFoundFault", "User not in ACL: "+uname)
						return
					}
					removeSet[uname] = true
				}
			}
			filtered := acl.UserNames[:0]
			for _, u := range acl.UserNames {
				if !removeSet[u] {
					filtered = append(filtered, u)
				}
			}
			acl.UserNames = filtered
		}
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"ACL": aclDesc(acl)})

	case "TagResource":
		arn := getString(body, "ResourceArn")
		if !h.arnExists(arn) {
			writeErr(w, "ResourceNotFoundException", "Resource not found: "+arn)
			return
		}
		h.store.mu.Lock()
		if h.store.tags[arn] == nil {
			h.store.tags[arn] = make(map[string]string)
		}
		if tags, ok := body["Tags"].([]interface{}); ok {
			for _, t := range tags {
				if tm, ok := t.(map[string]interface{}); ok {
					k, _ := tm["Key"].(string)
					v, _ := tm["Value"].(string)
					if k != "" {
						h.store.tags[arn][k] = v
					}
				}
			}
		}
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"TagList": []interface{}{}})

	case "UntagResource":
		arn := getString(body, "ResourceArn")
		if !h.arnExists(arn) {
			writeErr(w, "ResourceNotFoundException", "Resource not found: "+arn)
			return
		}
		h.store.mu.Lock()
		if keys, ok := body["TagKeys"].([]interface{}); ok && h.store.tags[arn] != nil {
			for _, k := range keys {
				if ks, ok := k.(string); ok {
					delete(h.store.tags[arn], ks)
				}
			}
		}
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"TagList": []interface{}{}})

	case "ListTags":
		arn := getString(body, "ResourceArn")
		if !h.arnExists(arn) {
			writeErr(w, "ResourceNotFoundException", "Resource not found: "+arn)
			return
		}
		h.store.mu.RLock()
		tagMap := h.store.tags[arn]
		var tagList []map[string]interface{}
		for k, v := range tagMap {
			tagList = append(tagList, map[string]interface{}{"Key": k, "Value": v})
		}
		h.store.mu.RUnlock()
		if tagList == nil {
			tagList = []map[string]interface{}{}
		}
		writeOK(w, map[string]interface{}{"TagList": tagList})

	default:
		writeErr(w, "InvalidAction", "Unknown operation: "+operation)
	}
}
