package elasticache

import (
	"encoding/xml"
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

func sendXML(w http.ResponseWriter, status int, v interface{}) {
	w.Header().Set("Content-Type", "text/xml")
	w.WriteHeader(status)
	io.WriteString(w, xml.Header) //nolint:errcheck
	xml.NewEncoder(w).Encode(v)   //nolint:errcheck
}

func sendError(w http.ResponseWriter, status int, code, msg string) {
	type xmlError struct {
		XMLName   xml.Name `xml:"ErrorResponse"`
		Code      string   `xml:"Error>Code"`
		Message   string   `xml:"Error>Message"`
		RequestID string   `xml:"RequestId"`
	}
	sendXML(w, status, xmlError{Code: code, Message: msg, RequestID: "00000000-0000-0000-0000-000000000000"})
}

// XML types for CacheCluster

type xmlCacheNode struct {
	CacheNodeId     string      `xml:"CacheNodeId"`
	CacheNodeStatus string      `xml:"CacheNodeStatus"`
	Endpoint        xmlEndpoint `xml:"Endpoint"`
}

type xmlEndpoint struct {
	Address string `xml:"Address"`
	Port    int    `xml:"Port"`
}

type xmlCacheCluster struct {
	CacheClusterId     string         `xml:"CacheClusterId"`
	CacheClusterStatus string         `xml:"CacheClusterStatus"`
	Engine             string         `xml:"Engine"`
	NumCacheNodes      int            `xml:"NumCacheNodes"`
	CacheNodes         []xmlCacheNode `xml:"CacheNodes>CacheNode"`
	ARN                string         `xml:"ARN"`
}

type xmlReplicationGroup struct {
	ReplicationGroupId       string `xml:"ReplicationGroupId"`
	Description              string `xml:"Description"`
	Status                   string `xml:"Status"`
	AutomaticFailover        string `xml:"AutomaticFailover"`
	AtRestEncryptionEnabled  bool   `xml:"AtRestEncryptionEnabled"`
	TransitEncryptionEnabled bool   `xml:"TransitEncryptionEnabled"`
	ARN                      string `xml:"ARN"`
}

type xmlCacheSubnetGroup struct {
	CacheSubnetGroupName        string `xml:"CacheSubnetGroupName"`
	CacheSubnetGroupDescription string `xml:"CacheSubnetGroupDescription"`
	VpcId                       string `xml:"VpcId"`
	ARN                         string `xml:"ARN"`
}

type xmlSnapshot struct {
	SnapshotName   string `xml:"SnapshotName"`
	CacheClusterId string `xml:"CacheClusterId"`
	SnapshotStatus string `xml:"SnapshotStatus"`
	Engine         string `xml:"Engine"`
	ARN            string `xml:"ARN"`
}

func clusterToXML(c *CacheCluster) xmlCacheCluster {
	return xmlCacheCluster{
		CacheClusterId:     c.CacheClusterId,
		CacheClusterStatus: c.CacheClusterStatus,
		Engine:             c.Engine,
		NumCacheNodes:      c.NumCacheNodes,
		CacheNodes: []xmlCacheNode{
			{
				CacheNodeId:     "0001",
				CacheNodeStatus: "available",
				Endpoint: xmlEndpoint{
					Address: "localhost",
					Port:    6379,
				},
			},
		},
		ARN: fmt.Sprintf("arn:aws:elasticache:%s:%s:cluster:%s", region, accountID, c.CacheClusterId),
	}
}

func rgToXML(rg *ReplicationGroup) xmlReplicationGroup {
	return xmlReplicationGroup{
		ReplicationGroupId:       rg.ReplicationGroupId,
		Description:              rg.Description,
		Status:                   rg.Status,
		AutomaticFailover:        rg.AutomaticFailover,
		AtRestEncryptionEnabled:  rg.AtRestEncryptionEnabled,
		TransitEncryptionEnabled: rg.TransitEncryptionEnabled,
		ARN:                      fmt.Sprintf("arn:aws:elasticache:%s:%s:replicationgroup:%s", region, accountID, rg.ReplicationGroupId),
	}
}

func subnetGroupToXML(sg *CacheSubnetGroup) xmlCacheSubnetGroup {
	return xmlCacheSubnetGroup{
		CacheSubnetGroupName:        sg.CacheSubnetGroupName,
		CacheSubnetGroupDescription: sg.CacheSubnetGroupDescription,
		VpcId:                       sg.VpcId,
		ARN:                         fmt.Sprintf("arn:aws:elasticache:%s:%s:subnetgroup:%s", region, accountID, sg.CacheSubnetGroupName),
	}
}

func snapshotToXML(s *CacheSnapshot) xmlSnapshot {
	return xmlSnapshot{
		SnapshotName:   s.SnapshotName,
		CacheClusterId: s.CacheClusterId,
		SnapshotStatus: s.Status,
		Engine:         s.Engine,
		ARN:            fmt.Sprintf("arn:aws:elasticache:%s:%s:snapshot:%s", region, accountID, s.SnapshotName),
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
		if h.state.GetCapacityRule("elasticache").IsExhausted() {
			sendError(w, 400, "ServiceLinkedRoleNotFoundFault", "No cluster slot is available")
			return
		}
		h.store.mu.Lock()
		if existing, exists := h.store.clusters[id]; exists && existing.CacheClusterStatus != "deleting" {
			h.store.mu.Unlock()
			sendError(w, 400, "CacheClusterAlreadyExistsFault", "Cache cluster already exists: "+id)
			return
		}
		cluster := &CacheCluster{
			CacheClusterId:     id,
			CacheClusterStatus: "available",
			Engine:             engine,
			NumCacheNodes:      1,
			CreatedAt:          time.Now(),
		}
		h.store.clusters[id] = cluster
		h.store.mu.Unlock()
		type createCacheClusterResp struct {
			XMLName xml.Name        `xml:"CreateCacheClusterResponse"`
			Result  xmlCacheCluster `xml:"CreateCacheClusterResult>CacheCluster"`
		}
		sendXML(w, 200, createCacheClusterResp{Result: clusterToXML(cluster)})

	case "DeleteCacheCluster":
		id := params.Get("CacheClusterId")
		h.store.mu.Lock()
		cluster := h.store.clusters[id]
		if cluster == nil {
			h.store.mu.Unlock()
			sendError(w, 404, "CacheClusterNotFound", "Cache cluster not found: "+id)
			return
		}
		cluster.CacheClusterStatus = "deleting"
		h.store.mu.Unlock()
		type deleteCacheClusterResp struct {
			XMLName xml.Name        `xml:"DeleteCacheClusterResponse"`
			Result  xmlCacheCluster `xml:"DeleteCacheClusterResult>CacheCluster"`
		}
		sendXML(w, 200, deleteCacheClusterResp{Result: clusterToXML(cluster)})

	case "DescribeCacheClusters":
		filterID := params.Get("CacheClusterId")
		h.store.mu.RLock()
		var clusters []xmlCacheCluster
		for _, c := range h.store.clusters {
			if filterID == "" || c.CacheClusterId == filterID {
				clusters = append(clusters, clusterToXML(c))
			}
		}
		h.store.mu.RUnlock()
		if clusters == nil {
			clusters = []xmlCacheCluster{}
		}
		type describeCacheClustersResp struct {
			XMLName  xml.Name          `xml:"DescribeCacheClustersResponse"`
			Clusters []xmlCacheCluster `xml:"DescribeCacheClustersResult>CacheClusters>CacheCluster"`
		}
		sendXML(w, 200, describeCacheClustersResp{Clusters: clusters})

	case "ModifyCacheCluster":
		id := params.Get("CacheClusterId")
		h.store.mu.Lock()
		cluster := h.store.clusters[id]
		if cluster == nil {
			h.store.mu.Unlock()
			sendError(w, 404, "CacheClusterNotFound", "Cache cluster not found: "+id)
			return
		}
		h.store.mu.Unlock()
		type modifyCacheClusterResp struct {
			XMLName xml.Name        `xml:"ModifyCacheClusterResponse"`
			Result  xmlCacheCluster `xml:"ModifyCacheClusterResult>CacheCluster"`
		}
		sendXML(w, 200, modifyCacheClusterResp{Result: clusterToXML(cluster)})

	case "CreateReplicationGroup":
		id := params.Get("ReplicationGroupId")
		h.store.mu.Lock()
		if existing, exists := h.store.replicationGroups[id]; exists && existing.Status != "deleting" {
			h.store.mu.Unlock()
			sendError(w, 400, "ReplicationGroupAlreadyExistsFault", "Replication group already exists: "+id)
			return
		}
		rg := &ReplicationGroup{
			ReplicationGroupId: id,
			Description:        params.Get("ReplicationGroupDescription"),
			Status:             "available",
			AutomaticFailover:  "disabled",
			CreatedAt:          time.Now(),
		}
		h.store.replicationGroups[id] = rg
		h.store.mu.Unlock()
		type createRGResp struct {
			XMLName xml.Name            `xml:"CreateReplicationGroupResponse"`
			Result  xmlReplicationGroup `xml:"CreateReplicationGroupResult>ReplicationGroup"`
		}
		sendXML(w, 200, createRGResp{Result: rgToXML(rg)})

	case "DeleteReplicationGroup":
		id := params.Get("ReplicationGroupId")
		h.store.mu.Lock()
		rg := h.store.replicationGroups[id]
		if rg == nil {
			h.store.mu.Unlock()
			sendError(w, 404, "ReplicationGroupNotFoundFault", "Replication group not found: "+id)
			return
		}
		rg.Status = "deleting"
		h.store.mu.Unlock()
		type deleteRGResp struct {
			XMLName xml.Name            `xml:"DeleteReplicationGroupResponse"`
			Result  xmlReplicationGroup `xml:"DeleteReplicationGroupResult>ReplicationGroup"`
		}
		sendXML(w, 200, deleteRGResp{Result: rgToXML(rg)})

	case "DescribeReplicationGroups":
		filterID := params.Get("ReplicationGroupId")
		h.store.mu.RLock()
		var groups []xmlReplicationGroup
		for _, rg := range h.store.replicationGroups {
			if filterID == "" || rg.ReplicationGroupId == filterID {
				groups = append(groups, rgToXML(rg))
			}
		}
		h.store.mu.RUnlock()
		if groups == nil {
			groups = []xmlReplicationGroup{}
		}
		type describeRGResp struct {
			XMLName xml.Name              `xml:"DescribeReplicationGroupsResponse"`
			Groups  []xmlReplicationGroup `xml:"DescribeReplicationGroupsResult>ReplicationGroups>ReplicationGroup"`
		}
		sendXML(w, 200, describeRGResp{Groups: groups})

	case "ModifyReplicationGroup":
		id := params.Get("ReplicationGroupId")
		h.store.mu.Lock()
		rg := h.store.replicationGroups[id]
		if rg == nil {
			h.store.mu.Unlock()
			sendError(w, 404, "ReplicationGroupNotFoundFault", "Replication group not found: "+id)
			return
		}
		h.store.mu.Unlock()
		if h.state.GetCapacityRule("elasticache").IsExhausted() {
			sendError(w, 400, "ServiceLinkedRoleNotFoundFault", "No cluster slot is available")
			return
		}
		type modifyRGResp struct {
			XMLName xml.Name            `xml:"ModifyReplicationGroupResponse"`
			Result  xmlReplicationGroup `xml:"ModifyReplicationGroupResult>ReplicationGroup"`
		}
		sendXML(w, 200, modifyRGResp{Result: rgToXML(rg)})

	case "CreateCacheSubnetGroup":
		name := params.Get("CacheSubnetGroupName")
		h.store.mu.Lock()
		if _, exists := h.store.subnetGroups[name]; exists {
			h.store.mu.Unlock()
			sendError(w, 400, "CacheSubnetGroupAlreadyExistsFault", "Cache subnet group already exists: "+name)
			return
		}
		sg := &CacheSubnetGroup{
			CacheSubnetGroupName:        name,
			CacheSubnetGroupDescription: params.Get("CacheSubnetGroupDescription"),
			VpcId:                       "vpc-00000000",
			CreatedAt:                   time.Now(),
		}
		h.store.subnetGroups[name] = sg
		h.store.mu.Unlock()
		type createSGResp struct {
			XMLName xml.Name            `xml:"CreateCacheSubnetGroupResponse"`
			Result  xmlCacheSubnetGroup `xml:"CreateCacheSubnetGroupResult>CacheSubnetGroup"`
		}
		sendXML(w, 200, createSGResp{Result: subnetGroupToXML(sg)})

	case "DeleteCacheSubnetGroup":
		name := params.Get("CacheSubnetGroupName")
		h.store.mu.Lock()
		sg := h.store.subnetGroups[name]
		if sg == nil {
			h.store.mu.Unlock()
			sendError(w, 404, "CacheSubnetGroupNotFoundFault", "Cache subnet group not found: "+name)
			return
		}
		delete(h.store.subnetGroups, name)
		h.store.mu.Unlock()
		type deleteSGResp struct {
			XMLName xml.Name `xml:"DeleteCacheSubnetGroupResponse"`
		}
		sendXML(w, 200, deleteSGResp{})

	case "DescribeCacheSubnetGroups":
		filterName := params.Get("CacheSubnetGroupName")
		h.store.mu.RLock()
		var groups []xmlCacheSubnetGroup
		for _, sg := range h.store.subnetGroups {
			if filterName == "" || sg.CacheSubnetGroupName == filterName {
				groups = append(groups, subnetGroupToXML(sg))
			}
		}
		h.store.mu.RUnlock()
		if groups == nil {
			groups = []xmlCacheSubnetGroup{}
		}
		type describeSGResp struct {
			XMLName xml.Name              `xml:"DescribeCacheSubnetGroupsResponse"`
			Groups  []xmlCacheSubnetGroup `xml:"DescribeCacheSubnetGroupsResult>CacheSubnetGroups>CacheSubnetGroup"`
		}
		sendXML(w, 200, describeSGResp{Groups: groups})

	case "CreateSnapshot":
		snapName := params.Get("SnapshotName")
		clusterId := params.Get("CacheClusterId")
		h.store.mu.Lock()
		cluster, clusterExists := h.store.clusters[clusterId]
		if !clusterExists || cluster.CacheClusterStatus == "deleting" {
			h.store.mu.Unlock()
			sendError(w, 404, "CacheClusterNotFound", "Cache cluster not found: "+clusterId)
			return
		}
		if cluster.Engine != "redis" {
			h.store.mu.Unlock()
			sendError(w, 400, "SnapshotFeatureNotSupportedFault", "Snapshots are only supported for Redis clusters")
			return
		}
		if existing, exists := h.store.snapshots[snapName]; exists && existing.Status != "deleting" {
			h.store.mu.Unlock()
			sendError(w, 400, "SnapshotAlreadyExistsFault", "Snapshot already exists: "+snapName)
			return
		}
		snap := &CacheSnapshot{
			SnapshotName:   snapName,
			CacheClusterId: clusterId,
			Status:         "available",
			Engine:         cluster.Engine,
			CreatedAt:      time.Now(),
		}
		h.store.snapshots[snapName] = snap
		h.store.mu.Unlock()
		type createSnapResp struct {
			XMLName xml.Name    `xml:"CreateSnapshotResponse"`
			Result  xmlSnapshot `xml:"CreateSnapshotResult>Snapshot"`
		}
		sendXML(w, 200, createSnapResp{Result: snapshotToXML(snap)})

	case "DeleteSnapshot":
		snapName := params.Get("SnapshotName")
		h.store.mu.Lock()
		snap := h.store.snapshots[snapName]
		if snap == nil {
			h.store.mu.Unlock()
			sendError(w, 404, "SnapshotNotFoundFault", "Snapshot not found: "+snapName)
			return
		}
		snap.Status = "deleting"
		h.store.mu.Unlock()
		type deleteSnapResp struct {
			XMLName xml.Name    `xml:"DeleteSnapshotResponse"`
			Result  xmlSnapshot `xml:"DeleteSnapshotResult>Snapshot"`
		}
		sendXML(w, 200, deleteSnapResp{Result: snapshotToXML(snap)})

	case "DescribeSnapshots":
		filterName := params.Get("SnapshotName")
		filterCluster := params.Get("CacheClusterId")
		h.store.mu.RLock()
		var snaps []xmlSnapshot
		for _, s := range h.store.snapshots {
			if (filterName == "" || s.SnapshotName == filterName) &&
				(filterCluster == "" || s.CacheClusterId == filterCluster) {
				snaps = append(snaps, snapshotToXML(s))
			}
		}
		h.store.mu.RUnlock()
		if snaps == nil {
			snaps = []xmlSnapshot{}
		}
		type describeSnapsResp struct {
			XMLName   xml.Name      `xml:"DescribeSnapshotsResponse"`
			Snapshots []xmlSnapshot `xml:"DescribeSnapshotsResult>Snapshots>Snapshot"`
		}
		sendXML(w, 200, describeSnapsResp{Snapshots: snaps})

	case "AddTagsToResource":
		type addTagsResp struct {
			XMLName xml.Name `xml:"AddTagsToResourceResponse"`
			TagList []struct{} `xml:"AddTagsToResourceResult>TagList>Tag"`
		}
		sendXML(w, 200, addTagsResp{})

	case "RemoveTagsFromResource":
		type removeTagsResp struct {
			XMLName xml.Name `xml:"RemoveTagsFromResourceResponse"`
			TagList []struct{} `xml:"RemoveTagsFromResourceResult>TagList>Tag"`
		}
		sendXML(w, 200, removeTagsResp{})

	case "ListTagsForResource":
		type listTagsResp struct {
			XMLName xml.Name `xml:"ListTagsForResourceResponse"`
			TagList []struct{} `xml:"ListTagsForResourceResult>TagList>Tag"`
		}
		sendXML(w, 200, listTagsResp{})

	default:
		sendError(w, 400, "InvalidAction", "Unknown action: "+action)
	}
}
