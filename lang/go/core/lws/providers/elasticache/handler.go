package elasticache

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"sync"
	"time"

	"github.com/local-web-services/local-web-services-go-core/lws/state"
)

const accountID = "000000000000"
const region = "us-east-1"

type CacheCluster struct {
	CacheClusterId     string
	CacheClusterStatus string
	Engine             string
	NumCacheNodes      int
	CreatedAt          time.Time
}

type ReplicationGroup struct {
	ReplicationGroupId       string
	Description              string
	Status                   string
	AutomaticFailover        string
	AtRestEncryptionEnabled  bool
	TransitEncryptionEnabled bool
	CreatedAt                time.Time
}

type CacheSubnetGroup struct {
	CacheSubnetGroupName        string
	CacheSubnetGroupDescription string
	VpcId                       string
	CreatedAt                   time.Time
}

type CacheSnapshot struct {
	SnapshotName   string
	CacheClusterId string
	Status         string
	Engine         string
	CreatedAt      time.Time
}

type Store struct {
	mu                sync.RWMutex
	clusters          map[string]*CacheCluster
	replicationGroups map[string]*ReplicationGroup
	subnetGroups      map[string]*CacheSubnetGroup
	snapshots         map[string]*CacheSnapshot
}

func NewStore() *Store {
	return &Store{
		clusters:          make(map[string]*CacheCluster),
		replicationGroups: make(map[string]*ReplicationGroup),
		subnetGroups:      make(map[string]*CacheSubnetGroup),
		snapshots:         make(map[string]*CacheSnapshot),
	}
}

func (s *Store) Reset() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.clusters = make(map[string]*CacheCluster)
	s.replicationGroups = make(map[string]*ReplicationGroup)
	s.subnetGroups = make(map[string]*CacheSubnetGroup)
	s.snapshots = make(map[string]*CacheSnapshot)
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
	body, _ := io.ReadAll(r.Body)
	params, _ := url.ParseQuery(string(body))
	action := params.Get("Action")

	if state.ApplyIAMAuth(h.state, "elasticache", action, r, w, true) {
		return
	}
	if state.ApplyChaos(h.state, "elasticache", action, w, true, false) {
		return
	}

	h.handle(w, action, params)
}

func sendJSON(w http.ResponseWriter, status int, v interface{}) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	json.NewEncoder(w).Encode(v) //nolint:errcheck
}

func sendError(w http.ResponseWriter, status int, code, msg string) {
	sendJSON(w, status, map[string]string{"__type": code, "message": msg})
}

func clusterDesc(c *CacheCluster) map[string]interface{} {
	return map[string]interface{}{
		"CacheClusterId":     c.CacheClusterId,
		"CacheClusterStatus": c.CacheClusterStatus,
		"Engine":             c.Engine,
		"NumCacheNodes":      c.NumCacheNodes,
		"CacheNodes": []map[string]interface{}{
			{
				"CacheNodeId":     "0001",
				"CacheNodeStatus": "available",
				"Endpoint": map[string]interface{}{
					"Address": "localhost",
					"Port":    6379,
				},
			},
		},
		"ARN": fmt.Sprintf("arn:aws:elasticache:%s:%s:cluster:%s", region, accountID, c.CacheClusterId),
	}
}

func rgDesc(rg *ReplicationGroup) map[string]interface{} {
	return map[string]interface{}{
		"ReplicationGroupId":       rg.ReplicationGroupId,
		"Description":              rg.Description,
		"Status":                   rg.Status,
		"AutomaticFailover":        rg.AutomaticFailover,
		"AtRestEncryptionEnabled":  rg.AtRestEncryptionEnabled,
		"TransitEncryptionEnabled": rg.TransitEncryptionEnabled,
		"ARN":                      fmt.Sprintf("arn:aws:elasticache:%s:%s:replicationgroup:%s", region, accountID, rg.ReplicationGroupId),
	}
}

func subnetGroupDesc(sg *CacheSubnetGroup) map[string]interface{} {
	return map[string]interface{}{
		"CacheSubnetGroupName":        sg.CacheSubnetGroupName,
		"CacheSubnetGroupDescription": sg.CacheSubnetGroupDescription,
		"VpcId":                       sg.VpcId,
		"ARN":                         fmt.Sprintf("arn:aws:elasticache:%s:%s:subnetgroup:%s", region, accountID, sg.CacheSubnetGroupName),
	}
}

func snapshotDesc(s *CacheSnapshot) map[string]interface{} {
	return map[string]interface{}{
		"SnapshotName":   s.SnapshotName,
		"CacheClusterId": s.CacheClusterId,
		"SnapshotStatus": s.Status,
		"Engine":         s.Engine,
		"ARN":            fmt.Sprintf("arn:aws:elasticache:%s:%s:snapshot:%s", region, accountID, s.SnapshotName),
	}
}

func (h *Handler) handle(w http.ResponseWriter, action string, params url.Values) {
	switch action {
	case "CreateCacheCluster":
		id := params.Get("CacheClusterId")
		engine := params.Get("Engine")
		if engine == "" {
			engine = "redis"
		}
		cluster := &CacheCluster{
			CacheClusterId:     id,
			CacheClusterStatus: "available",
			Engine:             engine,
			NumCacheNodes:      1,
			CreatedAt:          time.Now(),
		}
		h.store.mu.Lock()
		h.store.clusters[id] = cluster
		h.store.mu.Unlock()
		sendJSON(w, 200, map[string]interface{}{"CacheCluster": clusterDesc(cluster)})

	case "DeleteCacheCluster":
		id := params.Get("CacheClusterId")
		h.store.mu.Lock()
		cluster := h.store.clusters[id]
		delete(h.store.clusters, id)
		h.store.mu.Unlock()
		if cluster == nil {
			sendError(w, 404, "CacheClusterNotFound", "Cache cluster not found: "+id)
			return
		}
		sendJSON(w, 200, map[string]interface{}{"CacheCluster": clusterDesc(cluster)})

	case "DescribeCacheClusters":
		filterID := params.Get("CacheClusterId")
		h.store.mu.RLock()
		var clusters []map[string]interface{}
		for _, c := range h.store.clusters {
			if filterID == "" || c.CacheClusterId == filterID {
				clusters = append(clusters, clusterDesc(c))
			}
		}
		h.store.mu.RUnlock()
		if clusters == nil {
			clusters = []map[string]interface{}{}
		}
		sendJSON(w, 200, map[string]interface{}{"CacheClusters": clusters})

	case "CreateReplicationGroup":
		id := params.Get("ReplicationGroupId")
		rg := &ReplicationGroup{
			ReplicationGroupId: id,
			Description:        params.Get("ReplicationGroupDescription"),
			Status:             "available",
			AutomaticFailover:  "disabled",
			CreatedAt:          time.Now(),
		}
		h.store.mu.Lock()
		h.store.replicationGroups[id] = rg
		h.store.mu.Unlock()
		sendJSON(w, 200, map[string]interface{}{"ReplicationGroup": rgDesc(rg)})

	case "DeleteReplicationGroup":
		id := params.Get("ReplicationGroupId")
		h.store.mu.Lock()
		rg := h.store.replicationGroups[id]
		delete(h.store.replicationGroups, id)
		h.store.mu.Unlock()
		if rg == nil {
			sendError(w, 404, "ReplicationGroupNotFoundFault", "Replication group not found: "+id)
			return
		}
		sendJSON(w, 200, map[string]interface{}{"ReplicationGroup": rgDesc(rg)})

	case "DescribeReplicationGroups":
		filterID := params.Get("ReplicationGroupId")
		h.store.mu.RLock()
		var groups []map[string]interface{}
		for _, rg := range h.store.replicationGroups {
			if filterID == "" || rg.ReplicationGroupId == filterID {
				groups = append(groups, rgDesc(rg))
			}
		}
		h.store.mu.RUnlock()
		if groups == nil {
			groups = []map[string]interface{}{}
		}
		sendJSON(w, 200, map[string]interface{}{"ReplicationGroups": groups})

	case "CreateCacheSubnetGroup":
		name := params.Get("CacheSubnetGroupName")
		sg := &CacheSubnetGroup{
			CacheSubnetGroupName:        name,
			CacheSubnetGroupDescription: params.Get("CacheSubnetGroupDescription"),
			VpcId:                       "vpc-00000000",
			CreatedAt:                   time.Now(),
		}
		h.store.mu.Lock()
		h.store.subnetGroups[name] = sg
		h.store.mu.Unlock()
		sendJSON(w, 200, map[string]interface{}{"CacheSubnetGroup": subnetGroupDesc(sg)})

	case "DeleteCacheSubnetGroup":
		name := params.Get("CacheSubnetGroupName")
		h.store.mu.Lock()
		sg := h.store.subnetGroups[name]
		delete(h.store.subnetGroups, name)
		h.store.mu.Unlock()
		if sg == nil {
			sendError(w, 404, "CacheSubnetGroupNotFoundFault", "Cache subnet group not found: "+name)
			return
		}
		sendJSON(w, 200, map[string]interface{}{})

	case "DescribeCacheSubnetGroups":
		filterName := params.Get("CacheSubnetGroupName")
		h.store.mu.RLock()
		var groups []map[string]interface{}
		for _, sg := range h.store.subnetGroups {
			if filterName == "" || sg.CacheSubnetGroupName == filterName {
				groups = append(groups, subnetGroupDesc(sg))
			}
		}
		h.store.mu.RUnlock()
		if groups == nil {
			groups = []map[string]interface{}{}
		}
		sendJSON(w, 200, map[string]interface{}{"CacheSubnetGroups": groups})

	case "ModifyCacheCluster":
		id := params.Get("CacheClusterId")
		h.store.mu.Lock()
		cluster := h.store.clusters[id]
		h.store.mu.Unlock()
		if cluster == nil {
			sendError(w, 404, "CacheClusterNotFound", "Cache cluster not found: "+id)
			return
		}
		sendJSON(w, 200, map[string]interface{}{"CacheCluster": clusterDesc(cluster)})

	case "ModifyReplicationGroup":
		id := params.Get("ReplicationGroupId")
		h.store.mu.Lock()
		rg := h.store.replicationGroups[id]
		h.store.mu.Unlock()
		if rg == nil {
			sendError(w, 404, "ReplicationGroupNotFoundFault", "Replication group not found: "+id)
			return
		}
		sendJSON(w, 200, map[string]interface{}{"ReplicationGroup": rgDesc(rg)})

	case "CreateSnapshot":
		snapName := params.Get("SnapshotName")
		clusterID := params.Get("CacheClusterId")
		engine := "redis"
		h.store.mu.RLock()
		if c := h.store.clusters[clusterID]; c != nil {
			engine = c.Engine
		}
		h.store.mu.RUnlock()
		snap := &CacheSnapshot{
			SnapshotName:   snapName,
			CacheClusterId: clusterID,
			Status:         "available",
			Engine:         engine,
			CreatedAt:      time.Now(),
		}
		h.store.mu.Lock()
		h.store.snapshots[snapName] = snap
		h.store.mu.Unlock()
		sendJSON(w, 200, map[string]interface{}{"Snapshot": snapshotDesc(snap)})

	case "DeleteSnapshot":
		snapName := params.Get("SnapshotName")
		h.store.mu.Lock()
		snap := h.store.snapshots[snapName]
		delete(h.store.snapshots, snapName)
		h.store.mu.Unlock()
		if snap == nil {
			sendError(w, 404, "SnapshotNotFoundFault", "Snapshot not found: "+snapName)
			return
		}
		sendJSON(w, 200, map[string]interface{}{"Snapshot": snapshotDesc(snap)})

	case "DescribeSnapshots":
		filterName := params.Get("SnapshotName")
		clusterFilter := params.Get("CacheClusterId")
		h.store.mu.RLock()
		var snaps []map[string]interface{}
		for _, s := range h.store.snapshots {
			if (filterName == "" || s.SnapshotName == filterName) &&
				(clusterFilter == "" || s.CacheClusterId == clusterFilter) {
				snaps = append(snaps, snapshotDesc(s))
			}
		}
		h.store.mu.RUnlock()
		if snaps == nil {
			snaps = []map[string]interface{}{}
		}
		sendJSON(w, 200, map[string]interface{}{"Snapshots": snaps})

	case "AddTagsToResource", "RemoveTagsFromResource", "ListTagsForResource":
		// No-op: tags accepted but not stored in this simplified implementation.
		sendJSON(w, 200, map[string]interface{}{"TagList": []interface{}{}})

	default:
		sendError(w, 400, "InvalidAction", "Unknown action: "+action)
	}
}
