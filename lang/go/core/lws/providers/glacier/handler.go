package glacier

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

type Vault struct {
	VaultName    string
	VaultARN     string
	CreatedAt    time.Time
	ArchiveCount int64
	SizeInBytes  int64
}

type Archive struct {
	ArchiveId      string
	VaultName      string
	Description    string
	CreationDate   time.Time
	Size           int64
	SHA256TreeHash string
}

type Job struct {
	JobId          string
	VaultName      string
	JobDescription string
	Action         string
	StatusCode     string
	ArchiveId      string
	CreationDate   time.Time
	CompletionDate time.Time
	Completed      bool
}

type MultipartUpload struct {
	MultipartUploadId  string
	VaultName          string
	ArchiveDescription string
	PartSizeInBytes    int64
	CreationDate       time.Time
}

type Store struct {
	mu               sync.RWMutex
	vaults           map[string]*Vault           // key: vaultName
	archives         map[string]*Archive         // key: archiveId
	jobs             map[string]*Job             // key: vaultName/jobId
	multipartUploads map[string]*MultipartUpload // key: uploadId
	counter          int64
}

func NewStore() *Store {
	return &Store{
		vaults:           make(map[string]*Vault),
		archives:         make(map[string]*Archive),
		jobs:             make(map[string]*Job),
		multipartUploads: make(map[string]*MultipartUpload),
	}
}

func (s *Store) Reset() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.vaults = make(map[string]*Vault)
	s.archives = make(map[string]*Archive)
	s.jobs = make(map[string]*Job)
	s.multipartUploads = make(map[string]*MultipartUpload)
	s.counter = 0
}

func (s *Store) nextID() string {
	s.counter++
	return fmt.Sprintf("%016x-%d-%d", time.Now().UnixNano(), s.counter, time.Now().Unix())
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

// parsePath splits a Glacier path like /{accountId}/vaults[/{vaultName}[/...]]
// Returns segments after removing the leading empty string
func parsePath(path string) []string {
	parts := strings.Split(strings.TrimPrefix(path, "/"), "/")
	return parts
}

func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	// Determine operation from method + path
	parts := parsePath(r.URL.Path)
	// parts[0] = accountId or "-"
	// parts[1] = "vaults" (if present)
	// parts[2] = vaultName (if present)
	// parts[3] = "archives" | "jobs" | "multipart-uploads" (if present)
	// parts[4] = resourceId (if present)
	// parts[5] = "output" (for job output)

	if len(parts) < 2 {
		sendError(w, 400, "InvalidParameterValue", "Invalid path")
		return
	}

	// Second segment should be "vaults"
	if len(parts) >= 2 && parts[1] != "vaults" {
		sendError(w, 400, "InvalidParameterValue", "Expected /vaults path")
		return
	}

	operation := h.routeOperation(r.Method, parts)

	if state.ApplyIAMAuth(h.state, "glacier", operation, r, w, false) {
		return
	}
	if state.ApplyChaos(h.state, "glacier", operation, w, false, false) {
		return
	}

	h.handle(w, r, operation, parts)
}

func (h *Handler) routeOperation(method string, parts []string) string {
	switch {
	case len(parts) == 2 && method == http.MethodGet:
		return "ListVaults"
	case len(parts) == 3 && method == http.MethodPut:
		return "CreateVault"
	case len(parts) == 3 && method == http.MethodDelete:
		return "DeleteVault"
	case len(parts) == 3 && method == http.MethodGet:
		return "DescribeVault"
	case len(parts) == 4 && parts[3] == "archives" && method == http.MethodPost:
		return "UploadArchive"
	case len(parts) == 5 && parts[3] == "archives" && method == http.MethodDelete:
		return "DeleteArchive"
	case len(parts) == 4 && parts[3] == "jobs" && method == http.MethodPost:
		return "InitiateJob"
	case len(parts) == 4 && parts[3] == "jobs" && method == http.MethodGet:
		return "ListJobs"
	case len(parts) == 5 && parts[3] == "jobs" && method == http.MethodGet:
		return "DescribeJob"
	case len(parts) == 6 && parts[3] == "jobs" && parts[5] == "output" && method == http.MethodGet:
		return "GetJobOutput"
	case len(parts) == 4 && parts[3] == "multipart-uploads" && method == http.MethodPost:
		return "InitiateMultipartUpload"
	case len(parts) == 5 && parts[3] == "multipart-uploads" && method == http.MethodPut:
		return "UploadMultipartPart"
	case len(parts) == 5 && parts[3] == "multipart-uploads" && method == http.MethodPost:
		return "CompleteMultipartUpload"
	case len(parts) == 5 && parts[3] == "multipart-uploads" && method == http.MethodDelete:
		return "AbortMultipartUpload"
	case len(parts) == 4 && parts[3] == "multipart-uploads" && method == http.MethodGet:
		return "ListMultipartUploads"
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
	sendJSON(w, status, map[string]interface{}{"code": code, "message": msg, "type": "client"})
}

func vaultDesc(v *Vault) map[string]interface{} {
	return map[string]interface{}{
		"VaultARN":          v.VaultARN,
		"VaultName":         v.VaultName,
		"CreationDate":      v.CreatedAt.Format(time.RFC3339),
		"NumberOfArchives":  v.ArchiveCount,
		"SizeInBytes":       v.SizeInBytes,
		"LastInventoryDate": nil,
	}
}

func (h *Handler) handle(w http.ResponseWriter, r *http.Request, operation string, parts []string) {
	var vaultName string
	if len(parts) >= 3 {
		vaultName = parts[2]
	}

	switch operation {
	case "CreateVault":
		arn := fmt.Sprintf("arn:aws:glacier:%s:%s:vaults/%s", region, accountID, vaultName)
		vault := &Vault{
			VaultName: vaultName,
			VaultARN:  arn,
			CreatedAt: time.Now(),
		}
		h.store.mu.Lock()
		h.store.vaults[vaultName] = vault
		h.store.mu.Unlock()
		w.Header().Set("Location", fmt.Sprintf("/%s/vaults/%s", accountID, vaultName))
		w.WriteHeader(201)

	case "DeleteVault":
		h.store.mu.Lock()
		delete(h.store.vaults, vaultName)
		h.store.mu.Unlock()
		w.WriteHeader(204)

	case "DescribeVault":
		h.store.mu.RLock()
		vault := h.store.vaults[vaultName]
		h.store.mu.RUnlock()
		if vault == nil {
			sendError(w, 404, "ResourceNotFoundException", "Vault not found: "+vaultName)
			return
		}
		sendJSON(w, 200, vaultDesc(vault))

	case "ListVaults":
		h.store.mu.RLock()
		var vaults []map[string]interface{}
		for _, v := range h.store.vaults {
			vaults = append(vaults, vaultDesc(v))
		}
		h.store.mu.RUnlock()
		if vaults == nil {
			vaults = []map[string]interface{}{}
		}
		sendJSON(w, 200, map[string]interface{}{"VaultList": vaults, "Marker": nil})

	case "UploadArchive":
		h.store.mu.Lock()
		archiveID := h.store.nextID()
		archive := &Archive{
			ArchiveId:    archiveID,
			VaultName:    vaultName,
			Description:  r.Header.Get("x-amz-archive-description"),
			CreationDate: time.Now(),
		}
		h.store.archives[archiveID] = archive
		if v := h.store.vaults[vaultName]; v != nil {
			v.ArchiveCount++
		}
		h.store.mu.Unlock()
		w.Header().Set("x-amz-archive-id", archiveID)
		w.Header().Set("Location", fmt.Sprintf("/%s/vaults/%s/archives/%s", accountID, vaultName, archiveID))
		w.WriteHeader(201)

	case "DeleteArchive":
		archiveID := parts[4]
		h.store.mu.Lock()
		delete(h.store.archives, archiveID)
		h.store.mu.Unlock()
		w.WriteHeader(204)

	case "InitiateJob":
		var jobBody map[string]interface{}
		json.NewDecoder(r.Body).Decode(&jobBody) //nolint:errcheck
		if jobBody == nil {
			jobBody = make(map[string]interface{})
		}
		action := ""
		if v, ok := jobBody["Type"].(string); ok {
			action = v
		}
		h.store.mu.Lock()
		jobID := h.store.nextID()
		job := &Job{
			JobId:        jobID,
			VaultName:    vaultName,
			Action:       action,
			StatusCode:   "InProgress",
			CreationDate: time.Now(),
			Completed:    false,
		}
		if v, ok := jobBody["ArchiveId"].(string); ok {
			job.ArchiveId = v
		}
		if v, ok := jobBody["JobDescription"].(string); ok {
			job.JobDescription = v
		}
		h.store.jobs[vaultName+"/"+jobID] = job
		h.store.mu.Unlock()
		w.Header().Set("x-amz-job-id", jobID)
		w.Header().Set("Location", fmt.Sprintf("/%s/vaults/%s/jobs/%s", accountID, vaultName, jobID))
		w.WriteHeader(202)

	case "ListJobs":
		h.store.mu.RLock()
		var jobs []map[string]interface{}
		prefix := vaultName + "/"
		for key, job := range h.store.jobs {
			if strings.HasPrefix(key, prefix) {
				jobs = append(jobs, map[string]interface{}{
					"JobId":        job.JobId,
					"VaultARN":     fmt.Sprintf("arn:aws:glacier:%s:%s:vaults/%s", region, accountID, vaultName),
					"Action":       job.Action,
					"StatusCode":   job.StatusCode,
					"Completed":    job.Completed,
					"CreationDate": job.CreationDate.Format(time.RFC3339),
				})
			}
		}
		h.store.mu.RUnlock()
		if jobs == nil {
			jobs = []map[string]interface{}{}
		}
		sendJSON(w, 200, map[string]interface{}{"JobList": jobs, "Marker": nil})

	case "DescribeJob":
		jobID := parts[4]
		h.store.mu.RLock()
		job := h.store.jobs[vaultName+"/"+jobID]
		h.store.mu.RUnlock()
		if job == nil {
			sendError(w, 404, "ResourceNotFoundException", "Job not found: "+jobID)
			return
		}
		sendJSON(w, 200, map[string]interface{}{
			"JobId":        job.JobId,
			"Action":       job.Action,
			"StatusCode":   job.StatusCode,
			"Completed":    job.Completed,
			"CreationDate": job.CreationDate.Format(time.RFC3339),
		})

	case "GetJobOutput":
		jobID := parts[4]
		h.store.mu.RLock()
		job := h.store.jobs[vaultName+"/"+jobID]
		h.store.mu.RUnlock()
		if job == nil {
			sendError(w, 404, "ResourceNotFoundException", "Job not found: "+jobID)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(200)
		w.Write([]byte(`{}`)) //nolint:errcheck

	case "InitiateMultipartUpload":
		h.store.mu.Lock()
		uploadID := h.store.nextID()
		mu := &MultipartUpload{
			MultipartUploadId:  uploadID,
			VaultName:          vaultName,
			ArchiveDescription: r.Header.Get("x-amz-archive-description"),
			CreationDate:       time.Now(),
		}
		h.store.multipartUploads[uploadID] = mu
		h.store.mu.Unlock()
		w.Header().Set("x-amz-multipart-upload-id", uploadID)
		w.Header().Set("Location", fmt.Sprintf("/%s/vaults/%s/multipart-uploads/%s", accountID, vaultName, uploadID))
		w.WriteHeader(201)

	case "UploadMultipartPart":
		w.WriteHeader(204)

	case "CompleteMultipartUpload":
		uploadID := parts[4]
		h.store.mu.Lock()
		archiveID := h.store.nextID()
		delete(h.store.multipartUploads, uploadID)
		h.store.mu.Unlock()
		w.Header().Set("x-amz-archive-id", archiveID)
		w.Header().Set("Location", fmt.Sprintf("/%s/vaults/%s/archives/%s", accountID, vaultName, archiveID))
		w.WriteHeader(201)

	case "AbortMultipartUpload":
		uploadID := parts[4]
		h.store.mu.Lock()
		delete(h.store.multipartUploads, uploadID)
		h.store.mu.Unlock()
		w.WriteHeader(204)

	case "ListMultipartUploads":
		h.store.mu.RLock()
		var uploads []map[string]interface{}
		for _, mu := range h.store.multipartUploads {
			if mu.VaultName == vaultName {
				uploads = append(uploads, map[string]interface{}{
					"MultipartUploadId":  mu.MultipartUploadId,
					"VaultARN":           fmt.Sprintf("arn:aws:glacier:%s:%s:vaults/%s", region, accountID, vaultName),
					"ArchiveDescription": mu.ArchiveDescription,
					"CreationDate":       mu.CreationDate.Format(time.RFC3339),
				})
			}
		}
		h.store.mu.RUnlock()
		if uploads == nil {
			uploads = []map[string]interface{}{}
		}
		sendJSON(w, 200, map[string]interface{}{"UploadsList": uploads, "Marker": nil})

	default:
		sendError(w, 400, "InvalidParameterValue", "Unknown operation: "+operation)
	}
}
