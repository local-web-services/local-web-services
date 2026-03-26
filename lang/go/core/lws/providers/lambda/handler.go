package lambda

import (
	"encoding/base64"
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

// ── Data types ───────────────────────────────────────────────────────────────

type FunctionState string

const (
	FunctionStateActive  FunctionState = "Active"
	FunctionStatePending FunctionState = "Pending"
	FunctionStateFailed  FunctionState = "Failed"
)

type Function struct {
	Name         string
	ARN          string
	Runtime      string
	Role         string
	Handler      string
	Description  string
	Timeout      int
	MemorySize   int
	State        FunctionState
	CodeSize     int64
	CodeSha256   string
	Version      string
	Environment  map[string]string
	Tags         map[string]string
	LastModified string
	RevisionID   string
	PackageType  string
}

type EventSourceMapping struct {
	UUID             string
	EventSourceArn   string
	FunctionArn      string
	State            string
	BatchSize        int
	StartingPosition string
	LastModified     float64
}

// ── Store ────────────────────────────────────────────────────────────────────

type Store struct {
	mu                  sync.RWMutex
	functions           map[string]*Function                // name → function
	eventSourceMappings map[string]*EventSourceMapping      // uuid → mapping
	permissions         map[string][]map[string]interface{} // functionName → permissions
}

func NewStore() *Store {
	return &Store{
		functions:           make(map[string]*Function),
		eventSourceMappings: make(map[string]*EventSourceMapping),
		permissions:         make(map[string][]map[string]interface{}),
	}
}

func (s *Store) Reset() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.functions = make(map[string]*Function)
	s.eventSourceMappings = make(map[string]*EventSourceMapping)
	s.permissions = make(map[string][]map[string]interface{})
}

// ── Handler ──────────────────────────────────────────────────────────────────

type Handler struct {
	state        *state.ServerState
	store        *Store
	dynamodbPort int
}

func NewHandler(st *state.ServerState) *Handler {
	store := NewStore()
	st.AddResetCallback(store.Reset)
	return &Handler{state: st, store: store}
}

// NewHandlerWithPorts creates a Lambda handler with cross-service port references.
func NewHandlerWithPorts(st *state.ServerState, dynamodbPort int) *Handler {
	h := NewHandler(st)
	h.dynamodbPort = dynamodbPort
	return h
}

func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	path := r.URL.Path

	if state.ApplyIAMAuth(h.state, "lambda", path, r, w, false) {
		return
	}
	if state.ApplyChaos(h.state, "lambda", path, w, false, false) {
		return
	}

	h.store.mu.Lock()
	defer h.store.mu.Unlock()

	switch {
	// ── Functions ─────────────────────────────────────────────────────────────
	case r.Method == http.MethodPost && path == "/2015-03-31/functions":
		h.createFunction(w, r)
	case r.Method == http.MethodGet && path == "/2015-03-31/functions":
		h.listFunctions(w)
	case r.Method == http.MethodGet && strings.HasPrefix(path, "/2015-03-31/functions/") && !strings.Contains(path[len("/2015-03-31/functions/"):], "/"):
		name := strings.TrimPrefix(path, "/2015-03-31/functions/")
		h.getFunction(w, name)
	case r.Method == http.MethodDelete && strings.HasPrefix(path, "/2015-03-31/functions/") && !strings.Contains(strings.TrimPrefix(path, "/2015-03-31/functions/"), "/"):
		name := strings.TrimPrefix(path, "/2015-03-31/functions/")
		h.deleteFunction(w, name)
	case r.Method == http.MethodPut && strings.HasSuffix(path, "/code"):
		parts := strings.Split(path, "/")
		if len(parts) >= 5 {
			h.updateFunctionCode(w, parts[3])
		}
	case r.Method == http.MethodPut && strings.HasSuffix(path, "/configuration"):
		parts := strings.Split(path, "/")
		if len(parts) >= 5 {
			h.updateFunctionConfiguration(w, r, parts[3])
		}
	case r.Method == http.MethodGet && strings.HasSuffix(path, "/configuration"):
		parts := strings.Split(path, "/")
		if len(parts) >= 5 {
			h.getFunctionConfiguration(w, parts[3])
		}

	// ── Invocations ───────────────────────────────────────────────────────────
	case strings.HasSuffix(path, "/invocations"):
		parts := strings.Split(path, "/")
		if len(parts) >= 5 {
			h.invokeFunction(w, r, parts[3])
		}

	// ── Event source mappings ─────────────────────────────────────────────────
	case r.Method == http.MethodPost && path == "/2015-03-31/event-source-mappings":
		h.createEventSourceMapping(w, r)
	case r.Method == http.MethodGet && path == "/2015-03-31/event-source-mappings":
		h.listEventSourceMappings(w, r)
	case r.Method == http.MethodGet && strings.HasPrefix(path, "/2015-03-31/event-source-mappings/"):
		uuid := strings.TrimPrefix(path, "/2015-03-31/event-source-mappings/")
		h.getEventSourceMapping(w, uuid)
	case r.Method == http.MethodDelete && strings.HasPrefix(path, "/2015-03-31/event-source-mappings/"):
		uuid := strings.TrimPrefix(path, "/2015-03-31/event-source-mappings/")
		h.deleteEventSourceMapping(w, uuid)
	case r.Method == http.MethodPut && strings.HasPrefix(path, "/2015-03-31/event-source-mappings/"):
		uuid := strings.TrimPrefix(path, "/2015-03-31/event-source-mappings/")
		h.updateEventSourceMapping(w, r, uuid)

	// ── Permissions ───────────────────────────────────────────────────────────
	case r.Method == http.MethodPost && strings.HasSuffix(path, "/policy"):
		parts := strings.Split(path, "/")
		if len(parts) >= 5 {
			h.addPermission(w, r, parts[3])
		}
	case r.Method == http.MethodGet && strings.HasSuffix(path, "/policy"):
		parts := strings.Split(path, "/")
		if len(parts) >= 5 {
			h.getPolicy(w, parts[3])
		}
	case r.Method == http.MethodDelete && strings.Contains(path, "/policy/"):
		parts := strings.Split(path, "/")
		if len(parts) >= 6 {
			h.removePermission(w, parts[3], parts[5])
		}

	// ── Tags ──────────────────────────────────────────────────────────────────
	case r.Method == http.MethodPost && strings.HasPrefix(path, "/2017-03-31/tags/"):
		arn := strings.TrimPrefix(path, "/2017-03-31/tags/")
		h.tagResource(w, r, arn)
	case r.Method == http.MethodGet && strings.HasPrefix(path, "/2017-03-31/tags/"):
		arn := strings.TrimPrefix(path, "/2017-03-31/tags/")
		h.listTags(w, arn)
	case r.Method == http.MethodDelete && strings.HasPrefix(path, "/2017-03-31/tags/"):
		arn := strings.TrimPrefix(path, "/2017-03-31/tags/")
		h.untagResource(w, r, arn)

	// ── Concurrency ───────────────────────────────────────────────────────────
	case strings.Contains(path, "/concurrency"):
		parts := strings.Split(path, "/")
		if len(parts) >= 5 {
			h.putFunctionConcurrency(w, parts[3])
		}

	default:
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(404)
		json.NewEncoder(w).Encode(map[string]interface{}{ //nolint:errcheck
			"__type":  "UnknownOperationException",
			"message": fmt.Sprintf("lws: Lambda path '%s' method '%s' not implemented", path, r.Method),
		})
	}
}

// ── Function operations ────────────────────────────────────────────────────────

func (h *Handler) createFunction(w http.ResponseWriter, r *http.Request) {
	var body map[string]interface{}
	json.NewDecoder(r.Body).Decode(&body) //nolint:errcheck
	name := str(body, "FunctionName")
	if _, exists := h.store.functions[name]; exists {
		jsonErr(w, "ResourceConflictException", "Function already exist: "+name)
		return
	}
	now := time.Now().UTC().Format(time.RFC3339)
	fn := &Function{
		Name:         name,
		ARN:          fmt.Sprintf("arn:aws:lambda:%s:%s:function:%s", region, accountID, name),
		Runtime:      strOrDefault(body, "Runtime", "python3.9"),
		Role:         str(body, "Role"),
		Handler:      strOrDefault(body, "Handler", "handler.handler"),
		Description:  str(body, "Description"),
		Timeout:      intOrDefault(body, "Timeout", 30),
		MemorySize:   intOrDefault(body, "MemorySize", 128),
		State:        FunctionStateActive,
		CodeSize:     1024,
		CodeSha256:   base64.StdEncoding.EncodeToString([]byte(name)),
		Version:      "$LATEST",
		Environment:  envVarsFrom(body),
		Tags:         tagsFrom(body),
		LastModified: now,
		RevisionID:   genID(),
		PackageType:  strOrDefault(body, "PackageType", "Zip"),
	}
	h.store.functions[name] = fn
	jsonCreated(w, functionToMap(fn))
}

func (h *Handler) getFunction(w http.ResponseWriter, name string) {
	fn, ok := h.store.functions[name]
	if !ok {
		jsonErr(w, "ResourceNotFoundException", "Function "+name+" not found")
		return
	}
	jsonOK(w, map[string]interface{}{
		"Configuration": functionToMap(fn),
		"Code": map[string]interface{}{
			"RepositoryType": "S3",
			"Location":       fmt.Sprintf("https://s3.amazonaws.com/lws-lambda/%s.zip", name),
		},
		"Tags": fn.Tags,
	})
}

func (h *Handler) listFunctions(w http.ResponseWriter) {
	fns := []map[string]interface{}{}
	for _, fn := range h.store.functions {
		fns = append(fns, functionToMap(fn))
	}
	jsonOK(w, map[string]interface{}{"Functions": fns})
}

func (h *Handler) deleteFunction(w http.ResponseWriter, name string) {
	if _, ok := h.store.functions[name]; !ok {
		jsonErr(w, "ResourceNotFoundException", "Function "+name+" not found")
		return
	}
	// Reject if there are active executions (modelled via exhausted capacity).
	if h.state.GetCapacityRule("lambda").IsExhausted() {
		jsonErr(w, "ResourceConflictException", "Function "+name+" has active executions")
		return
	}
	delete(h.store.functions, name)
	w.WriteHeader(204)
}

func (h *Handler) updateFunctionCode(w http.ResponseWriter, name string) {
	fn, ok := h.store.functions[name]
	if !ok {
		jsonErr(w, "ResourceNotFoundException", "Function "+name+" not found")
		return
	}
	fn.LastModified = time.Now().UTC().Format(time.RFC3339)
	fn.RevisionID = genID()
	jsonOK(w, functionToMap(fn))
}

func (h *Handler) updateFunctionConfiguration(w http.ResponseWriter, r *http.Request, name string) {
	fn, ok := h.store.functions[name]
	if !ok {
		jsonErr(w, "ResourceNotFoundException", "Function "+name+" not found")
		return
	}
	var body map[string]interface{}
	json.NewDecoder(r.Body).Decode(&body) //nolint:errcheck
	if v, ok := body["Timeout"].(float64); ok {
		fn.Timeout = int(v)
	}
	if v, ok := body["MemorySize"].(float64); ok {
		fn.MemorySize = int(v)
	}
	if v, ok := body["Description"].(string); ok {
		fn.Description = v
	}
	fn.LastModified = time.Now().UTC().Format(time.RFC3339)
	jsonOK(w, functionToMap(fn))
}

func (h *Handler) getFunctionConfiguration(w http.ResponseWriter, name string) {
	fn, ok := h.store.functions[name]
	if !ok {
		jsonErr(w, "ResourceNotFoundException", "Function "+name+" not found")
		return
	}
	jsonOK(w, functionToMap(fn))
}

func (h *Handler) invokeFunction(w http.ResponseWriter, r *http.Request, name string) {
	if _, ok := h.store.functions[name]; !ok {
		jsonErr(w, "ResourceNotFoundException", "Function "+name+" not found")
		return
	}
	if h.state.GetCapacityRule("lambda").IsExhausted() {
		jsonErr(w, "ServiceUnavailableException", "No invocation slot is available")
		return
	}
	invType := r.Header.Get("X-Amz-Invocation-Type")
	if invType == "Event" {
		w.WriteHeader(202)
		return
	}
	// Synchronous: return a simple successful payload
	payload := base64.StdEncoding.EncodeToString([]byte(`{"statusCode":200,"body":"lws-mock-response"}`))
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("X-Amz-Function-Error", "")
	w.WriteHeader(200)
	w.Write([]byte(payload)) //nolint:errcheck
}

// ── Event source mapping operations ──────────────────────────────────────────

func (h *Handler) createEventSourceMapping(w http.ResponseWriter, r *http.Request) {
	var body map[string]interface{}
	json.NewDecoder(r.Body).Decode(&body) //nolint:errcheck
	eventSourceArn := str(body, "EventSourceArn")
	functionName := str(body, "FunctionName")
	if functionName == "" {
		functionName = h.arnToFunctionName(str(body, "FunctionArn"))
	}

	// Validate the referenced Lambda function exists.
	if functionName != "" {
		if _, ok := h.store.functions[functionName]; !ok {
			jsonErr(w, "ResourceNotFoundException", "Function not found: "+functionName)
			return
		}
	}

	// Check for duplicate event source mapping (same source ARN + function).
	functionArn := ""
	if fn, ok := h.store.functions[functionName]; ok {
		functionArn = fn.ARN
	}
	for _, m := range h.store.eventSourceMappings {
		if m.EventSourceArn == eventSourceArn && m.FunctionArn == functionArn {
			jsonErr(w, "ResourceConflictException", "Event source mapping already exists for "+eventSourceArn)
			return
		}
	}

	// Validate the DynamoDB stream table exists and has streaming enabled.
	if h.dynamodbPort != 0 && strings.Contains(eventSourceArn, ":dynamodb:") && strings.Contains(eventSourceArn, "/stream/") {
		tableName := dynamodbTableNameFromStreamArn(eventSourceArn)
		if tableName != "" {
			status, streamEnabled := h.describeDynamoDBTable(tableName)
			if status == "" {
				jsonErr(w, "ResourceNotFoundException", "DynamoDB table not found: "+tableName)
				return
			}
			if !streamEnabled {
				jsonErr(w, "InvalidParameterValueException", "DynamoDB table "+tableName+" does not have streaming enabled")
				return
			}
		}
	}

	uuid := genID()
	now := nowSeconds()
	batchSize := intOrDefault(body, "BatchSize", 10)
	mapping := &EventSourceMapping{
		UUID:             uuid,
		EventSourceArn:   eventSourceArn,
		FunctionArn:      functionArn,
		State:            "Enabled",
		BatchSize:        batchSize,
		StartingPosition: strOrDefault(body, "StartingPosition", "TRIM_HORIZON"),
		LastModified:     now,
	}
	h.store.eventSourceMappings[uuid] = mapping
	jsonCreated(w, mappingToMap(mapping))
}

// dynamodbTableNameFromStreamArn extracts the table name from a DynamoDB stream ARN.
// Stream ARN format: arn:aws:dynamodb:region:accountid:table/tableName/stream/timestamp
func dynamodbTableNameFromStreamArn(arn string) string {
	// Find the "table/" prefix
	idx := strings.Index(arn, "table/")
	if idx < 0 {
		return ""
	}
	rest := arn[idx+len("table/"):]
	// Remove stream suffix
	if slashIdx := strings.Index(rest, "/stream/"); slashIdx >= 0 {
		return rest[:slashIdx]
	}
	return rest
}

// describeDynamoDBTable makes an HTTP call to the DynamoDB handler to check
// whether a table exists and has streaming enabled.
// Returns (tableStatus, streamEnabled). tableStatus is "" if table not found.
func (h *Handler) describeDynamoDBTable(tableName string) (string, bool) {
	reqBody, err := json.Marshal(map[string]string{"TableName": tableName})
	if err != nil {
		return "", false
	}
	url := fmt.Sprintf("http://127.0.0.1:%d/", h.dynamodbPort)
	req, err := http.NewRequest(http.MethodPost, url, strings.NewReader(string(reqBody)))
	if err != nil {
		return "", false
	}
	req.Header.Set("Content-Type", "application/x-amz-json-1.0")
	req.Header.Set("X-Amz-Target", "DynamoDB_20120810.DescribeTable")
	resp, err := http.DefaultClient.Do(req) //nolint:noctx
	if err != nil {
		return "", false
	}
	defer resp.Body.Close()
	if resp.StatusCode != 200 {
		return "", false
	}
	var result map[string]interface{}
	if err := json.NewDecoder(resp.Body).Decode(&result); err != nil {
		return "", false
	}
	table, ok := result["Table"].(map[string]interface{})
	if !ok {
		return "", false
	}
	status, _ := table["TableStatus"].(string)
	streamSpec, _ := table["StreamSpecification"].(map[string]interface{})
	streamEnabled := false
	if streamSpec != nil {
		if enabled, ok := streamSpec["StreamEnabled"].(bool); ok {
			streamEnabled = enabled
		}
	}
	return status, streamEnabled
}

func (h *Handler) listEventSourceMappings(w http.ResponseWriter, r *http.Request) {
	mappings := []map[string]interface{}{}
	for _, m := range h.store.eventSourceMappings {
		mappings = append(mappings, mappingToMap(m))
	}
	jsonOK(w, map[string]interface{}{"EventSourceMappings": mappings})
}

func (h *Handler) getEventSourceMapping(w http.ResponseWriter, uuid string) {
	m, ok := h.store.eventSourceMappings[uuid]
	if !ok {
		jsonErr(w, "ResourceNotFoundException", "Event source mapping "+uuid+" not found")
		return
	}
	jsonOK(w, mappingToMap(m))
}

func (h *Handler) deleteEventSourceMapping(w http.ResponseWriter, uuid string) {
	if _, ok := h.store.eventSourceMappings[uuid]; !ok {
		jsonErr(w, "ResourceNotFoundException", "Event source mapping "+uuid+" not found")
		return
	}
	delete(h.store.eventSourceMappings, uuid)
	w.WriteHeader(202)
}

func (h *Handler) updateEventSourceMapping(w http.ResponseWriter, r *http.Request, uuid string) {
	m, ok := h.store.eventSourceMappings[uuid]
	if !ok {
		jsonErr(w, "ResourceNotFoundException", "Event source mapping "+uuid+" not found")
		return
	}
	var body map[string]interface{}
	json.NewDecoder(r.Body).Decode(&body) //nolint:errcheck
	if v, ok := body["Enabled"].(bool); ok {
		if v {
			m.State = "Enabled"
		} else {
			m.State = "Disabled"
		}
	}
	m.LastModified = nowSeconds()
	jsonOK(w, mappingToMap(m))
}

// ── Permission operations ─────────────────────────────────────────────────────

func (h *Handler) addPermission(w http.ResponseWriter, r *http.Request, name string) {
	if _, ok := h.store.functions[name]; !ok {
		jsonErr(w, "ResourceNotFoundException", "Function "+name+" not found")
		return
	}
	var body map[string]interface{}
	json.NewDecoder(r.Body).Decode(&body) //nolint:errcheck
	if _, ok := h.store.permissions[name]; !ok {
		h.store.permissions[name] = []map[string]interface{}{}
	}
	h.store.permissions[name] = append(h.store.permissions[name], body)
	statementBytes, _ := json.Marshal(body)
	jsonOK(w, map[string]interface{}{"Statement": string(statementBytes)})
}

func (h *Handler) removePermission(w http.ResponseWriter, name, statementID string) {
	if _, ok := h.store.functions[name]; !ok {
		jsonErr(w, "ResourceNotFoundException", "Function "+name+" not found")
		return
	}
	perms := h.store.permissions[name]
	if len(perms) == 0 {
		jsonErr(w, "ResourceNotFoundException", "Function "+name+" has no resource policy")
		return
	}
	var updated []map[string]interface{}
	found := false
	for _, p := range perms {
		sid, _ := p["StatementId"].(string)
		if sid == statementID {
			found = true
		} else {
			updated = append(updated, p)
		}
	}
	if !found {
		jsonErr(w, "ResourceNotFoundException", "Statement "+statementID+" not found in resource policy")
		return
	}
	h.store.permissions[name] = updated
	w.WriteHeader(204)
}

func (h *Handler) getPolicy(w http.ResponseWriter, name string) {
	perms := h.store.permissions[name]
	policy := map[string]interface{}{
		"Version":   "2012-10-17",
		"Statement": perms,
	}
	policyBytes, _ := json.Marshal(policy)
	jsonOK(w, map[string]interface{}{
		"Policy":     string(policyBytes),
		"RevisionId": genID(),
	})
}

func (h *Handler) arnToFunctionName(arn string) string {
	// arn:aws:lambda:us-east-1:000000000000:function:{name}
	parts := strings.Split(arn, ":")
	if len(parts) >= 7 && parts[5] == "function" {
		return parts[6]
	}
	// If it's already a name, return as-is
	return arn
}

func (h *Handler) tagResource(w http.ResponseWriter, r *http.Request, arn string) {
	name := h.arnToFunctionName(arn)
	fn, ok := h.store.functions[name]
	if !ok {
		jsonErr(w, "ResourceNotFoundException", "Function "+name+" not found")
		return
	}
	var body map[string]interface{}
	json.NewDecoder(r.Body).Decode(&body) //nolint:errcheck
	if tags, ok := body["Tags"].(map[string]interface{}); ok {
		if fn.Tags == nil {
			fn.Tags = make(map[string]string)
		}
		for k, v := range tags {
			if s, ok := v.(string); ok {
				fn.Tags[k] = s
			}
		}
	}
	w.WriteHeader(204)
}

func (h *Handler) listTags(w http.ResponseWriter, arn string) {
	name := h.arnToFunctionName(arn)
	fn, ok := h.store.functions[name]
	if !ok {
		jsonErr(w, "ResourceNotFoundException", "Function "+name+" not found")
		return
	}
	tags := map[string]string{}
	for k, v := range fn.Tags {
		tags[k] = v
	}
	jsonOK(w, map[string]interface{}{"Tags": tags})
}

func (h *Handler) untagResource(w http.ResponseWriter, r *http.Request, arn string) {
	name := h.arnToFunctionName(arn)
	fn, ok := h.store.functions[name]
	if !ok {
		jsonErr(w, "ResourceNotFoundException", "Function "+name+" not found")
		return
	}
	tagKeys := r.URL.Query()["tagKeys"]
	if len(tagKeys) == 0 {
		w.WriteHeader(204)
		return
	}
	for _, key := range tagKeys {
		if _, exists := fn.Tags[key]; !exists {
			jsonErr(w, "ResourceNotFoundException", "Tag key "+key+" does not exist on function "+name)
			return
		}
	}
	for _, key := range tagKeys {
		delete(fn.Tags, key)
	}
	w.WriteHeader(204)
}

func (h *Handler) putFunctionConcurrency(w http.ResponseWriter, name string) {
	if _, ok := h.store.functions[name]; !ok {
		jsonErr(w, "ResourceNotFoundException", "Function "+name+" not found")
		return
	}
	jsonOK(w, map[string]interface{}{"ReservedConcurrentExecutions": 5})
}

// ── Helpers ───────────────────────────────────────────────────────────────────

func nowSeconds() float64 {
	return float64(time.Now().UnixMilli()) / 1000.0
}

func genID() string {
	t := fmt.Sprintf("%016x", time.Now().UnixNano())
	if len(t) > 16 {
		return t[:16]
	}
	return t
}

func str(body map[string]interface{}, key string) string {
	v, _ := body[key].(string)
	return v
}

func strOrDefault(body map[string]interface{}, key, def string) string {
	v, ok := body[key].(string)
	if !ok || v == "" {
		return def
	}
	return v
}

func intOrDefault(body map[string]interface{}, key string, def int) int {
	if v, ok := body[key].(float64); ok {
		return int(v)
	}
	return def
}

func envVarsFrom(body map[string]interface{}) map[string]string {
	result := make(map[string]string)
	if env, ok := body["Environment"].(map[string]interface{}); ok {
		if vars, ok := env["Variables"].(map[string]interface{}); ok {
			for k, v := range vars {
				if s, ok := v.(string); ok {
					result[k] = s
				}
			}
		}
	}
	return result
}

func tagsFrom(body map[string]interface{}) map[string]string {
	result := make(map[string]string)
	if tags, ok := body["Tags"].(map[string]interface{}); ok {
		for k, v := range tags {
			if s, ok := v.(string); ok {
				result[k] = s
			}
		}
	}
	return result
}

func functionToMap(fn *Function) map[string]interface{} {
	envVars := map[string]interface{}{}
	for k, v := range fn.Environment {
		envVars[k] = v
	}
	return map[string]interface{}{
		"FunctionName":  fn.Name,
		"FunctionArn":   fn.ARN,
		"Runtime":       fn.Runtime,
		"Role":          fn.Role,
		"Handler":       fn.Handler,
		"Description":   fn.Description,
		"Timeout":       fn.Timeout,
		"MemorySize":    fn.MemorySize,
		"State":         string(fn.State),
		"CodeSize":      fn.CodeSize,
		"CodeSha256":    fn.CodeSha256,
		"Version":       fn.Version,
		"LastModified":  fn.LastModified,
		"RevisionId":    fn.RevisionID,
		"PackageType":   fn.PackageType,
		"Environment":   map[string]interface{}{"Variables": envVars},
		"Architectures": []string{"x86_64"},
	}
}

func mappingToMap(m *EventSourceMapping) map[string]interface{} {
	return map[string]interface{}{
		"UUID":                  m.UUID,
		"EventSourceArn":        m.EventSourceArn,
		"FunctionArn":           m.FunctionArn,
		"State":                 m.State,
		"BatchSize":             m.BatchSize,
		"StartingPosition":      m.StartingPosition,
		"LastModified":          m.LastModified,
		"StateTransitionReason": "User action",
	}
}

func jsonOK(w http.ResponseWriter, body interface{}) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(200)
	json.NewEncoder(w).Encode(body) //nolint:errcheck
}

func jsonCreated(w http.ResponseWriter, body interface{}) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(201)
	json.NewEncoder(w).Encode(body) //nolint:errcheck
}

func jsonErr(w http.ResponseWriter, errType, message string) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(400)
	json.NewEncoder(w).Encode(map[string]interface{}{ //nolint:errcheck
		"__type":  errType,
		"message": message,
	})
}
