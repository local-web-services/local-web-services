package apigateway

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
	"sync"
	"time"

	"github.com/local-web-services/local-web-services-go-core/lws/state"
)

// ── Store ─────────────────────────────────────────────────────────────────────

type RestAPI struct {
	ID          string            `json:"id"`
	Name        string            `json:"name"`
	Description string            `json:"description"`
	CreatedDate int64             `json:"createdDate"`
	Tags        map[string]string `json:"tags"`
}

type APIResource struct {
	ID              string                     `json:"id"`
	ParentID        *string                    `json:"parentId,omitempty"`
	PathPart        string                     `json:"pathPart"`
	Path            string                     `json:"path"`
	ResourceMethods map[string]*ResourceMethod `json:"resourceMethods"`
}

type ResourceMethod struct {
	HTTPMethod        string                     `json:"httpMethod"`
	AuthorizationType string                     `json:"authorizationType"`
	APIKeyRequired    bool                       `json:"apiKeyRequired"`
	MethodIntegration *MethodIntegration         `json:"methodIntegration,omitempty"`
	MethodResponses   map[string]*MethodResponse `json:"methodResponses"`
}

type MethodIntegration struct {
	Type                 string                          `json:"type"`
	HTTPMethod           string                          `json:"httpMethod"`
	URI                  string                          `json:"uri"`
	PassthroughBehavior  string                          `json:"passthroughBehavior"`
	TimeoutInMillis      int                             `json:"timeoutInMillis"`
	IntegrationResponses map[string]*IntegrationResponse `json:"integrationResponses"`
}

type IntegrationResponse struct {
	StatusCode        string            `json:"statusCode"`
	ResponseTemplates map[string]string `json:"responseTemplates"`
}

type MethodResponse struct {
	StatusCode     string            `json:"statusCode"`
	ResponseModels map[string]string `json:"responseModels"`
}

type Deployment struct {
	ID          string `json:"id"`
	Description string `json:"description"`
	CreatedDate int64  `json:"createdDate"`
	StageName   string `json:"stageName,omitempty"`
}

type Stage struct {
	StageName       string            `json:"stageName"`
	DeploymentID    string            `json:"deploymentId"`
	Description     string            `json:"description"`
	CreatedDate     int64             `json:"createdDate"`
	LastUpdatedDate int64             `json:"lastUpdatedDate"`
	Variables       map[string]string `json:"variables"`
	Tags            map[string]string `json:"tags"`
}

type Store struct {
	mu          sync.RWMutex
	apis        map[string]*RestAPI
	resources   map[string]map[string]*APIResource
	deployments map[string]map[string]*Deployment
	stages      map[string]map[string]*Stage
}

func NewStore() *Store {
	return &Store{
		apis:        make(map[string]*RestAPI),
		resources:   make(map[string]map[string]*APIResource),
		deployments: make(map[string]map[string]*Deployment),
		stages:      make(map[string]map[string]*Stage),
	}
}

func (s *Store) Reset() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.apis = make(map[string]*RestAPI)
	s.resources = make(map[string]map[string]*APIResource)
	s.deployments = make(map[string]map[string]*Deployment)
	s.stages = make(map[string]map[string]*Stage)
}

func (s *Store) createRestAPI(name, description string, tags map[string]string) *RestAPI {
	s.mu.Lock()
	defer s.mu.Unlock()
	id := uuid10()
	if tags == nil {
		tags = map[string]string{}
	}
	api := &RestAPI{ID: id, Name: name, Description: description, CreatedDate: time.Now().Unix(), Tags: tags}
	s.apis[id] = api
	rootID := uuid10()
	s.resources[id] = map[string]*APIResource{
		rootID: {ID: rootID, PathPart: "", Path: "/", ResourceMethods: map[string]*ResourceMethod{}},
	}
	s.deployments[id] = make(map[string]*Deployment)
	s.stages[id] = make(map[string]*Stage)
	return api
}

func (s *Store) getRestAPI(id string) *RestAPI {
	s.mu.RLock()
	defer s.mu.RUnlock()
	return s.apis[id]
}

func (s *Store) listRestAPIs() []*RestAPI {
	s.mu.RLock()
	defer s.mu.RUnlock()
	apis := make([]*RestAPI, 0, len(s.apis))
	for _, a := range s.apis {
		apis = append(apis, a)
	}
	return apis
}

func (s *Store) deleteRestAPI(id string) error {
	s.mu.Lock()
	defer s.mu.Unlock()
	if _, ok := s.apis[id]; !ok {
		return fmt.Errorf("NotFoundException: Rest API %s not found", id)
	}
	delete(s.apis, id)
	delete(s.resources, id)
	delete(s.deployments, id)
	delete(s.stages, id)
	return nil
}

func (s *Store) getResources(apiID string) ([]*APIResource, error) {
	s.mu.RLock()
	defer s.mu.RUnlock()
	rm, ok := s.resources[apiID]
	if !ok {
		return nil, fmt.Errorf("NotFoundException: Rest API %s not found", apiID)
	}
	result := make([]*APIResource, 0, len(rm))
	for _, r := range rm {
		result = append(result, r)
	}
	return result, nil
}

func (s *Store) getResource(apiID, resourceID string) *APIResource {
	s.mu.RLock()
	defer s.mu.RUnlock()
	if rm, ok := s.resources[apiID]; ok {
		return rm[resourceID]
	}
	return nil
}

func (s *Store) createResource(apiID, parentID, pathPart string) (*APIResource, error) {
	s.mu.Lock()
	defer s.mu.Unlock()
	rm, ok := s.resources[apiID]
	if !ok {
		return nil, fmt.Errorf("NotFoundException: Rest API %s not found", apiID)
	}
	parent, ok := rm[parentID]
	if !ok {
		return nil, fmt.Errorf("NotFoundException: Parent resource %s not found", parentID)
	}
	path := "/" + pathPart
	if parent.Path != "/" {
		path = parent.Path + "/" + pathPart
	}
	id := uuid10()
	pID := parentID
	resource := &APIResource{ID: id, ParentID: &pID, PathPart: pathPart, Path: path, ResourceMethods: map[string]*ResourceMethod{}}
	rm[id] = resource
	return resource, nil
}

func (s *Store) deleteResource(apiID, resourceID string) error {
	s.mu.Lock()
	defer s.mu.Unlock()
	rm, ok := s.resources[apiID]
	if !ok {
		return fmt.Errorf("NotFoundException: Rest API %s not found", apiID)
	}
	if _, ok := rm[resourceID]; !ok {
		return fmt.Errorf("NotFoundException: Resource %s not found", resourceID)
	}
	delete(rm, resourceID)
	return nil
}

func (s *Store) putMethod(apiID, resourceID, httpMethod, authType string, apiKeyRequired bool) (*ResourceMethod, error) {
	s.mu.Lock()
	defer s.mu.Unlock()
	rm, ok := s.resources[apiID]
	if !ok {
		return nil, fmt.Errorf("NotFoundException: Rest API %s not found", apiID)
	}
	resource, ok := rm[resourceID]
	if !ok {
		return nil, fmt.Errorf("NotFoundException: Resource %s not found", resourceID)
	}
	if authType == "" {
		authType = "NONE"
	}
	method := &ResourceMethod{
		HTTPMethod:        httpMethod,
		AuthorizationType: authType,
		APIKeyRequired:    apiKeyRequired,
		MethodResponses:   map[string]*MethodResponse{},
	}
	resource.ResourceMethods[httpMethod] = method
	return method, nil
}

func (s *Store) getMethod(apiID, resourceID, httpMethod string) *ResourceMethod {
	s.mu.RLock()
	defer s.mu.RUnlock()
	if rm, ok := s.resources[apiID]; ok {
		if resource, ok := rm[resourceID]; ok {
			return resource.ResourceMethods[httpMethod]
		}
	}
	return nil
}

func (s *Store) deleteMethod(apiID, resourceID, httpMethod string) {
	s.mu.Lock()
	defer s.mu.Unlock()
	if rm, ok := s.resources[apiID]; ok {
		if resource, ok := rm[resourceID]; ok {
			delete(resource.ResourceMethods, httpMethod)
		}
	}
}

func (s *Store) putMethodResponse(apiID, resourceID, httpMethod, statusCode string) (*MethodResponse, error) {
	method := s.getMethod(apiID, resourceID, httpMethod)
	if method == nil {
		return nil, fmt.Errorf("NotFoundException: Method %s not found", httpMethod)
	}
	s.mu.Lock()
	defer s.mu.Unlock()
	resp := &MethodResponse{StatusCode: statusCode, ResponseModels: map[string]string{}}
	method.MethodResponses[statusCode] = resp
	return resp, nil
}

func (s *Store) putIntegration(apiID, resourceID, httpMethod, intType, uri, intHTTPMethod string) (*MethodIntegration, error) {
	method := s.getMethod(apiID, resourceID, httpMethod)
	if method == nil {
		return nil, fmt.Errorf("NotFoundException: Method %s not found", httpMethod)
	}
	if intType == "" {
		intType = "AWS_PROXY"
	}
	if intHTTPMethod == "" {
		intHTTPMethod = "POST"
	}
	s.mu.Lock()
	defer s.mu.Unlock()
	integration := &MethodIntegration{
		Type:                 intType,
		HTTPMethod:           intHTTPMethod,
		URI:                  uri,
		PassthroughBehavior:  "WHEN_NO_MATCH",
		TimeoutInMillis:      29000,
		IntegrationResponses: map[string]*IntegrationResponse{},
	}
	method.MethodIntegration = integration
	return integration, nil
}

func (s *Store) getIntegration(apiID, resourceID, httpMethod string) *MethodIntegration {
	if method := s.getMethod(apiID, resourceID, httpMethod); method != nil {
		return method.MethodIntegration
	}
	return nil
}

func (s *Store) deleteIntegration(apiID, resourceID, httpMethod string) {
	method := s.getMethod(apiID, resourceID, httpMethod)
	if method != nil {
		s.mu.Lock()
		method.MethodIntegration = nil
		s.mu.Unlock()
	}
}

func (s *Store) putIntegrationResponse(apiID, resourceID, httpMethod, statusCode string) (*IntegrationResponse, error) {
	integration := s.getIntegration(apiID, resourceID, httpMethod)
	if integration == nil {
		return nil, fmt.Errorf("NotFoundException: Integration not found")
	}
	s.mu.Lock()
	defer s.mu.Unlock()
	resp := &IntegrationResponse{StatusCode: statusCode, ResponseTemplates: map[string]string{}}
	integration.IntegrationResponses[statusCode] = resp
	return resp, nil
}

func (s *Store) createDeployment(apiID, description, stageName string) (*Deployment, error) {
	s.mu.Lock()
	defer s.mu.Unlock()
	dm, ok := s.deployments[apiID]
	if !ok {
		return nil, fmt.Errorf("NotFoundException: Rest API %s not found", apiID)
	}
	id := uuid10()
	d := &Deployment{ID: id, Description: description, CreatedDate: time.Now().Unix(), StageName: stageName}
	dm[id] = d
	if stageName != "" {
		sm := s.stages[apiID]
		if existing, ok := sm[stageName]; ok {
			existing.DeploymentID = id
			existing.LastUpdatedDate = time.Now().Unix()
		} else {
			sm[stageName] = &Stage{
				StageName: stageName, DeploymentID: id, Description: description,
				CreatedDate: time.Now().Unix(), LastUpdatedDate: time.Now().Unix(),
				Variables: map[string]string{}, Tags: map[string]string{},
			}
		}
	}
	return d, nil
}

func (s *Store) listDeployments(apiID string) ([]*Deployment, error) {
	s.mu.RLock()
	defer s.mu.RUnlock()
	dm, ok := s.deployments[apiID]
	if !ok {
		return nil, fmt.Errorf("NotFoundException: Rest API %s not found", apiID)
	}
	result := make([]*Deployment, 0, len(dm))
	for _, d := range dm {
		result = append(result, d)
	}
	return result, nil
}

func (s *Store) getDeployment(apiID, deploymentID string) *Deployment {
	s.mu.RLock()
	defer s.mu.RUnlock()
	if dm, ok := s.deployments[apiID]; ok {
		return dm[deploymentID]
	}
	return nil
}

func (s *Store) deleteDeployment(apiID, deploymentID string) error {
	s.mu.Lock()
	defer s.mu.Unlock()
	dm, ok := s.deployments[apiID]
	if !ok || dm[deploymentID] == nil {
		return fmt.Errorf("NotFoundException: Deployment %s not found", deploymentID)
	}
	delete(dm, deploymentID)
	return nil
}

func (s *Store) createStage(apiID, stageName, deploymentID, description string) (*Stage, error) {
	s.mu.Lock()
	defer s.mu.Unlock()
	sm, ok := s.stages[apiID]
	if !ok {
		return nil, fmt.Errorf("NotFoundException: Rest API %s not found", apiID)
	}
	if existing, ok := sm[stageName]; ok {
		existing.DeploymentID = deploymentID
		existing.LastUpdatedDate = time.Now().Unix()
		return existing, nil
	}
	stage := &Stage{
		StageName: stageName, DeploymentID: deploymentID, Description: description,
		CreatedDate: time.Now().Unix(), LastUpdatedDate: time.Now().Unix(),
		Variables: map[string]string{}, Tags: map[string]string{},
	}
	sm[stageName] = stage
	return stage, nil
}

func (s *Store) getStage(apiID, stageName string) *Stage {
	s.mu.RLock()
	defer s.mu.RUnlock()
	if sm, ok := s.stages[apiID]; ok {
		return sm[stageName]
	}
	return nil
}

func (s *Store) listStages(apiID string) ([]*Stage, error) {
	s.mu.RLock()
	defer s.mu.RUnlock()
	sm, ok := s.stages[apiID]
	if !ok {
		return nil, fmt.Errorf("NotFoundException: Rest API %s not found", apiID)
	}
	result := make([]*Stage, 0, len(sm))
	for _, st := range sm {
		result = append(result, st)
	}
	return result, nil
}

func (s *Store) deleteStage(apiID, stageName string) error {
	s.mu.Lock()
	defer s.mu.Unlock()
	sm, ok := s.stages[apiID]
	if !ok || sm[stageName] == nil {
		return fmt.Errorf("NotFoundException: Stage %s not found", stageName)
	}
	delete(sm, stageName)
	return nil
}

func (s *Store) updateStage(apiID, stageName string, updates map[string]interface{}) (*Stage, error) {
	stage := s.getStage(apiID, stageName)
	if stage == nil {
		return nil, fmt.Errorf("NotFoundException: Stage %s not found", stageName)
	}
	s.mu.Lock()
	defer s.mu.Unlock()
	if v, ok := updates["description"].(string); ok {
		stage.Description = v
	}
	if v, ok := updates["deploymentId"].(string); ok {
		stage.DeploymentID = v
	}
	stage.LastUpdatedDate = time.Now().Unix()
	return stage, nil
}

// ── Handler ───────────────────────────────────────────────────────────────────

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
	path := r.URL.Path
	method := r.Method

	var body map[string]interface{}
	json.NewDecoder(r.Body).Decode(&body) //nolint:errcheck
	if body == nil {
		body = map[string]interface{}{}
	}

	parts := strings.Split(strings.Trim(path, "/"), "/")

	switch {
	// POST /restapis
	case method == http.MethodPost && path == "/restapis":
		api := h.store.createRestAPI(strVal(body, "name"), strVal(body, "description"), mapStrStr(body, "tags"))
		sendJSON(w, 201, api)

	// GET /restapis
	case method == http.MethodGet && path == "/restapis":
		sendJSON(w, 200, map[string]interface{}{"items": h.store.listRestAPIs()})

	// GET /restapis/:id
	case method == http.MethodGet && len(parts) == 2 && parts[0] == "restapis":
		if api := h.store.getRestAPI(parts[1]); api != nil {
			sendJSON(w, 200, api)
		} else {
			sendError(w, 404, "NotFoundException", "Rest API not found")
		}

	// DELETE /restapis/:id
	case method == http.MethodDelete && len(parts) == 2 && parts[0] == "restapis":
		if err := h.store.deleteRestAPI(parts[1]); err != nil {
			sendError(w, 404, "NotFoundException", err.Error())
		} else {
			w.WriteHeader(202)
		}

	// GET /restapis/:id/resources
	case method == http.MethodGet && len(parts) == 3 && parts[2] == "resources":
		if resources, err := h.store.getResources(parts[1]); err != nil {
			sendError(w, 404, "NotFoundException", err.Error())
		} else {
			sendJSON(w, 200, map[string]interface{}{"items": resources})
		}

	// POST /restapis/:id/resources/:parentId
	case method == http.MethodPost && len(parts) == 4 && parts[2] == "resources":
		resource, err := h.store.createResource(parts[1], parts[3], strVal(body, "pathPart"))
		if err != nil {
			sendError(w, 404, "NotFoundException", err.Error())
		} else {
			sendJSON(w, 201, resource)
		}

	// GET /restapis/:id/resources/:resourceId
	case method == http.MethodGet && len(parts) == 4 && parts[2] == "resources":
		if r2 := h.store.getResource(parts[1], parts[3]); r2 != nil {
			sendJSON(w, 200, r2)
		} else {
			sendError(w, 404, "NotFoundException", "Resource not found")
		}

	// DELETE /restapis/:id/resources/:resourceId
	case method == http.MethodDelete && len(parts) == 4 && parts[2] == "resources":
		if err := h.store.deleteResource(parts[1], parts[3]); err != nil {
			sendError(w, 404, "NotFoundException", err.Error())
		} else {
			w.WriteHeader(202)
		}

	// Methods and integrations: parts[4] == "methods"
	case len(parts) >= 6 && parts[2] == "resources" && parts[4] == "methods":
		h.handleMethodRoute(w, method, parts, body)

	// Deployments
	case len(parts) >= 3 && parts[2] == "deployments":
		h.handleDeploymentRoute(w, method, parts, body)

	// Stages
	case len(parts) >= 3 && parts[2] == "stages":
		h.handleStageRoute(w, r, method, parts, body)

	default:
		sendError(w, 404, "NotFoundException", "Not found: "+path)
	}
}

func (h *Handler) handleMethodRoute(w http.ResponseWriter, method string, parts []string, body map[string]interface{}) {
	// parts: [restapis, :apiId, resources, :resourceId, methods, :httpMethod, ...]
	if len(parts) < 6 {
		sendError(w, 404, "NotFoundException", "Invalid path")
		return
	}
	apiID, resourceID, httpMethod := parts[1], parts[3], parts[5]

	switch {
	case method == http.MethodPut && len(parts) == 6:
		m, err := h.store.putMethod(apiID, resourceID, httpMethod, strVal(body, "authorizationType"), boolVal(body, "apiKeyRequired"))
		if err != nil {
			sendError(w, 404, "NotFoundException", err.Error())
		} else {
			sendJSON(w, 201, m)
		}
	case method == http.MethodGet && len(parts) == 6:
		if m := h.store.getMethod(apiID, resourceID, httpMethod); m != nil {
			sendJSON(w, 200, m)
		} else {
			sendError(w, 404, "NotFoundException", "Method not found")
		}
	case method == http.MethodDelete && len(parts) == 6:
		h.store.deleteMethod(apiID, resourceID, httpMethod)
		w.WriteHeader(204)

	// PUT /…/methods/:m/responses/:statusCode
	case method == http.MethodPut && len(parts) == 8 && parts[6] == "responses":
		resp, err := h.store.putMethodResponse(apiID, resourceID, httpMethod, parts[7])
		if err != nil {
			sendError(w, 404, "NotFoundException", err.Error())
		} else {
			sendJSON(w, 201, resp)
		}

	// PUT /…/methods/:m/integration
	case method == http.MethodPut && len(parts) == 7 && parts[6] == "integration":
		integ, err := h.store.putIntegration(apiID, resourceID, httpMethod, strVal(body, "type"), strVal(body, "uri"), strVal(body, "httpMethod"))
		if err != nil {
			sendError(w, 404, "NotFoundException", err.Error())
		} else {
			sendJSON(w, 201, integ)
		}
	case method == http.MethodGet && len(parts) == 7 && parts[6] == "integration":
		if integ := h.store.getIntegration(apiID, resourceID, httpMethod); integ != nil {
			sendJSON(w, 200, integ)
		} else {
			sendError(w, 404, "NotFoundException", "Integration not found")
		}
	case method == http.MethodDelete && len(parts) == 7 && parts[6] == "integration":
		h.store.deleteIntegration(apiID, resourceID, httpMethod)
		w.WriteHeader(204)

	// PUT /…/methods/:m/integration/responses/:statusCode
	case method == http.MethodPut && len(parts) == 9 && parts[6] == "integration" && parts[7] == "responses":
		resp, err := h.store.putIntegrationResponse(apiID, resourceID, httpMethod, parts[8])
		if err != nil {
			sendError(w, 404, "NotFoundException", err.Error())
		} else {
			sendJSON(w, 201, resp)
		}
	default:
		sendError(w, 404, "NotFoundException", "Not found")
	}
}

func (h *Handler) handleDeploymentRoute(w http.ResponseWriter, method string, parts []string, body map[string]interface{}) {
	apiID := parts[1]
	switch {
	case method == http.MethodPost && len(parts) == 3:
		d, err := h.store.createDeployment(apiID, strVal(body, "description"), strVal(body, "stageName"))
		if err != nil {
			sendError(w, 404, "NotFoundException", err.Error())
		} else {
			sendJSON(w, 201, d)
		}
	case method == http.MethodGet && len(parts) == 3:
		deps, err := h.store.listDeployments(apiID)
		if err != nil {
			sendError(w, 404, "NotFoundException", err.Error())
		} else {
			sendJSON(w, 200, map[string]interface{}{"items": deps})
		}
	case method == http.MethodGet && len(parts) == 4:
		if d := h.store.getDeployment(apiID, parts[3]); d != nil {
			sendJSON(w, 200, d)
		} else {
			sendError(w, 404, "NotFoundException", "Deployment not found")
		}
	case method == http.MethodDelete && len(parts) == 4:
		if err := h.store.deleteDeployment(apiID, parts[3]); err != nil {
			sendError(w, 404, "NotFoundException", err.Error())
		} else {
			w.WriteHeader(202)
		}
	default:
		sendError(w, 404, "NotFoundException", "Not found")
	}
}

func (h *Handler) handleStageRoute(w http.ResponseWriter, r *http.Request, method string, parts []string, body map[string]interface{}) {
	apiID := parts[1]
	switch {
	case method == http.MethodPost && len(parts) == 3:
		stage, err := h.store.createStage(apiID, strVal(body, "stageName"), strVal(body, "deploymentId"), strVal(body, "description"))
		if err != nil {
			sendError(w, 404, "NotFoundException", err.Error())
		} else {
			sendJSON(w, 201, stage)
		}
	case method == http.MethodGet && len(parts) == 3:
		stages, err := h.store.listStages(apiID)
		if err != nil {
			sendError(w, 404, "NotFoundException", err.Error())
		} else {
			sendJSON(w, 200, map[string]interface{}{"item": stages})
		}
	case method == http.MethodGet && len(parts) == 4:
		if stage := h.store.getStage(apiID, parts[3]); stage != nil {
			sendJSON(w, 200, stage)
		} else {
			sendError(w, 404, "NotFoundException", "Stage not found")
		}
	case method == http.MethodDelete && len(parts) == 4:
		if err := h.store.deleteStage(apiID, parts[3]); err != nil {
			sendError(w, 404, "NotFoundException", err.Error())
		} else {
			w.WriteHeader(202)
		}
	case (method == http.MethodPatch || method == http.MethodPut) && len(parts) == 4:
		var updates map[string]interface{}
		json.NewDecoder(r.Body).Decode(&updates) //nolint:errcheck
		if updates == nil {
			updates = body
		}
		if stage, err := h.store.updateStage(apiID, parts[3], updates); err != nil {
			sendError(w, 404, "NotFoundException", err.Error())
		} else {
			sendJSON(w, 200, stage)
		}
	default:
		sendError(w, 404, "NotFoundException", "Not found")
	}
}

// ── Helpers ───────────────────────────────────────────────────────────────────

func sendJSON(w http.ResponseWriter, status int, payload interface{}) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	json.NewEncoder(w).Encode(payload) //nolint:errcheck
}

func sendError(w http.ResponseWriter, status int, errType, msg string) {
	sendJSON(w, status, map[string]string{"__type": errType, "message": msg})
}

func strVal(m map[string]interface{}, key string) string {
	if v, ok := m[key]; ok {
		if s, ok := v.(string); ok {
			return s
		}
	}
	return ""
}

func boolVal(m map[string]interface{}, key string) bool {
	if v, ok := m[key]; ok {
		if b, ok := v.(bool); ok {
			return b
		}
	}
	return false
}

func mapStrStr(m map[string]interface{}, key string) map[string]string {
	result := map[string]string{}
	if v, ok := m[key]; ok {
		if mm, ok := v.(map[string]interface{}); ok {
			for k, val := range mm {
				if s, ok := val.(string); ok {
					result[k] = s
				}
			}
		}
	}
	return result
}

func uuid10() string {
	s := fmt.Sprintf("%d", time.Now().UnixNano())
	if len(s) > 10 {
		return s[len(s)-10:]
	}
	return s
}
