package rds

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"strings"
	"sync"
	"time"

	"github.com/local-web-services/local-web-services-go-core/lws/state"
)

const accountID = "000000000000"
const region = "us-east-1"

type DBInstance struct {
	DBInstanceIdentifier string
	DBInstanceClass      string
	Engine               string
	DBInstanceStatus     string
	DBName               string
	MasterUsername       string
	AllocatedStorage     int
	MultiAZ              bool
	EndpointAddress      string
	EndpointPort         int
	CreatedAt            time.Time
}

type DBSnapshot struct {
	DBSnapshotIdentifier string
	DBInstanceIdentifier string
	Status               string
	Engine               string
	SnapshotType         string
	CreatedAt            time.Time
}

type Store struct {
	mu        sync.RWMutex
	instances map[string]*DBInstance
	snapshots map[string]*DBSnapshot
}

func NewStore() *Store {
	return &Store{
		instances: make(map[string]*DBInstance),
		snapshots: make(map[string]*DBSnapshot),
	}
}

func (s *Store) Reset() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.instances = make(map[string]*DBInstance)
	s.snapshots = make(map[string]*DBSnapshot)
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

	if state.ApplyIAMAuth(h.state, "rds", action, r, w, true) {
		return
	}
	if state.ApplyChaos(h.state, "rds", action, w, true, false) {
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

func instanceDesc(i *DBInstance) map[string]interface{} {
	return map[string]interface{}{
		"DBInstanceIdentifier": i.DBInstanceIdentifier,
		"DBInstanceClass":      i.DBInstanceClass,
		"Engine":               i.Engine,
		"DBInstanceStatus":     i.DBInstanceStatus,
		"DBName":               i.DBName,
		"MasterUsername":       i.MasterUsername,
		"AllocatedStorage":     i.AllocatedStorage,
		"MultiAZ":              i.MultiAZ,
		"Endpoint": map[string]interface{}{
			"Address": i.EndpointAddress,
			"Port":    i.EndpointPort,
		},
		"DBInstanceArn": fmt.Sprintf("arn:aws:rds:%s:%s:db:%s", region, accountID, i.DBInstanceIdentifier),
	}
}

func snapshotDesc(s *DBSnapshot) map[string]interface{} {
	return map[string]interface{}{
		"DBSnapshotIdentifier": s.DBSnapshotIdentifier,
		"DBInstanceIdentifier": s.DBInstanceIdentifier,
		"Status":               s.Status,
		"Engine":               s.Engine,
		"SnapshotType":         s.SnapshotType,
		"DBSnapshotArn":        fmt.Sprintf("arn:aws:rds:%s:%s:snapshot:%s", region, accountID, s.DBSnapshotIdentifier),
	}
}

func (h *Handler) handle(w http.ResponseWriter, action string, params url.Values) {
	switch action {
	case "CreateDBInstance":
		id := params.Get("DBInstanceIdentifier")
		inst := &DBInstance{
			DBInstanceIdentifier: id,
			DBInstanceClass:      params.Get("DBInstanceClass"),
			Engine:               params.Get("Engine"),
			DBInstanceStatus:     "available",
			DBName:               params.Get("DBName"),
			MasterUsername:       params.Get("MasterUsername"),
			AllocatedStorage:     20,
			MultiAZ:              false,
			EndpointAddress:      "localhost",
			EndpointPort:         3306,
			CreatedAt:            time.Now(),
		}
		if strings.Contains(strings.ToLower(inst.Engine), "postgres") {
			inst.EndpointPort = 5432
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

	case "ModifyDBInstance":
		id := params.Get("DBInstanceIdentifier")
		h.store.mu.Lock()
		inst := h.store.instances[id]
		h.store.mu.Unlock()
		if inst == nil {
			sendError(w, 404, "DBInstanceNotFound", "DB instance not found: "+id)
			return
		}
		if v := params.Get("DBInstanceClass"); v != "" {
			inst.DBInstanceClass = v
		}
		sendJSON(w, 200, map[string]interface{}{"DBInstance": instanceDesc(inst)})

	case "RebootDBInstance":
		id := params.Get("DBInstanceIdentifier")
		h.store.mu.RLock()
		inst := h.store.instances[id]
		h.store.mu.RUnlock()
		if inst == nil {
			sendError(w, 404, "DBInstanceNotFound", "DB instance not found: "+id)
			return
		}
		sendJSON(w, 200, map[string]interface{}{"DBInstance": instanceDesc(inst)})

	case "CreateDBSnapshot":
		snapID := params.Get("DBSnapshotIdentifier")
		dbID := params.Get("DBInstanceIdentifier")
		h.store.mu.RLock()
		inst := h.store.instances[dbID]
		h.store.mu.RUnlock()
		engine := "mysql"
		if inst != nil {
			engine = inst.Engine
		}
		snap := &DBSnapshot{
			DBSnapshotIdentifier: snapID,
			DBInstanceIdentifier: dbID,
			Status:               "available",
			Engine:               engine,
			SnapshotType:         "manual",
			CreatedAt:            time.Now(),
		}
		h.store.mu.Lock()
		h.store.snapshots[snapID] = snap
		h.store.mu.Unlock()
		sendJSON(w, 200, map[string]interface{}{"DBSnapshot": snapshotDesc(snap)})

	case "DeleteDBSnapshot":
		snapID := params.Get("DBSnapshotIdentifier")
		h.store.mu.Lock()
		snap := h.store.snapshots[snapID]
		delete(h.store.snapshots, snapID)
		h.store.mu.Unlock()
		if snap == nil {
			sendError(w, 404, "DBSnapshotNotFound", "DB snapshot not found: "+snapID)
			return
		}
		sendJSON(w, 200, map[string]interface{}{"DBSnapshot": snapshotDesc(snap)})

	case "DescribeDBSnapshots":
		filterID := params.Get("DBSnapshotIdentifier")
		dbID := params.Get("DBInstanceIdentifier")
		h.store.mu.RLock()
		var snaps []map[string]interface{}
		for _, snap := range h.store.snapshots {
			if (filterID == "" || snap.DBSnapshotIdentifier == filterID) &&
				(dbID == "" || snap.DBInstanceIdentifier == dbID) {
				snaps = append(snaps, snapshotDesc(snap))
			}
		}
		h.store.mu.RUnlock()
		if snaps == nil {
			snaps = []map[string]interface{}{}
		}
		sendJSON(w, 200, map[string]interface{}{"DBSnapshots": snaps})

	case "AddTagsToResource":
		// No-op: tags are accepted but not stored in this simplified implementation.
		sendJSON(w, 200, map[string]interface{}{})

	case "RestoreDBInstanceFromDBSnapshot":
		id := params.Get("DBInstanceIdentifier")
		snapID := params.Get("DBSnapshotIdentifier")
		h.store.mu.RLock()
		snap := h.store.snapshots[snapID]
		h.store.mu.RUnlock()
		engine := "mysql"
		if snap != nil {
			engine = snap.Engine
		}
		inst := &DBInstance{
			DBInstanceIdentifier: id,
			DBInstanceClass:      params.Get("DBInstanceClass"),
			Engine:               engine,
			DBInstanceStatus:     "restoring",
			DBName:               params.Get("DBName"),
			AllocatedStorage:     20,
			MultiAZ:              false,
			EndpointAddress:      "localhost",
			EndpointPort:         3306,
			CreatedAt:            time.Now(),
		}
		if strings.Contains(strings.ToLower(inst.Engine), "postgres") {
			inst.EndpointPort = 5432
		}
		h.store.mu.Lock()
		h.store.instances[id] = inst
		h.store.mu.Unlock()
		sendJSON(w, 200, map[string]interface{}{"DBInstance": instanceDesc(inst)})

	default:
		sendError(w, 400, "InvalidAction", "Unknown action: "+action)
	}
}
