package rds

import (
	"encoding/xml"
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

type xmlEndpoint struct {
	Address string `xml:"Address"`
	Port    int    `xml:"Port"`
}

type xmlDBInstance struct {
	DBInstanceIdentifier string      `xml:"DBInstanceIdentifier"`
	DBInstanceClass      string      `xml:"DBInstanceClass"`
	Engine               string      `xml:"Engine"`
	DBInstanceStatus     string      `xml:"DBInstanceStatus"`
	DBName               string      `xml:"DBName"`
	MasterUsername       string      `xml:"MasterUsername"`
	AllocatedStorage     int         `xml:"AllocatedStorage"`
	MultiAZ              bool        `xml:"MultiAZ"`
	Endpoint             xmlEndpoint `xml:"Endpoint"`
	DBInstanceArn        string      `xml:"DBInstanceArn"`
}

type xmlDBSnapshot struct {
	DBSnapshotIdentifier string `xml:"DBSnapshotIdentifier"`
	DBInstanceIdentifier string `xml:"DBInstanceIdentifier"`
	Status               string `xml:"Status"`
	Engine               string `xml:"Engine"`
	SnapshotType         string `xml:"SnapshotType"`
	DBSnapshotArn        string `xml:"DBSnapshotArn"`
}

func instanceXML(i *DBInstance) xmlDBInstance {
	return xmlDBInstance{
		DBInstanceIdentifier: i.DBInstanceIdentifier,
		DBInstanceClass:      i.DBInstanceClass,
		Engine:               i.Engine,
		DBInstanceStatus:     i.DBInstanceStatus,
		DBName:               i.DBName,
		MasterUsername:       i.MasterUsername,
		AllocatedStorage:     i.AllocatedStorage,
		MultiAZ:              i.MultiAZ,
		Endpoint: xmlEndpoint{
			Address: i.EndpointAddress,
			Port:    i.EndpointPort,
		},
		DBInstanceArn: fmt.Sprintf("arn:aws:rds:%s:%s:db:%s", region, accountID, i.DBInstanceIdentifier),
	}
}

func snapshotXML(s *DBSnapshot) xmlDBSnapshot {
	return xmlDBSnapshot{
		DBSnapshotIdentifier: s.DBSnapshotIdentifier,
		DBInstanceIdentifier: s.DBInstanceIdentifier,
		Status:               s.Status,
		Engine:               s.Engine,
		SnapshotType:         s.SnapshotType,
		DBSnapshotArn:        fmt.Sprintf("arn:aws:rds:%s:%s:snapshot:%s", region, accountID, s.DBSnapshotIdentifier),
	}
}

func (h *Handler) handle(w http.ResponseWriter, action string, params url.Values) {
	switch action {
	case "CreateDBInstance":
		id := params.Get("DBInstanceIdentifier")
		h.store.mu.Lock()
		if existing, exists := h.store.instances[id]; exists && existing.DBInstanceStatus != "deleting" {
			h.store.mu.Unlock()
			sendError(w, 400, "DBInstanceAlreadyExists", "DB instance already exists: "+id)
			return
		}
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
		h.store.instances[id] = inst
		h.store.mu.Unlock()
		type resp struct {
			XMLName xml.Name      `xml:"CreateDBInstanceResponse"`
			Result  xmlDBInstance `xml:"CreateDBInstanceResult>DBInstance"`
		}
		sendXML(w, 200, resp{Result: instanceXML(inst)})

	case "DeleteDBInstance":
		id := params.Get("DBInstanceIdentifier")
		h.store.mu.Lock()
		inst := h.store.instances[id]
		if inst == nil {
			h.store.mu.Unlock()
			sendError(w, 404, "DBInstanceNotFound", "DB instance not found: "+id)
			return
		}
		inst.DBInstanceStatus = "deleting"
		h.store.mu.Unlock()
		type resp struct {
			XMLName xml.Name      `xml:"DeleteDBInstanceResponse"`
			Result  xmlDBInstance `xml:"DeleteDBInstanceResult>DBInstance"`
		}
		sendXML(w, 200, resp{Result: instanceXML(inst)})

	case "DescribeDBInstances":
		filterID := params.Get("DBInstanceIdentifier")
		h.store.mu.RLock()
		var instances []xmlDBInstance
		for _, inst := range h.store.instances {
			if filterID == "" || inst.DBInstanceIdentifier == filterID {
				instances = append(instances, instanceXML(inst))
			}
		}
		h.store.mu.RUnlock()
		type resp struct {
			XMLName   xml.Name        `xml:"DescribeDBInstancesResponse"`
			Instances []xmlDBInstance `xml:"DescribeDBInstancesResult>DBInstances>DBInstance"`
		}
		sendXML(w, 200, resp{Instances: instances})

	case "ModifyDBInstance":
		id := params.Get("DBInstanceIdentifier")
		h.store.mu.Lock()
		inst := h.store.instances[id]
		if inst == nil {
			h.store.mu.Unlock()
			sendError(w, 404, "DBInstanceNotFound", "DB instance not found: "+id)
			return
		}
		if v := params.Get("DBInstanceClass"); v != "" {
			inst.DBInstanceClass = v
		}
		if v := params.Get("MultiAZ"); v == "true" {
			inst.MultiAZ = true
		}
		inst.DBInstanceStatus = "modifying"
		h.store.mu.Unlock()
		type resp struct {
			XMLName xml.Name      `xml:"ModifyDBInstanceResponse"`
			Result  xmlDBInstance `xml:"ModifyDBInstanceResult>DBInstance"`
		}
		sendXML(w, 200, resp{Result: instanceXML(inst)})

	case "RebootDBInstance":
		id := params.Get("DBInstanceIdentifier")
		forceFailover := params.Get("ForceFailover") == "true"
		h.store.mu.Lock()
		inst := h.store.instances[id]
		if inst == nil {
			h.store.mu.Unlock()
			sendError(w, 404, "DBInstanceNotFound", "DB instance not found: "+id)
			return
		}
		if forceFailover {
			inst.DBInstanceStatus = "failing-over"
		} else {
			inst.DBInstanceStatus = "rebooting"
		}
		h.store.mu.Unlock()
		type resp struct {
			XMLName xml.Name      `xml:"RebootDBInstanceResponse"`
			Result  xmlDBInstance `xml:"RebootDBInstanceResult>DBInstance"`
		}
		sendXML(w, 200, resp{Result: instanceXML(inst)})

	case "CreateDBSnapshot":
		snapID := params.Get("DBSnapshotIdentifier")
		dbID := params.Get("DBInstanceIdentifier")
		h.store.mu.Lock()
		if existing, exists := h.store.snapshots[snapID]; exists && existing.Status != "deleting" {
			h.store.mu.Unlock()
			sendError(w, 400, "DBSnapshotAlreadyExists", "DB snapshot already exists: "+snapID)
			return
		}
		inst := h.store.instances[dbID]
		if inst == nil {
			h.store.mu.Unlock()
			sendError(w, 404, "DBInstanceNotFound", "DB instance not found: "+dbID)
			return
		}
		engine := inst.Engine
		snap := &DBSnapshot{
			DBSnapshotIdentifier: snapID,
			DBInstanceIdentifier: dbID,
			Status:               "creating",
			Engine:               engine,
			SnapshotType:         "manual",
			CreatedAt:            time.Now(),
		}
		h.store.snapshots[snapID] = snap
		h.store.mu.Unlock()
		type resp struct {
			XMLName xml.Name      `xml:"CreateDBSnapshotResponse"`
			Result  xmlDBSnapshot `xml:"CreateDBSnapshotResult>DBSnapshot"`
		}
		sendXML(w, 200, resp{Result: snapshotXML(snap)})

	case "DeleteDBSnapshot":
		snapID := params.Get("DBSnapshotIdentifier")
		h.store.mu.Lock()
		snap := h.store.snapshots[snapID]
		if snap == nil {
			h.store.mu.Unlock()
			sendError(w, 404, "DBSnapshotNotFound", "DB snapshot not found: "+snapID)
			return
		}
		snap.Status = "deleting"
		h.store.mu.Unlock()
		type resp struct {
			XMLName xml.Name      `xml:"DeleteDBSnapshotResponse"`
			Result  xmlDBSnapshot `xml:"DeleteDBSnapshotResult>DBSnapshot"`
		}
		sendXML(w, 200, resp{Result: snapshotXML(snap)})

	case "DescribeDBSnapshots":
		filterID := params.Get("DBSnapshotIdentifier")
		dbID := params.Get("DBInstanceIdentifier")
		h.store.mu.RLock()
		var snaps []xmlDBSnapshot
		for _, snap := range h.store.snapshots {
			if (filterID == "" || snap.DBSnapshotIdentifier == filterID) &&
				(dbID == "" || snap.DBInstanceIdentifier == dbID) {
				snaps = append(snaps, snapshotXML(snap))
			}
		}
		h.store.mu.RUnlock()
		type resp struct {
			XMLName   xml.Name        `xml:"DescribeDBSnapshotsResponse"`
			Snapshots []xmlDBSnapshot `xml:"DescribeDBSnapshotsResult>DBSnapshots>DBSnapshot"`
		}
		sendXML(w, 200, resp{Snapshots: snaps})

	case "AddTagsToResource":
		resourceName := params.Get("ResourceName")
		// Extract instance ID from ARN: arn:aws:rds:<region>:<account>:db:<id>
		parts := strings.Split(resourceName, ":")
		if len(parts) >= 7 && parts[5] == "db" {
			instID := parts[6]
			h.store.mu.RLock()
			inst := h.store.instances[instID]
			h.store.mu.RUnlock()
			if inst == nil {
				sendError(w, 404, "DBInstanceNotFound", "DB instance not found: "+instID)
				return
			}
		}
		type resp struct {
			XMLName xml.Name `xml:"AddTagsToResourceResponse"`
		}
		sendXML(w, 200, resp{})

	case "RestoreDBInstanceFromDBSnapshot":
		id := params.Get("DBInstanceIdentifier")
		snapID := params.Get("DBSnapshotIdentifier")
		h.store.mu.RLock()
		snap := h.store.snapshots[snapID]
		h.store.mu.RUnlock()
		if snap == nil {
			sendError(w, 404, "DBSnapshotNotFound", "DB snapshot not found: "+snapID)
			return
		}
		engine := snap.Engine
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
		type resp struct {
			XMLName xml.Name      `xml:"RestoreDBInstanceFromDBSnapshotResponse"`
			Result  xmlDBInstance `xml:"RestoreDBInstanceFromDBSnapshotResult>DBInstance"`
		}
		sendXML(w, 200, resp{Result: instanceXML(inst)})

	default:
		sendError(w, 400, "InvalidAction", "Unknown action: "+action)
	}
}
