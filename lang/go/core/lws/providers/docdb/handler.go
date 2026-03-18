package docdb

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

type DBCluster struct {
	DBClusterIdentifier string
	Status              string
	Engine              string
	Endpoint            string
	ReaderEndpoint      string
	Port                int
	MasterUsername      string
	CreatedAt           time.Time
}

type DBInstance struct {
	DBInstanceIdentifier string
	DBClusterIdentifier  string
	DBInstanceClass      string
	Engine               string
	DBInstanceStatus     string
	EndpointAddress      string
	EndpointPort         int
	CreatedAt            time.Time
}

type DBClusterSnapshot struct {
	DBClusterSnapshotIdentifier string
	DBClusterIdentifier         string
	Status                      string
	Engine                      string
	CreatedAt                   time.Time
}

type Store struct {
	mu        sync.RWMutex
	clusters  map[string]*DBCluster
	instances map[string]*DBInstance
	snapshots map[string]*DBClusterSnapshot
}

func NewStore() *Store {
	return &Store{
		clusters:  make(map[string]*DBCluster),
		instances: make(map[string]*DBInstance),
		snapshots: make(map[string]*DBClusterSnapshot),
	}
}

func (s *Store) Reset() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.clusters = make(map[string]*DBCluster)
	s.instances = make(map[string]*DBInstance)
	s.snapshots = make(map[string]*DBClusterSnapshot)
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

	if state.ApplyIAMAuth(h.state, "docdb", action, r, w, true) {
		return
	}
	if state.ApplyChaos(h.state, "docdb", action, w, true, false) {
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

func clusterDesc(c *DBCluster) map[string]interface{} {
	return map[string]interface{}{
		"DBClusterIdentifier": c.DBClusterIdentifier,
		"Status":              c.Status,
		"Engine":              c.Engine,
		"Endpoint":            c.Endpoint,
		"ReaderEndpoint":      c.ReaderEndpoint,
		"Port":                c.Port,
		"MasterUsername":      c.MasterUsername,
		"DBClusterArn":        fmt.Sprintf("arn:aws:rds:%s:%s:cluster:%s", region, accountID, c.DBClusterIdentifier),
	}
}

func instanceDesc(i *DBInstance) map[string]interface{} {
	return map[string]interface{}{
		"DBInstanceIdentifier": i.DBInstanceIdentifier,
		"DBClusterIdentifier":  i.DBClusterIdentifier,
		"DBInstanceClass":      i.DBInstanceClass,
		"Engine":               i.Engine,
		"DBInstanceStatus":     i.DBInstanceStatus,
		"Endpoint": map[string]interface{}{
			"Address": i.EndpointAddress,
			"Port":    i.EndpointPort,
		},
		"DBInstanceArn": fmt.Sprintf("arn:aws:rds:%s:%s:db:%s", region, accountID, i.DBInstanceIdentifier),
	}
}

func snapshotDesc(s *DBClusterSnapshot) map[string]interface{} {
	return map[string]interface{}{
		"DBClusterSnapshotIdentifier": s.DBClusterSnapshotIdentifier,
		"DBClusterIdentifier":         s.DBClusterIdentifier,
		"Status":                      s.Status,
		"Engine":                      s.Engine,
		"DBClusterSnapshotArn":        fmt.Sprintf("arn:aws:rds:%s:%s:cluster-snapshot:%s", region, accountID, s.DBClusterSnapshotIdentifier),
	}
}

func (h *Handler) handle(w http.ResponseWriter, action string, params url.Values) {
	switch action {
	case "CreateDBCluster":
		id := params.Get("DBClusterIdentifier")
		cluster := &DBCluster{
			DBClusterIdentifier: id,
			Status:              "available",
			Engine:              "docdb",
			Endpoint:            "localhost",
			ReaderEndpoint:      "localhost",
			Port:                27017,
			MasterUsername:      params.Get("MasterUsername"),
			CreatedAt:           time.Now(),
		}
		h.store.mu.Lock()
		h.store.clusters[id] = cluster
		h.store.mu.Unlock()
		sendJSON(w, 200, map[string]interface{}{"DBCluster": clusterDesc(cluster)})

	case "DeleteDBCluster":
		id := params.Get("DBClusterIdentifier")
		h.store.mu.Lock()
		cluster := h.store.clusters[id]
		delete(h.store.clusters, id)
		h.store.mu.Unlock()
		if cluster == nil {
			sendError(w, 404, "DBClusterNotFoundFault", "DB cluster not found: "+id)
			return
		}
		sendJSON(w, 200, map[string]interface{}{"DBCluster": clusterDesc(cluster)})

	case "DescribeDBClusters":
		filterID := params.Get("DBClusterIdentifier")
		h.store.mu.RLock()
		var clusters []map[string]interface{}
		for _, c := range h.store.clusters {
			if filterID == "" || c.DBClusterIdentifier == filterID {
				clusters = append(clusters, clusterDesc(c))
			}
		}
		h.store.mu.RUnlock()
		if clusters == nil {
			clusters = []map[string]interface{}{}
		}
		sendJSON(w, 200, map[string]interface{}{"DBClusters": clusters})

	case "CreateDBInstance":
		id := params.Get("DBInstanceIdentifier")
		inst := &DBInstance{
			DBInstanceIdentifier: id,
			DBClusterIdentifier:  params.Get("DBClusterIdentifier"),
			DBInstanceClass:      params.Get("DBInstanceClass"),
			Engine:               "docdb",
			DBInstanceStatus:     "available",
			EndpointAddress:      "localhost",
			EndpointPort:         27017,
			CreatedAt:            time.Now(),
		}
		h.store.mu.Lock()
		h.store.instances[id] = inst
		h.store.mu.Unlock()
		sendJSON(w, 200, map[string]interface{}{"DBInstance": instanceDesc(inst)})

	case "DeleteDBInstance":
		id := params.Get("DBInstanceIdentifier")
		h.store.mu.Lock()
		inst := h.store.instances[id]
		delete(h.store.instances, id)
		h.store.mu.Unlock()
		if inst == nil {
			sendError(w, 404, "DBInstanceNotFound", "DB instance not found: "+id)
			return
		}
		sendJSON(w, 200, map[string]interface{}{"DBInstance": instanceDesc(inst)})

	case "DescribeDBInstances":
		filterID := params.Get("DBInstanceIdentifier")
		h.store.mu.RLock()
		var instances []map[string]interface{}
		for _, inst := range h.store.instances {
			if filterID == "" || inst.DBInstanceIdentifier == filterID {
				instances = append(instances, instanceDesc(inst))
			}
		}
		h.store.mu.RUnlock()
		if instances == nil {
			instances = []map[string]interface{}{}
		}
		sendJSON(w, 200, map[string]interface{}{"DBInstances": instances})

	case "CreateDBClusterSnapshot":
		snapID := params.Get("DBClusterSnapshotIdentifier")
		clusterID := params.Get("DBClusterIdentifier")
		snap := &DBClusterSnapshot{
			DBClusterSnapshotIdentifier: snapID,
			DBClusterIdentifier:         clusterID,
			Status:                      "available",
			Engine:                      "docdb",
			CreatedAt:                   time.Now(),
		}
		h.store.mu.Lock()
		h.store.snapshots[snapID] = snap
		h.store.mu.Unlock()
		sendJSON(w, 200, map[string]interface{}{"DBClusterSnapshot": snapshotDesc(snap)})

	case "DeleteDBClusterSnapshot":
		snapID := params.Get("DBClusterSnapshotIdentifier")
		h.store.mu.Lock()
		snap := h.store.snapshots[snapID]
		delete(h.store.snapshots, snapID)
		h.store.mu.Unlock()
		if snap == nil {
			sendError(w, 404, "DBClusterSnapshotNotFoundFault", "DB cluster snapshot not found: "+snapID)
			return
		}
		sendJSON(w, 200, map[string]interface{}{"DBClusterSnapshot": snapshotDesc(snap)})

	case "DescribeDBClusterSnapshots":
		filterID := params.Get("DBClusterSnapshotIdentifier")
		clusterID := params.Get("DBClusterIdentifier")
		h.store.mu.RLock()
		var snaps []map[string]interface{}
		for _, snap := range h.store.snapshots {
			if (filterID == "" || snap.DBClusterSnapshotIdentifier == filterID) &&
				(clusterID == "" || snap.DBClusterIdentifier == clusterID) {
				snaps = append(snaps, snapshotDesc(snap))
			}
		}
		h.store.mu.RUnlock()
		if snaps == nil {
			snaps = []map[string]interface{}{}
		}
		sendJSON(w, 200, map[string]interface{}{"DBClusterSnapshots": snaps})

	default:
		sendError(w, 400, "InvalidAction", "Unknown action: "+action)
	}
}
