package neptune

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

	if state.ApplyIAMAuth(h.state, "neptune", action, r, w, true) {
		return
	}
	if state.ApplyChaos(h.state, "neptune", action, w, true, false) {
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

type xmlDBCluster struct {
	DBClusterIdentifier string `xml:"DBClusterIdentifier"`
	Status              string `xml:"Status"`
	Engine              string `xml:"Engine"`
	Endpoint            string `xml:"Endpoint"`
	ReaderEndpoint      string `xml:"ReaderEndpoint"`
	Port                int    `xml:"Port"`
	MasterUsername      string `xml:"MasterUsername"`
	DBClusterArn        string `xml:"DBClusterArn"`
}

type xmlDBInstance struct {
	DBInstanceIdentifier string      `xml:"DBInstanceIdentifier"`
	DBClusterIdentifier  string      `xml:"DBClusterIdentifier"`
	DBInstanceClass      string      `xml:"DBInstanceClass"`
	Engine               string      `xml:"Engine"`
	DBInstanceStatus     string      `xml:"DBInstanceStatus"`
	Endpoint             xmlEndpoint `xml:"Endpoint"`
	DBInstanceArn        string      `xml:"DBInstanceArn"`
}

type xmlDBClusterSnapshot struct {
	DBClusterSnapshotIdentifier string `xml:"DBClusterSnapshotIdentifier"`
	DBClusterIdentifier         string `xml:"DBClusterIdentifier"`
	Status                      string `xml:"Status"`
	Engine                      string `xml:"Engine"`
	DBClusterSnapshotArn        string `xml:"DBClusterSnapshotArn"`
}

func clusterXML(c *DBCluster) xmlDBCluster {
	return xmlDBCluster{
		DBClusterIdentifier: c.DBClusterIdentifier,
		Status:              c.Status,
		Engine:              c.Engine,
		Endpoint:            c.Endpoint,
		ReaderEndpoint:      c.ReaderEndpoint,
		Port:                c.Port,
		MasterUsername:      c.MasterUsername,
		DBClusterArn:        fmt.Sprintf("arn:aws:rds:%s:%s:cluster:%s", region, accountID, c.DBClusterIdentifier),
	}
}

func instanceXML(i *DBInstance) xmlDBInstance {
	return xmlDBInstance{
		DBInstanceIdentifier: i.DBInstanceIdentifier,
		DBClusterIdentifier:  i.DBClusterIdentifier,
		DBInstanceClass:      i.DBInstanceClass,
		Engine:               i.Engine,
		DBInstanceStatus:     i.DBInstanceStatus,
		Endpoint: xmlEndpoint{
			Address: i.EndpointAddress,
			Port:    i.EndpointPort,
		},
		DBInstanceArn: fmt.Sprintf("arn:aws:rds:%s:%s:db:%s", region, accountID, i.DBInstanceIdentifier),
	}
}

func snapshotXML(s *DBClusterSnapshot) xmlDBClusterSnapshot {
	return xmlDBClusterSnapshot{
		DBClusterSnapshotIdentifier: s.DBClusterSnapshotIdentifier,
		DBClusterIdentifier:         s.DBClusterIdentifier,
		Status:                      s.Status,
		Engine:                      s.Engine,
		DBClusterSnapshotArn:        fmt.Sprintf("arn:aws:rds:%s:%s:cluster-snapshot:%s", region, accountID, s.DBClusterSnapshotIdentifier),
	}
}

func (h *Handler) handle(w http.ResponseWriter, action string, params url.Values) {
	switch action {
	case "CreateDBCluster":
		id := params.Get("DBClusterIdentifier")
		h.store.mu.Lock()
		if existing, exists := h.store.clusters[id]; exists && existing.Status != "DELETING" {
			h.store.mu.Unlock()
			sendError(w, 400, "DBClusterAlreadyExistsFault", "DB cluster already exists: "+id)
			return
		}
		cluster := &DBCluster{
			DBClusterIdentifier: id,
			Status:              "CREATING",
			Engine:              "neptune",
			Endpoint:            "localhost",
			ReaderEndpoint:      "localhost",
			Port:                8182,
			MasterUsername:      params.Get("MasterUsername"),
			CreatedAt:           time.Now(),
		}
		h.store.clusters[id] = cluster
		h.store.mu.Unlock()
		type resp struct {
			XMLName xml.Name     `xml:"CreateDBClusterResponse"`
			Result  xmlDBCluster `xml:"CreateDBClusterResult>DBCluster"`
		}
		sendXML(w, 200, resp{Result: clusterXML(cluster)})

	case "DeleteDBCluster":
		id := params.Get("DBClusterIdentifier")
		h.store.mu.Lock()
		cluster := h.store.clusters[id]
		if cluster == nil {
			h.store.mu.Unlock()
			sendError(w, 404, "DBClusterNotFoundFault", "DB cluster not found: "+id)
			return
		}
		cluster.Status = "DELETING"
		h.store.mu.Unlock()
		type resp struct {
			XMLName xml.Name     `xml:"DeleteDBClusterResponse"`
			Result  xmlDBCluster `xml:"DeleteDBClusterResult>DBCluster"`
		}
		sendXML(w, 200, resp{Result: clusterXML(cluster)})

	case "DescribeDBClusters":
		filterID := params.Get("DBClusterIdentifier")
		h.store.mu.RLock()
		var clusters []xmlDBCluster
		for _, c := range h.store.clusters {
			if filterID == "" || c.DBClusterIdentifier == filterID {
				clusters = append(clusters, clusterXML(c))
			}
		}
		h.store.mu.RUnlock()
		type resp struct {
			XMLName  xml.Name       `xml:"DescribeDBClustersResponse"`
			Clusters []xmlDBCluster `xml:"DescribeDBClustersResult>DBClusters>DBCluster"`
		}
		sendXML(w, 200, resp{Clusters: clusters})

	case "CreateDBInstance":
		id := params.Get("DBInstanceIdentifier")
		clusterID := params.Get("DBClusterIdentifier")
		h.store.mu.Lock()
		cluster, clusterExists := h.store.clusters[clusterID]
		if !clusterExists || cluster.Status == "DELETING" {
			h.store.mu.Unlock()
			sendError(w, 404, "DBClusterNotFoundFault", "DB cluster not found: "+clusterID)
			return
		}
		if existing, exists := h.store.instances[id]; exists && existing.DBInstanceStatus != "DELETING" {
			h.store.mu.Unlock()
			sendError(w, 400, "DBInstanceAlreadyExists", "DB instance already exists: "+id)
			return
		}
		inst := &DBInstance{
			DBInstanceIdentifier: id,
			DBClusterIdentifier:  clusterID,
			DBInstanceClass:      params.Get("DBInstanceClass"),
			Engine:               "neptune",
			DBInstanceStatus:     "CREATING",
			EndpointAddress:      "localhost",
			EndpointPort:         8182,
			CreatedAt:            time.Now(),
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
		inst.DBInstanceStatus = "DELETING"
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

	case "CreateDBClusterSnapshot":
		snapID := params.Get("DBClusterSnapshotIdentifier")
		clusterID := params.Get("DBClusterIdentifier")
		h.store.mu.Lock()
		cluster, clusterExists := h.store.clusters[clusterID]
		if !clusterExists || cluster.Status == "DELETING" {
			h.store.mu.Unlock()
			sendError(w, 404, "DBClusterNotFoundFault", "DB cluster not found: "+clusterID)
			return
		}
		if existing, exists := h.store.snapshots[snapID]; exists && existing.Status != "DELETING" {
			h.store.mu.Unlock()
			sendError(w, 400, "DBClusterSnapshotAlreadyExistsFault", "DB cluster snapshot already exists: "+snapID)
			return
		}
		snap := &DBClusterSnapshot{
			DBClusterSnapshotIdentifier: snapID,
			DBClusterIdentifier:         clusterID,
			Status:                      "CREATING",
			Engine:                      "neptune",
			CreatedAt:                   time.Now(),
		}
		h.store.snapshots[snapID] = snap
		h.store.mu.Unlock()
		type resp struct {
			XMLName xml.Name             `xml:"CreateDBClusterSnapshotResponse"`
			Result  xmlDBClusterSnapshot `xml:"CreateDBClusterSnapshotResult>DBClusterSnapshot"`
		}
		sendXML(w, 200, resp{Result: snapshotXML(snap)})

	case "DeleteDBClusterSnapshot":
		snapID := params.Get("DBClusterSnapshotIdentifier")
		h.store.mu.Lock()
		snap := h.store.snapshots[snapID]
		if snap == nil {
			h.store.mu.Unlock()
			sendError(w, 404, "DBClusterSnapshotNotFoundFault", "DB cluster snapshot not found: "+snapID)
			return
		}
		snap.Status = "DELETING"
		h.store.mu.Unlock()
		type resp struct {
			XMLName xml.Name             `xml:"DeleteDBClusterSnapshotResponse"`
			Result  xmlDBClusterSnapshot `xml:"DeleteDBClusterSnapshotResult>DBClusterSnapshot"`
		}
		sendXML(w, 200, resp{Result: snapshotXML(snap)})

	case "DescribeDBClusterSnapshots":
		filterID := params.Get("DBClusterSnapshotIdentifier")
		clusterID := params.Get("DBClusterIdentifier")
		h.store.mu.RLock()
		var snaps []xmlDBClusterSnapshot
		for _, snap := range h.store.snapshots {
			if (filterID == "" || snap.DBClusterSnapshotIdentifier == filterID) &&
				(clusterID == "" || snap.DBClusterIdentifier == clusterID) {
				snaps = append(snaps, snapshotXML(snap))
			}
		}
		h.store.mu.RUnlock()
		type resp struct {
			XMLName   xml.Name               `xml:"DescribeDBClusterSnapshotsResponse"`
			Snapshots []xmlDBClusterSnapshot `xml:"DescribeDBClusterSnapshotsResult>DBClusterSnapshots>DBClusterSnapshot"`
		}
		sendXML(w, 200, resp{Snapshots: snaps})

	case "StartDBCluster":
		id := params.Get("DBClusterIdentifier")
		h.store.mu.Lock()
		cluster := h.store.clusters[id]
		if cluster == nil {
			h.store.mu.Unlock()
			sendError(w, 404, "DBClusterNotFoundFault", "DB cluster not found: "+id)
			return
		}
		cluster.Status = "STARTING"
		h.store.mu.Unlock()
		type resp struct {
			XMLName xml.Name     `xml:"StartDBClusterResponse"`
			Result  xmlDBCluster `xml:"StartDBClusterResult>DBCluster"`
		}
		sendXML(w, 200, resp{Result: clusterXML(cluster)})

	case "StopDBCluster":
		id := params.Get("DBClusterIdentifier")
		h.store.mu.Lock()
		cluster := h.store.clusters[id]
		if cluster == nil {
			h.store.mu.Unlock()
			sendError(w, 404, "DBClusterNotFoundFault", "DB cluster not found: "+id)
			return
		}
		cluster.Status = "STOPPING"
		h.store.mu.Unlock()
		type resp struct {
			XMLName xml.Name     `xml:"StopDBClusterResponse"`
			Result  xmlDBCluster `xml:"StopDBClusterResult>DBCluster"`
		}
		sendXML(w, 200, resp{Result: clusterXML(cluster)})

	case "ModifyDBCluster":
		id := params.Get("DBClusterIdentifier")
		h.store.mu.Lock()
		cluster := h.store.clusters[id]
		h.store.mu.Unlock()
		if cluster == nil {
			sendError(w, 404, "DBClusterNotFoundFault", "DB cluster not found: "+id)
			return
		}
		cluster.Status = "MODIFYING"
		type resp struct {
			XMLName xml.Name     `xml:"ModifyDBClusterResponse"`
			Result  xmlDBCluster `xml:"ModifyDBClusterResult>DBCluster"`
		}
		sendXML(w, 200, resp{Result: clusterXML(cluster)})

	case "ModifyDBInstance":
		id := params.Get("DBInstanceIdentifier")
		h.store.mu.Lock()
		inst := h.store.instances[id]
		h.store.mu.Unlock()
		if inst == nil {
			sendError(w, 404, "DBInstanceNotFound", "DB instance not found: "+id)
			return
		}
		inst.DBInstanceStatus = "MODIFYING"
		if v := params.Get("DBInstanceClass"); v != "" {
			inst.DBInstanceClass = v
		}
		type resp struct {
			XMLName xml.Name      `xml:"ModifyDBInstanceResponse"`
			Result  xmlDBInstance `xml:"ModifyDBInstanceResult>DBInstance"`
		}
		sendXML(w, 200, resp{Result: instanceXML(inst)})

	case "RebootDBInstance":
		id := params.Get("DBInstanceIdentifier")
		h.store.mu.RLock()
		inst := h.store.instances[id]
		h.store.mu.RUnlock()
		if inst == nil {
			sendError(w, 404, "DBInstanceNotFound", "DB instance not found: "+id)
			return
		}
		inst.DBInstanceStatus = "REBOOTING"
		type resp struct {
			XMLName xml.Name      `xml:"RebootDBInstanceResponse"`
			Result  xmlDBInstance `xml:"RebootDBInstanceResult>DBInstance"`
		}
		sendXML(w, 200, resp{Result: instanceXML(inst)})

	case "RestoreDBClusterFromSnapshot":
		id := params.Get("DBClusterIdentifier")
		engine := params.Get("Engine")
		if engine == "" {
			engine = "neptune"
		}
		cluster := &DBCluster{
			DBClusterIdentifier: id,
			Status:              "RESTORING",
			Engine:              engine,
			Endpoint:            "localhost",
			ReaderEndpoint:      "localhost",
			Port:                8182,
			CreatedAt:           time.Now(),
		}
		h.store.mu.Lock()
		h.store.clusters[id] = cluster
		h.store.mu.Unlock()
		type resp struct {
			XMLName xml.Name     `xml:"RestoreDBClusterFromSnapshotResponse"`
			Result  xmlDBCluster `xml:"RestoreDBClusterFromSnapshotResult>DBCluster"`
		}
		sendXML(w, 200, resp{Result: clusterXML(cluster)})

	default:
		sendError(w, 400, "InvalidAction", "Unknown action: "+action)
	}
}
