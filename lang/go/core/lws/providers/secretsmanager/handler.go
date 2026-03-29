package secretsmanager

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

// Secret holds all state for a single Secrets Manager secret.
type Secret struct {
	Name         string
	ARN          string
	Description  string
	SecretString string
	SecretBinary []byte
	Deleted      bool
	DeletedAt    *time.Time
	Tags         map[string]string
	CreatedAt    time.Time
}

type Store struct {
	mu      sync.RWMutex
	secrets map[string]*Secret
}

func NewStore() *Store {
	return &Store{secrets: make(map[string]*Secret)}
}

func (s *Store) Reset() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.secrets = make(map[string]*Secret)
}

func secretARN(name string) string {
	return fmt.Sprintf("arn:aws:secretsmanager:%s:%s:secret:%s", region, accountID, name)
}

type Handler struct {
	state *state.ServerState
	store *Store
}

func NewHandler(state *state.ServerState) *Handler {
	store := NewStore()
	state.AddResetCallback(store.Reset)
	return &Handler{state: state, store: store}
}

func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	target := r.Header.Get("X-Amz-Target")
	operation := ""
	if strings.HasPrefix(target, "secretsmanager.") {
		operation = strings.TrimPrefix(target, "secretsmanager.")
	} else {
		parts := strings.SplitN(target, ".", 2)
		if len(parts) == 2 {
			operation = parts[1]
		}
	}

	if state.ApplyIAMAuth(h.state, "secretsmanager", operation, r, w, false) {
		return
	}
	if state.ApplyChaos(h.state, "secretsmanager", operation, w, false, false) {
		return
	}

	var body map[string]interface{}
	json.NewDecoder(r.Body).Decode(&body)
	if body == nil {
		body = make(map[string]interface{})
	}

	h.handle(w, operation, body)
}

func writeOK(w http.ResponseWriter, data interface{}) {
	w.Header().Set("Content-Type", "application/x-amz-json-1.1")
	w.WriteHeader(200)
	json.NewEncoder(w).Encode(data)
}

func writeErr(w http.ResponseWriter, code, msg string, status int) {
	w.Header().Set("Content-Type", "application/x-amz-json-1.1")
	w.WriteHeader(status)
	fmt.Fprintf(w, `{"__type":%q,"message":%q}`+"\n", code, msg)
}

func getString(m map[string]interface{}, key string) string {
	if v, ok := m[key]; ok {
		if s, ok := v.(string); ok {
			return s
		}
	}
	return ""
}

func secretDesc(s *Secret) map[string]interface{} {
	return map[string]interface{}{
		"Name":        s.Name,
		"ARN":         s.ARN,
		"Description": s.Description,
		"CreatedDate": s.CreatedAt.Unix(),
		"DeletedDate": nil,
	}
}

func (h *Handler) getSecret(secretID string) *Secret {
	h.store.mu.RLock()
	defer h.store.mu.RUnlock()
	// Try by name first, then by ARN
	if s, ok := h.store.secrets[secretID]; ok {
		return s
	}
	for _, s := range h.store.secrets {
		if s.ARN == secretID {
			return s
		}
	}
	return nil
}

func (h *Handler) handle(w http.ResponseWriter, operation string, body map[string]interface{}) {
	switch operation {
	case "CreateSecret":
		name := getString(body, "Name")
		secretString := getString(body, "SecretString")
		arn := secretARN(name)
		h.store.mu.Lock()
		if _, exists := h.store.secrets[name]; exists {
			h.store.mu.Unlock()
			writeErr(w, "ResourceExistsException", "Secret already exists: "+name, 400)
			return
		}
		s := &Secret{
			Name:         name,
			ARN:          arn,
			SecretString: secretString,
			Tags:         make(map[string]string),
			CreatedAt:    time.Now(),
		}
		h.store.secrets[name] = s
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{
			"ARN":       arn,
			"Name":      name,
			"VersionId": fmt.Sprintf("v-%d", time.Now().UnixNano()),
		})

	case "GetSecretValue":
		secretID := getString(body, "SecretId")
		s := h.getSecret(secretID)
		if s == nil {
			writeErr(w, "ResourceNotFoundException", "Secret not found: "+secretID, 400)
			return
		}
		if s.Deleted {
			writeErr(w, "InvalidRequestException", "Secret is deleted", 400)
			return
		}
		result := map[string]interface{}{
			"Name":      s.Name,
			"ARN":       s.ARN,
			"VersionId": fmt.Sprintf("v-%d", s.CreatedAt.UnixNano()),
		}
		if s.SecretString != "" {
			result["SecretString"] = s.SecretString
		}
		writeOK(w, result)

	case "PutSecretValue":
		secretID := getString(body, "SecretId")
		s := h.getSecret(secretID)
		if s == nil {
			writeErr(w, "ResourceNotFoundException", "Secret not found: "+secretID, 400)
			return
		}
		newValue := getString(body, "SecretString")
		h.store.mu.Lock()
		s.SecretString = newValue
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{
			"ARN":       s.ARN,
			"Name":      s.Name,
			"VersionId": fmt.Sprintf("v-%d", time.Now().UnixNano()),
		})

	case "DescribeSecret":
		secretID := getString(body, "SecretId")
		s := h.getSecret(secretID)
		if s == nil {
			writeErr(w, "ResourceNotFoundException", "Secret not found: "+secretID, 400)
			return
		}
		writeOK(w, secretDesc(s))

	case "UpdateSecret":
		secretID := getString(body, "SecretId")
		s := h.getSecret(secretID)
		if s == nil {
			writeErr(w, "ResourceNotFoundException", "Secret not found: "+secretID, 400)
			return
		}
		h.store.mu.Lock()
		if newVal := getString(body, "SecretString"); newVal != "" {
			s.SecretString = newVal
		}
		if newDesc := getString(body, "Description"); newDesc != "" {
			s.Description = newDesc
		}
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"ARN": s.ARN, "Name": s.Name})

	case "DeleteSecret":
		secretID := getString(body, "SecretId")
		s := h.getSecret(secretID)
		if s == nil {
			writeErr(w, "ResourceNotFoundException", "Secret not found: "+secretID, 400)
			return
		}
		forceDelete, _ := body["ForceDeleteWithoutRecovery"].(bool)
		h.store.mu.Lock()
		if forceDelete {
			delete(h.store.secrets, s.Name)
		} else {
			now := time.Now()
			s.Deleted = true
			s.DeletedAt = &now
		}
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{
			"ARN":          s.ARN,
			"Name":         s.Name,
			"DeletionDate": time.Now().Unix(),
		})

	case "RestoreSecret":
		secretID := getString(body, "SecretId")
		s := h.getSecret(secretID)
		if s == nil {
			writeErr(w, "ResourceNotFoundException", "Secret not found: "+secretID, 400)
			return
		}
		h.store.mu.Lock()
		s.Deleted = false
		s.DeletedAt = nil
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"ARN": s.ARN, "Name": s.Name})

	case "ListSecrets":
		h.store.mu.RLock()
		var secrets []map[string]interface{}
		for _, s := range h.store.secrets {
			if !s.Deleted {
				secrets = append(secrets, secretDesc(s))
			}
		}
		h.store.mu.RUnlock()
		if secrets == nil {
			secrets = []map[string]interface{}{}
		}
		writeOK(w, map[string]interface{}{"SecretList": secrets})

	case "ListSecretVersionIds":
		secretID := getString(body, "SecretId")
		s := h.getSecret(secretID)
		if s == nil {
			writeErr(w, "ResourceNotFoundException", "Secret not found: "+secretID, 400)
			return
		}
		writeOK(w, map[string]interface{}{
			"ARN":      s.ARN,
			"Name":     s.Name,
			"Versions": []interface{}{},
		})

	case "GetResourcePolicy":
		secretID := getString(body, "SecretId")
		s := h.getSecret(secretID)
		if s == nil {
			writeErr(w, "ResourceNotFoundException", "Secret not found: "+secretID, 400)
			return
		}
		writeOK(w, map[string]interface{}{"ARN": s.ARN, "Name": s.Name})

	case "TagResource":
		secretID := getString(body, "SecretId")
		s := h.getSecret(secretID)
		if s == nil {
			writeErr(w, "ResourceNotFoundException", "Secret not found: "+secretID, 400)
			return
		}
		tags, _ := body["Tags"].([]interface{})
		h.store.mu.Lock()
		for _, t := range tags {
			if tm, ok := t.(map[string]interface{}); ok {
				k := getString(tm, "Key")
				v := getString(tm, "Value")
				s.Tags[k] = v
			}
		}
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{})

	case "UntagResource":
		secretID := getString(body, "SecretId")
		s := h.getSecret(secretID)
		if s == nil {
			writeErr(w, "ResourceNotFoundException", "Secret not found: "+secretID, 400)
			return
		}
		tagKeys, _ := body["TagKeys"].([]interface{})
		h.store.mu.Lock()
		for _, k := range tagKeys {
			if ks, ok := k.(string); ok {
				delete(s.Tags, ks)
			}
		}
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{})

	default:
		writeErr(w, "ValidationException", "Unknown operation: "+operation, 400)
	}
}
