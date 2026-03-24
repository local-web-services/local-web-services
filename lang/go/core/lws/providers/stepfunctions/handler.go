package stepfunctions

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"math"
	"net/http"
	"strings"
	"sync"
	"time"

	"github.com/local-web-services/local-web-services-go-core/lws/state"
)

const accountID = "000000000000"
const region = "us-east-1"

// HistoryEvent is one entry in an execution's event history.
type HistoryEvent struct {
	ID        int
	Type      string
	Timestamp time.Time
	Details   map[string]interface{}
}

// StateMachine stores state machine definition and metadata.
type StateMachine struct {
	Arn        string
	Name       string
	Definition string
	RoleArn    string
	Type       string
	Status     string
	CreatedAt  time.Time
	Tags       []map[string]string
}

// Execution tracks a single state machine execution.
type Execution struct {
	Arn             string
	StateMachineArn string
	Name            string
	Status          string
	Input           string
	Output          string
	StartDate       time.Time
	StopDate        *time.Time
	History         []HistoryEvent
}

// Store is the in-memory store for Step Functions.
type Store struct {
	mu            sync.RWMutex
	stateMachines map[string]*StateMachine
	executions    map[string]*Execution
	execCounter   int
}

// NewStore creates an empty Store.
func NewStore() *Store {
	return &Store{
		stateMachines: make(map[string]*StateMachine),
		executions:    make(map[string]*Execution),
	}
}

// Reset clears all state.
func (s *Store) Reset() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.stateMachines = make(map[string]*StateMachine)
	s.executions = make(map[string]*Execution)
	s.execCounter = 0
}

func smARN(name string) string {
	return fmt.Sprintf("arn:aws:states:%s:%s:stateMachine:%s", region, accountID, name)
}

func execARN(smName, execName string) string {
	return fmt.Sprintf("arn:aws:states:%s:%s:execution:%s:%s", region, accountID, smName, execName)
}

// responseRecorder captures the status code written to a ResponseWriter.
type responseRecorder struct {
	http.ResponseWriter
	status int
}

func (r *responseRecorder) WriteHeader(code int) {
	r.status = code
	r.ResponseWriter.WriteHeader(code)
}

// ServicePorts holds the local port numbers for each service the engine may call.
type ServicePorts struct {
	DynamoDB       int
	SQS            int
	S3             int
	SNS            int
	SecretsManager int
	SSM            int
	EventBridge    int
}

// Handler is the HTTP handler for the Step Functions provider.
type Handler struct {
	state        *state.ServerState
	store        *Store
	servicePorts ServicePorts
}

// NewHandler creates a new Step Functions handler and registers the reset callback.
func NewHandler(ss *state.ServerState, ports ServicePorts) *Handler {
	store := NewStore()
	ss.AddResetCallback(store.Reset)
	return &Handler{state: ss, store: store, servicePorts: ports}
}

func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	start := time.Now()
	target := r.Header.Get("X-Amz-Target")
	operation := ""
	if strings.HasPrefix(target, "AWSStepFunctions.") {
		operation = strings.TrimPrefix(target, "AWSStepFunctions.")
	} else {
		parts := strings.SplitN(target, ".", 2)
		if len(parts) == 2 {
			operation = parts[1]
		}
	}

	rec := &responseRecorder{ResponseWriter: w, status: 200}

	if state.ApplyIAMAuth(h.state, "states", operation, r, rec, false) {
		h.appendLog(operation, r, rec.status, time.Since(start))
		return
	}
	if state.ApplyChaos(h.state, "stepfunctions", operation, rec, false, false) {
		h.appendLog(operation, r, rec.status, time.Since(start))
		return
	}

	// Check for fake rules before executing real logic.
	if fake := h.state.GetFakeRule("stepfunctions", operation); fake != nil {
		if fake.DelayMs > 0 {
			time.Sleep(time.Duration(fake.DelayMs) * time.Millisecond)
		}
		ct := fake.ContentType
		if ct == "" {
			ct = "application/x-amz-json-1.0"
		}
		rec.Header().Set("Content-Type", ct)
		rec.WriteHeader(fake.Status)
		if fake.Body != "" {
			fmt.Fprint(rec, fake.Body)
		}
		h.appendLog(operation, r, rec.status, time.Since(start))
		return
	}

	var body map[string]interface{}
	json.NewDecoder(r.Body).Decode(&body)
	if body == nil {
		body = make(map[string]interface{})
	}

	h.handle(rec, operation, body)
	h.appendLog(operation, r, rec.status, time.Since(start))
}

func (h *Handler) appendLog(operation string, r *http.Request, status int, duration time.Duration) {
	h.state.AppendLog(state.LogEntry{
		Timestamp:  time.Now().UTC().Format(time.RFC3339),
		Service:    "stepfunctions",
		Operation:  operation,
		Method:     r.Method,
		Path:       r.URL.Path,
		Status:     status,
		DurationMs: duration.Milliseconds(),
		RequestID:  state.NewRequestID(),
	})
}

func writeOK(w http.ResponseWriter, data interface{}) {
	w.Header().Set("Content-Type", "application/x-amz-json-1.0")
	w.WriteHeader(200)
	json.NewEncoder(w).Encode(data)
}

func writeErr(w http.ResponseWriter, code, msg string, status int) {
	w.Header().Set("Content-Type", "application/x-amz-json-1.0")
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

func smDesc(sm *StateMachine) map[string]interface{} {
	return map[string]interface{}{
		"stateMachineArn": sm.Arn,
		"name":            sm.Name,
		"definition":      sm.Definition,
		"roleArn":         sm.RoleArn,
		"type":            sm.Type,
		"status":          sm.Status,
		"creationDate":    sm.CreatedAt.Unix(),
	}
}

// ============================================================
// State machine execution engine
// ============================================================

// engine runs a parsed state machine definition against an input document.
type engine struct {
	definition   map[string]interface{}
	history      []HistoryEvent
	eventID      int
	servicePorts ServicePorts
}

func newEngine(definition string, ports ServicePorts) (*engine, error) {
	var def map[string]interface{}
	if err := json.Unmarshal([]byte(definition), &def); err != nil {
		return nil, fmt.Errorf("invalid definition: %w", err)
	}
	return &engine{definition: def, servicePorts: ports}, nil
}

func (e *engine) addEvent(eventType string, details map[string]interface{}) {
	e.eventID++
	e.history = append(e.history, HistoryEvent{
		ID:        e.eventID,
		Type:      eventType,
		Timestamp: time.Now(),
		Details:   details,
	})
}

// run executes the state machine and returns the final output JSON string
// plus status ("SUCCEEDED" or "FAILED").
func (e *engine) run(inputJSON string) (string, string, string, string) {
	// Parse input.
	var input interface{}
	if err := json.Unmarshal([]byte(inputJSON), &input); err != nil {
		input = map[string]interface{}{}
	}

	e.addEvent("ExecutionStarted", map[string]interface{}{"input": inputJSON})

	statesRaw, _ := e.definition["States"].(map[string]interface{})
	startAt, _ := e.definition["StartAt"].(string)

	output, errCode, errCause := e.runStates(statesRaw, startAt, input)

	outputJSON, _ := json.Marshal(output)
	if errCode != "" {
		e.addEvent("ExecutionFailed", map[string]interface{}{
			"error": errCode,
			"cause": errCause,
		})
		return string(outputJSON), "FAILED", errCode, errCause
	}
	e.addEvent("ExecutionSucceeded", map[string]interface{}{"output": string(outputJSON)})
	return string(outputJSON), "SUCCEEDED", "", ""
}

// runStates drives the state machine starting from startAt.
// Returns (output, errorCode, errorCause).
func (e *engine) runStates(states map[string]interface{}, startAt string, input interface{}) (interface{}, string, string) {
	currentState := startAt
	currentInput := input

	for {
		if currentState == "" {
			break
		}
		stateRaw, ok := states[currentState]
		if !ok {
			return nil, "States.Runtime.NoSuchState", fmt.Sprintf("State not found: %s", currentState)
		}
		stateDef, _ := stateRaw.(map[string]interface{})

		e.addEvent("StateEntered", map[string]interface{}{
			"name":  currentState,
			"input": marshalJSON(currentInput),
		})

		output, next, errCode, errCause := e.executeState(states, currentState, stateDef, currentInput)
		if errCode != "" {
			return nil, errCode, errCause
		}

		e.addEvent("StateExited", map[string]interface{}{
			"name":   currentState,
			"output": marshalJSON(output),
		})

		if isEnd(stateDef) || next == "" {
			return output, "", ""
		}
		currentInput = output
		currentState = next
	}
	return currentInput, "", ""
}

// executeState dispatches to the appropriate state type handler.
// Returns (output, nextStateName, errorCode, errorCause).
func (e *engine) executeState(states map[string]interface{}, name string, def map[string]interface{}, input interface{}) (interface{}, string, string, string) {
	stateType, _ := def["Type"].(string)

	switch stateType {
	case "Pass":
		return e.executePass(def, input)
	case "Task":
		return e.executeTask(def, input)
	case "Choice":
		return e.executeChoice(def, input)
	case "Wait":
		return e.executeWait(def, input)
	case "Succeed":
		return input, "", "", ""
	case "Fail":
		errField, _ := def["Error"].(string)
		cause, _ := def["Cause"].(string)
		return nil, "", errField, cause
	case "Parallel":
		return e.executeParallel(def, input)
	case "Map":
		return e.executeMap(def, input)
	default:
		// Unknown type — treat as pass-through.
		next, _ := def["Next"].(string)
		return input, next, "", ""
	}
}

func isEnd(def map[string]interface{}) bool {
	if end, ok := def["End"].(bool); ok && end {
		return true
	}
	return false
}

// executePass implements the Pass state.
func (e *engine) executePass(def map[string]interface{}, input interface{}) (interface{}, string, string, string) {
	next, _ := def["Next"].(string)

	// Resolve InputPath.
	effective := resolveInputPath(def, input)

	// If Result is set, use it; otherwise pass effective input.
	var result interface{}
	if r, ok := def["Result"]; ok {
		result = r
	} else {
		result = effective
	}

	output := applyResultPath(def, input, result)
	return output, next, "", ""
}

// executeTask implements the Task state. If the Resource is a service integration
// ARN (arn:aws:states:::service:operation) it dispatches to the local fake.
// Otherwise it returns a stub result.
func (e *engine) executeTask(def map[string]interface{}, input interface{}) (interface{}, string, string, string) {
	next, _ := def["Next"].(string)

	effective := resolveInputPath(def, input)

	resource, _ := def["Resource"].(string)
	if isServiceIntegrationARN(resource) {
		// Parameters can override the effective input for the service call.
		callInput := effective
		if params, ok := def["Parameters"]; ok {
			callInput = resolveParameters(params, input)
		}
		taskResult, errCode, errCause := e.executeServiceTask(resource, callInput)
		if errCode != "" {
			// Check Catch.
			if caught, catchNext := e.tryCatch(def, errCode, errCause); caught {
				return input, catchNext, "", ""
			}
			return nil, "", errCode, errCause
		}
		output := applyResultPath(def, input, taskResult)
		return output, next, "", ""
	}

	// Stub: unknown resource — return minimal result.
	taskResult := map[string]interface{}{"status": "ok", "input": effective}
	output := applyResultPath(def, input, taskResult)
	return output, next, "", ""
}

// isServiceIntegrationARN reports whether resource is a service integration ARN.
func isServiceIntegrationARN(resource string) bool {
	return strings.HasPrefix(resource, "arn:aws:states:::")
}

// tryCatch checks whether any Catch clause matches errCode and returns the next state.
func (e *engine) tryCatch(def map[string]interface{}, errCode, errCause string) (bool, string) {
	catchRaw, ok := def["Catch"].([]interface{})
	if !ok {
		return false, ""
	}
	for _, cRaw := range catchRaw {
		c, ok := cRaw.(map[string]interface{})
		if !ok {
			continue
		}
		errorsRaw, _ := c["ErrorEquals"].([]interface{})
		for _, eRaw := range errorsRaw {
			e2, _ := eRaw.(string)
			if e2 == "States.ALL" || e2 == errCode {
				next, _ := c["Next"].(string)
				return true, next
			}
		}
	}
	return false, ""
}

// resolveParameters resolves a Parameters block against the current input.
// Supports "$.key" style references (keys ending with ".$").
func resolveParameters(params interface{}, input interface{}) interface{} {
	switch p := params.(type) {
	case map[string]interface{}:
		result := make(map[string]interface{}, len(p))
		for k, v := range p {
			if strings.HasSuffix(k, ".$") {
				realKey := strings.TrimSuffix(k, ".$")
				if pathStr, ok := v.(string); ok {
					result[realKey] = resolveJSONPath(pathStr, input)
				} else {
					result[realKey] = v
				}
			} else {
				result[k] = resolveParameters(v, input)
			}
		}
		return result
	case []interface{}:
		result := make([]interface{}, len(p))
		for i, v := range p {
			result[i] = resolveParameters(v, input)
		}
		return result
	default:
		return params
	}
}

// executeServiceTask dispatches to the appropriate local fake service.
// Returns (result, errorCode, errorCause).
func (e *engine) executeServiceTask(resource string, input interface{}) (interface{}, string, string) {
	// Strip arn:aws:states::: prefix and optional .waitForTaskToken/.sync:2 suffixes.
	rest := strings.TrimPrefix(resource, "arn:aws:states:::")
	// Remove integration pattern suffixes.
	for _, suffix := range []string{".waitForTaskToken", ".sync:2", ".sync"} {
		rest = strings.TrimSuffix(rest, suffix)
	}

	body, ok := input.(map[string]interface{})
	if !ok {
		body = make(map[string]interface{})
	}

	switch {
	case strings.HasPrefix(rest, "dynamodb:"):
		op := strings.TrimPrefix(rest, "dynamodb:")
		target := dynamoDBTarget(op)
		if target == "" {
			return nil, "States.TaskFailed", "unsupported DynamoDB operation: " + op
		}
		return e.callJSONService(e.servicePorts.DynamoDB, target, body)

	case strings.HasPrefix(rest, "sqs:"):
		op := strings.TrimPrefix(rest, "sqs:")
		target := sqsTarget(op)
		if target == "" {
			return nil, "States.TaskFailed", "unsupported SQS operation: " + op
		}
		return e.callJSONService(e.servicePorts.SQS, target, body)

	case strings.HasPrefix(rest, "sns:"):
		op := strings.TrimPrefix(rest, "sns:")
		action := snsAction(op)
		if action == "" {
			return nil, "States.TaskFailed", "unsupported SNS operation: " + op
		}
		return e.callFormService(e.servicePorts.SNS, action, body)

	case strings.HasPrefix(rest, "s3:"):
		op := strings.TrimPrefix(rest, "s3:")
		return e.callS3Service(op, body)

	case strings.HasPrefix(rest, "secretsmanager:"):
		op := strings.TrimPrefix(rest, "secretsmanager:")
		target := secretsManagerTarget(op)
		if target == "" {
			return nil, "States.TaskFailed", "unsupported SecretsManager operation: " + op
		}
		return e.callJSONService(e.servicePorts.SecretsManager, target, body)

	case strings.HasPrefix(rest, "ssm:"):
		op := strings.TrimPrefix(rest, "ssm:")
		target := ssmTarget(op)
		if target == "" {
			return nil, "States.TaskFailed", "unsupported SSM operation: " + op
		}
		return e.callJSONService(e.servicePorts.SSM, target, body)

	case strings.HasPrefix(rest, "events:"):
		op := strings.TrimPrefix(rest, "events:")
		target := eventBridgeTarget(op)
		if target == "" {
			return nil, "States.TaskFailed", "unsupported EventBridge operation: " + op
		}
		return e.callJSONService(e.servicePorts.EventBridge, target, body)

	default:
		return nil, "States.TaskFailed", "unsupported service integration: " + resource
	}
}

// dynamoDBTarget maps a DynamoDB operation name to its X-Amz-Target value.
func dynamoDBTarget(op string) string {
	ops := map[string]string{
		"putItem":            "DynamoDB_20120810.PutItem",
		"getItem":            "DynamoDB_20120810.GetItem",
		"deleteItem":         "DynamoDB_20120810.DeleteItem",
		"updateItem":         "DynamoDB_20120810.UpdateItem",
		"query":              "DynamoDB_20120810.Query",
		"scan":               "DynamoDB_20120810.Scan",
		"batchGetItem":       "DynamoDB_20120810.BatchGetItem",
		"batchWriteItem":     "DynamoDB_20120810.BatchWriteItem",
		"transactGetItems":   "DynamoDB_20120810.TransactGetItems",
		"transactWriteItems": "DynamoDB_20120810.TransactWriteItems",
	}
	if t, ok := ops[op]; ok {
		return t
	}
	// Try capitalising first letter.
	if t, ok := ops[lcFirst(op)]; ok {
		return t
	}
	return ""
}

// sqsTarget maps an SQS operation name to its X-Amz-Target value.
func sqsTarget(op string) string {
	ops := map[string]string{
		"sendMessage":        "AmazonSQS.SendMessage",
		"receiveMessage":     "AmazonSQS.ReceiveMessage",
		"deleteMessage":      "AmazonSQS.DeleteMessage",
		"getQueueUrl":        "AmazonSQS.GetQueueUrl",
		"createQueue":        "AmazonSQS.CreateQueue",
		"deleteQueue":        "AmazonSQS.DeleteQueue",
		"sendMessageBatch":   "AmazonSQS.SendMessageBatch",
		"deleteMessageBatch": "AmazonSQS.DeleteMessageBatch",
	}
	if t, ok := ops[op]; ok {
		return t
	}
	if t, ok := ops[lcFirst(op)]; ok {
		return t
	}
	return ""
}

// snsAction maps an SNS operation name to its Action query parameter value.
func snsAction(op string) string {
	ops := map[string]string{
		"publish":      "Publish",
		"createTopic":  "CreateTopic",
		"deleteTopic":  "DeleteTopic",
		"subscribe":    "Subscribe",
		"unsubscribe":  "Unsubscribe",
		"publishBatch": "PublishBatch",
	}
	if t, ok := ops[op]; ok {
		return t
	}
	if t, ok := ops[lcFirst(op)]; ok {
		return t
	}
	return ""
}

// secretsManagerTarget maps a SecretsManager operation to its X-Amz-Target value.
func secretsManagerTarget(op string) string {
	ops := map[string]string{
		"getSecretValue": "secretsmanager.GetSecretValue",
		"createSecret":   "secretsmanager.CreateSecret",
		"deleteSecret":   "secretsmanager.DeleteSecret",
		"describeSecret": "secretsmanager.DescribeSecret",
		"listSecrets":    "secretsmanager.ListSecrets",
		"putSecretValue": "secretsmanager.PutSecretValue",
		"rotateSecret":   "secretsmanager.RotateSecret",
		"updateSecret":   "secretsmanager.UpdateSecret",
	}
	if t, ok := ops[op]; ok {
		return t
	}
	if t, ok := ops[lcFirst(op)]; ok {
		return t
	}
	return ""
}

// ssmTarget maps an SSM operation to its X-Amz-Target value.
func ssmTarget(op string) string {
	ops := map[string]string{
		"getParameter":        "AmazonSSM.GetParameter",
		"getParameters":       "AmazonSSM.GetParameters",
		"putParameter":        "AmazonSSM.PutParameter",
		"deleteParameter":     "AmazonSSM.DeleteParameter",
		"getParametersByPath": "AmazonSSM.GetParametersByPath",
	}
	if t, ok := ops[op]; ok {
		return t
	}
	if t, ok := ops[lcFirst(op)]; ok {
		return t
	}
	return ""
}

// eventBridgeTarget maps an EventBridge operation to its X-Amz-Target value.
func eventBridgeTarget(op string) string {
	ops := map[string]string{
		"putEvents": "AmazonEventBridge.PutEvents",
		"putRule":   "AmazonEventBridge.PutRule",
	}
	if t, ok := ops[op]; ok {
		return t
	}
	if t, ok := ops[lcFirst(op)]; ok {
		return t
	}
	return ""
}

// lcFirst lowercases only the first character of s.
func lcFirst(s string) string {
	if s == "" {
		return s
	}
	return strings.ToLower(s[:1]) + s[1:]
}

// callJSONService POSTs a JSON body to a local service port with the given X-Amz-Target header.
func (e *engine) callJSONService(port int, target string, body map[string]interface{}) (interface{}, string, string) {
	if port == 0 {
		return nil, "States.TaskFailed", fmt.Sprintf("service port not configured for target %s", target)
	}
	b, err := json.Marshal(body)
	if err != nil {
		return nil, "States.TaskFailed", err.Error()
	}
	url := fmt.Sprintf("http://127.0.0.1:%d/", port)
	req, err := http.NewRequest("POST", url, bytes.NewReader(b))
	if err != nil {
		return nil, "States.TaskFailed", err.Error()
	}
	req.Header.Set("Content-Type", "application/x-amz-json-1.0")
	req.Header.Set("X-Amz-Target", target)

	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return nil, "States.TaskFailed", err.Error()
	}
	defer resp.Body.Close()
	respBody, _ := io.ReadAll(resp.Body)
	var result interface{}
	json.Unmarshal(respBody, &result)
	if resp.StatusCode >= 400 {
		errCode := "States.TaskFailed"
		errCause := string(respBody)
		if rm, ok := result.(map[string]interface{}); ok {
			if t, ok := rm["__type"].(string); ok {
				errCode = t
			}
			if m, ok := rm["message"].(string); ok {
				errCause = m
			}
		}
		return nil, errCode, errCause
	}
	return result, "", ""
}

// callFormService POSTs a form-encoded body to a local service port (used for SNS).
func (e *engine) callFormService(port int, action string, body map[string]interface{}) (interface{}, string, string) {
	if port == 0 {
		return nil, "States.TaskFailed", fmt.Sprintf("SNS port not configured for action %s", action)
	}
	// Build form body: Action=Publish&TopicArn=...&Message=...
	parts := []string{"Action=" + action}
	for k, v := range body {
		parts = append(parts, urlEncodeSimple(k)+"="+urlEncodeSimple(fmt.Sprintf("%v", v)))
	}
	formBody := strings.Join(parts, "&")

	url := fmt.Sprintf("http://127.0.0.1:%d/", port)
	req, err := http.NewRequest("POST", url, strings.NewReader(formBody))
	if err != nil {
		return nil, "States.TaskFailed", err.Error()
	}
	req.Header.Set("Content-Type", "application/x-www-form-urlencoded")

	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return nil, "States.TaskFailed", err.Error()
	}
	defer resp.Body.Close()
	respBody, _ := io.ReadAll(resp.Body)
	if resp.StatusCode >= 400 {
		return nil, "States.TaskFailed", string(respBody)
	}
	// SNS returns XML; return it as a raw string result.
	return map[string]interface{}{"Response": string(respBody)}, "", ""
}

// callS3Service performs a REST call to the local S3 fake.
// For putObject: PUT /{Bucket}/{Key} with body.
// For getObject: GET /{Bucket}/{Key}.
func (e *engine) callS3Service(operation string, body map[string]interface{}) (interface{}, string, string) {
	if e.servicePorts.S3 == 0 {
		return nil, "States.TaskFailed", "S3 port not configured"
	}

	bucket, _ := body["Bucket"].(string)
	key, _ := body["Key"].(string)
	if bucket == "" || key == "" {
		return nil, "States.TaskFailed", "S3 operation requires Bucket and Key"
	}

	urlStr := fmt.Sprintf("http://127.0.0.1:%d/%s/%s", e.servicePorts.S3, bucket, key)

	switch strings.ToLower(operation) {
	case "putobject":
		bodyBytes := []byte{}
		if b, ok := body["Body"].(string); ok {
			bodyBytes = []byte(b)
		}
		req, err := http.NewRequest("PUT", urlStr, bytes.NewReader(bodyBytes))
		if err != nil {
			return nil, "States.TaskFailed", err.Error()
		}
		if ct, ok := body["ContentType"].(string); ok {
			req.Header.Set("Content-Type", ct)
		}
		resp, err := http.DefaultClient.Do(req)
		if err != nil {
			return nil, "States.TaskFailed", err.Error()
		}
		defer resp.Body.Close()
		respBody, _ := io.ReadAll(resp.Body)
		if resp.StatusCode >= 400 {
			return nil, "States.TaskFailed", string(respBody)
		}
		etag := resp.Header.Get("ETag")
		return map[string]interface{}{"ETag": etag}, "", ""

	case "getobject":
		req, err := http.NewRequest("GET", urlStr, nil)
		if err != nil {
			return nil, "States.TaskFailed", err.Error()
		}
		resp, err := http.DefaultClient.Do(req)
		if err != nil {
			return nil, "States.TaskFailed", err.Error()
		}
		defer resp.Body.Close()
		respBody, _ := io.ReadAll(resp.Body)
		if resp.StatusCode >= 400 {
			return nil, "States.TaskFailed", string(respBody)
		}
		return map[string]interface{}{
			"Body":        string(respBody),
			"ContentType": resp.Header.Get("Content-Type"),
		}, "", ""

	default:
		return nil, "States.TaskFailed", "unsupported S3 operation: " + operation
	}
}

// urlEncodeSimple percent-encodes a string for use in form bodies.
func urlEncodeSimple(s string) string {
	var buf strings.Builder
	for i := 0; i < len(s); i++ {
		c := s[i]
		if (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || (c >= '0' && c <= '9') ||
			c == '-' || c == '_' || c == '.' || c == '~' {
			buf.WriteByte(c)
		} else {
			fmt.Fprintf(&buf, "%%%02X", c)
		}
	}
	return buf.String()
}

// executeChoice implements the Choice state.
func (e *engine) executeChoice(def map[string]interface{}, input interface{}) (interface{}, string, string, string) {
	choices, _ := def["Choices"].([]interface{})
	defaultState, _ := def["Default"].(string)

	for _, choiceRaw := range choices {
		choice, _ := choiceRaw.(map[string]interface{})
		if evaluateCondition(choice, input) {
			next, _ := choice["Next"].(string)
			return input, next, "", ""
		}
	}
	if defaultState != "" {
		return input, defaultState, "", ""
	}
	return nil, "", "States.NoChoiceMatched", "No choice rule matched and no Default transition"
}

// executeWait implements the Wait state — skips the delay in test mode.
func (e *engine) executeWait(def map[string]interface{}, input interface{}) (interface{}, string, string, string) {
	next, _ := def["Next"].(string)
	return input, next, "", ""
}

// executeParallel runs all branches sequentially and collects outputs as an array.
func (e *engine) executeParallel(def map[string]interface{}, input interface{}) (interface{}, string, string, string) {
	next, _ := def["Next"].(string)
	branches, _ := def["Branches"].([]interface{})

	var results []interface{}
	for _, branchRaw := range branches {
		branch, _ := branchRaw.(map[string]interface{})
		statesRaw, _ := branch["States"].(map[string]interface{})
		startAt, _ := branch["StartAt"].(string)
		out, errCode, errCause := e.runStates(statesRaw, startAt, input)
		if errCode != "" {
			return nil, "", errCode, errCause
		}
		results = append(results, out)
	}

	output := applyResultPath(def, input, results)
	return output, next, "", ""
}

// executeMap iterates over an input array and runs the Iterator on each item.
func (e *engine) executeMap(def map[string]interface{}, input interface{}) (interface{}, string, string, string) {
	next, _ := def["Next"].(string)

	// Resolve ItemsPath.
	itemsPath, _ := def["ItemsPath"].(string)
	if itemsPath == "" {
		itemsPath = "$"
	}
	items := resolveJSONPath(itemsPath, input)
	itemsArr, ok := items.([]interface{})
	if !ok {
		itemsArr = []interface{}{}
	}

	iteratorRaw, _ := def["Iterator"].(map[string]interface{})
	iterStates, _ := iteratorRaw["States"].(map[string]interface{})
	iterStartAt, _ := iteratorRaw["StartAt"].(string)

	var results []interface{}
	for _, item := range itemsArr {
		out, errCode, errCause := e.runStates(iterStates, iterStartAt, item)
		if errCode != "" {
			return nil, "", errCode, errCause
		}
		results = append(results, out)
	}

	output := applyResultPath(def, input, results)
	return output, next, "", ""
}

// ============================================================
// JSONPath helpers
// ============================================================

// resolveJSONPath resolves a simple JSONPath expression against data.
// Supports: "$" (identity), "$.field", "$.a.b.c" (nested).
func resolveJSONPath(path string, data interface{}) interface{} {
	if path == "$" || path == "" {
		return data
	}
	if !strings.HasPrefix(path, "$.") {
		return data
	}
	parts := strings.Split(strings.TrimPrefix(path, "$."), ".")
	current := data
	for _, part := range parts {
		m, ok := current.(map[string]interface{})
		if !ok {
			return nil
		}
		current = m[part]
	}
	return current
}

// setJSONPath injects value at path into a copy of data.
// For ResultPath: "$.field" style.  Returns the modified copy.
func setJSONPath(path string, data interface{}, value interface{}) interface{} {
	if path == "$" {
		return value
	}
	if !strings.HasPrefix(path, "$.") {
		return data
	}
	// Deep-copy data as a map.
	dataMap := deepCopyMap(data)
	parts := strings.Split(strings.TrimPrefix(path, "$."), ".")
	setNestedKey(dataMap, parts, value)
	return dataMap
}

func setNestedKey(m map[string]interface{}, parts []string, value interface{}) {
	if len(parts) == 1 {
		m[parts[0]] = value
		return
	}
	child, ok := m[parts[0]].(map[string]interface{})
	if !ok {
		child = make(map[string]interface{})
	}
	setNestedKey(child, parts[1:], value)
	m[parts[0]] = child
}

func deepCopyMap(v interface{}) map[string]interface{} {
	if v == nil {
		return make(map[string]interface{})
	}
	b, _ := json.Marshal(v)
	var result map[string]interface{}
	json.Unmarshal(b, &result)
	if result == nil {
		result = make(map[string]interface{})
	}
	return result
}

func resolveInputPath(def map[string]interface{}, input interface{}) interface{} {
	if ip, ok := def["InputPath"].(string); ok {
		return resolveJSONPath(ip, input)
	}
	return input
}

func applyResultPath(def map[string]interface{}, originalInput interface{}, result interface{}) interface{} {
	rp, hasResultPath := def["ResultPath"]
	if !hasResultPath {
		// Default: replace input with result.
		return applyOutputPath(def, result)
	}
	if rp == nil {
		// ResultPath: null — discard result, output = original input.
		return applyOutputPath(def, originalInput)
	}
	rpStr, _ := rp.(string)
	merged := setJSONPath(rpStr, originalInput, result)
	return applyOutputPath(def, merged)
}

func applyOutputPath(def map[string]interface{}, data interface{}) interface{} {
	if op, ok := def["OutputPath"].(string); ok {
		return resolveJSONPath(op, data)
	}
	return data
}

func marshalJSON(v interface{}) string {
	b, _ := json.Marshal(v)
	return string(b)
}

// ============================================================
// Choice rule evaluator
// ============================================================

func evaluateCondition(rule map[string]interface{}, input interface{}) bool {
	// Logical combinators.
	if andRules, ok := rule["And"].([]interface{}); ok {
		for _, r := range andRules {
			if rm, ok := r.(map[string]interface{}); ok {
				if !evaluateCondition(rm, input) {
					return false
				}
			}
		}
		return true
	}
	if orRules, ok := rule["Or"].([]interface{}); ok {
		for _, r := range orRules {
			if rm, ok := r.(map[string]interface{}); ok {
				if evaluateCondition(rm, input) {
					return true
				}
			}
		}
		return false
	}
	if notRule, ok := rule["Not"].(map[string]interface{}); ok {
		return !evaluateCondition(notRule, input)
	}

	variable, _ := rule["Variable"].(string)
	val := resolveJSONPath(variable, input)

	if expected, ok := rule["StringEquals"]; ok {
		return fmt.Sprintf("%v", val) == fmt.Sprintf("%v", expected)
	}
	if pattern, ok := rule["StringMatches"].(string); ok {
		return stringMatches(fmt.Sprintf("%v", val), pattern)
	}
	if expected, ok := rule["NumericEquals"]; ok {
		return toFloat(val) == toFloat(expected)
	}
	if expected, ok := rule["NumericLessThan"]; ok {
		return toFloat(val) < toFloat(expected)
	}
	if expected, ok := rule["NumericGreaterThan"]; ok {
		return toFloat(val) > toFloat(expected)
	}
	if expected, ok := rule["BooleanEquals"]; ok {
		valBool, _ := val.(bool)
		expBool, _ := expected.(bool)
		return valBool == expBool
	}
	return false
}

// stringMatches supports simple glob: * matches any sequence of characters.
func stringMatches(s, pattern string) bool {
	if pattern == "*" {
		return true
	}
	parts := strings.Split(pattern, "*")
	if len(parts) == 1 {
		return s == pattern
	}
	if !strings.HasPrefix(s, parts[0]) {
		return false
	}
	remaining := s[len(parts[0]):]
	for _, part := range parts[1:] {
		idx := strings.Index(remaining, part)
		if idx == -1 {
			return false
		}
		remaining = remaining[idx+len(part):]
	}
	return true
}

func toFloat(v interface{}) float64 {
	switch n := v.(type) {
	case float64:
		return n
	case float32:
		return float64(n)
	case int:
		return float64(n)
	case int64:
		return float64(n)
	case json.Number:
		f, _ := n.Float64()
		return f
	}
	return math.NaN()
}

// ============================================================
// HTTP handler dispatch
// ============================================================

func (h *Handler) handle(w http.ResponseWriter, operation string, body map[string]interface{}) {
	switch operation {

	case "CreateStateMachine":
		name := getString(body, "name")
		definition := getString(body, "definition")
		roleArn := getString(body, "roleArn")
		smType := getString(body, "type")
		if smType == "" {
			smType = "STANDARD"
		}
		arn := smARN(name)
		sm := &StateMachine{
			Arn:        arn,
			Name:       name,
			Definition: definition,
			RoleArn:    roleArn,
			Type:       smType,
			Status:     "ACTIVE",
			CreatedAt:  time.Now(),
		}
		h.store.mu.Lock()
		if _, exists := h.store.stateMachines[arn]; exists {
			h.store.mu.Unlock()
			writeErr(w, "StateMachineAlreadyExists", "State machine already exists: "+arn, 400)
			return
		}
		h.store.stateMachines[arn] = sm
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"stateMachineArn": arn, "creationDate": sm.CreatedAt.Unix()})

	case "DeleteStateMachine":
		arn := getString(body, "stateMachineArn")
		h.store.mu.Lock()
		delete(h.store.stateMachines, arn)
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{})

	case "DescribeStateMachine":
		arn := getString(body, "stateMachineArn")
		h.store.mu.RLock()
		sm, ok := h.store.stateMachines[arn]
		h.store.mu.RUnlock()
		if !ok {
			writeErr(w, "StateMachineDoesNotExist", "State machine not found: "+arn, 400)
			return
		}
		writeOK(w, smDesc(sm))

	case "ListStateMachines":
		h.store.mu.RLock()
		var sms []map[string]interface{}
		for _, sm := range h.store.stateMachines {
			sms = append(sms, map[string]interface{}{
				"stateMachineArn": sm.Arn,
				"name":            sm.Name,
				"type":            sm.Type,
				"creationDate":    sm.CreatedAt.Unix(),
			})
		}
		h.store.mu.RUnlock()
		if sms == nil {
			sms = []map[string]interface{}{}
		}
		writeOK(w, map[string]interface{}{"stateMachines": sms})

	case "UpdateStateMachine":
		arn := getString(body, "stateMachineArn")
		h.store.mu.Lock()
		if sm, ok := h.store.stateMachines[arn]; ok {
			if def := getString(body, "definition"); def != "" {
				sm.Definition = def
			}
			if role := getString(body, "roleArn"); role != "" {
				sm.RoleArn = role
			}
		}
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"updateDate": time.Now().Unix()})

	case "ValidateStateMachineDefinition":
		writeOK(w, map[string]interface{}{"result": "OK", "diagnostics": []interface{}{}})

	case "ListStateMachineVersions":
		writeOK(w, map[string]interface{}{"stateMachineVersions": []interface{}{}})

	case "StartExecution":
		smArn := getString(body, "stateMachineArn")
		input := getString(body, "input")
		if input == "" {
			input = "{}"
		}

		if h.state.GetCapacityRule("stepfunctions").IsExhausted() {
			writeErr(w, "ServiceUnavailableException", "No execution slot is available", 503)
			return
		}

		h.store.mu.RLock()
		sm, smExists := h.store.stateMachines[smArn]
		h.store.mu.RUnlock()
		if !smExists {
			writeErr(w, "StateMachineDoesNotExist", "State machine not found: "+smArn, 400)
			return
		}
		if sm.Type != "STANDARD" {
			writeErr(w, "StateMachineTypeNotSupported", "StartExecution is only supported for STANDARD state machines. Use StartSyncExecution for EXPRESS state machines.", 400)
			return
		}

		h.store.mu.Lock()
		h.store.execCounter++
		execName := fmt.Sprintf("exec-%d", h.store.execCounter)
		smName := smNameFromARN(smArn)
		execArn := execARN(smName, execName)
		exec := &Execution{
			Arn:             execArn,
			StateMachineArn: smArn,
			Name:            execName,
			Status:          "RUNNING",
			Input:           input,
			StartDate:       time.Now(),
		}
		h.store.executions[execArn] = exec
		h.store.mu.Unlock()

		// Run the state machine engine.
		eng, err := newEngine(sm.Definition, h.servicePorts)
		if err == nil {
			outputJSON, status, _, _ := eng.run(input)
			now := time.Now()
			h.store.mu.Lock()
			exec.Output = outputJSON
			exec.Status = status
			exec.StopDate = &now
			exec.History = eng.history
			h.store.mu.Unlock()
		} else {
			now := time.Now()
			h.store.mu.Lock()
			exec.Status = "FAILED"
			exec.StopDate = &now
			h.store.mu.Unlock()
		}

		writeOK(w, map[string]interface{}{
			"executionArn": execArn,
			"startDate":    exec.StartDate.Unix(),
		})

	case "StartSyncExecution":
		smArn := getString(body, "stateMachineArn")
		input := getString(body, "input")
		if input == "" {
			input = "{}"
		}

		h.store.mu.RLock()
		sm, smExists := h.store.stateMachines[smArn]
		h.store.mu.RUnlock()
		if !smExists {
			writeErr(w, "StateMachineDoesNotExist", "State machine not found: "+smArn, 400)
			return
		}
		if sm.Type != "EXPRESS" {
			writeErr(w, "StateMachineTypeNotSupported", "StartSyncExecution is only supported for EXPRESS state machines. Use StartExecution for STANDARD state machines.", 400)
			return
		}

		h.store.mu.Lock()
		h.store.execCounter++
		execName := fmt.Sprintf("sync-exec-%d", h.store.execCounter)
		smName := smNameFromARN(smArn)
		execArn := execARN(smName, execName)
		h.store.mu.Unlock()

		startTime := time.Now()
		outputJSON := input
		status := "SUCCEEDED"

		eng, err := newEngine(sm.Definition, h.servicePorts)
		if err == nil {
			out, stat, _, _ := eng.run(input)
			outputJSON = out
			status = stat
		}

		now := time.Now()
		exec := &Execution{
			Arn:             execArn,
			StateMachineArn: smArn,
			Name:            execName,
			Status:          status,
			Input:           input,
			Output:          outputJSON,
			StartDate:       startTime,
			StopDate:        &now,
		}
		if eng != nil {
			exec.History = eng.history
		}
		h.store.mu.Lock()
		h.store.executions[execArn] = exec
		h.store.mu.Unlock()

		writeOK(w, map[string]interface{}{
			"executionArn": execArn,
			"startDate":    startTime.Unix(),
			"stopDate":     now.Unix(),
			"status":       status,
			"input":        input,
			"output":       outputJSON,
		})

	case "StopExecution":
		execArn := getString(body, "executionArn")
		h.store.mu.Lock()
		exec, ok := h.store.executions[execArn]
		if !ok {
			h.store.mu.Unlock()
			writeErr(w, "ExecutionDoesNotExist", "Execution not found: "+execArn, 400)
			return
		}
		exec.Status = "ABORTED"
		now := time.Now()
		exec.StopDate = &now
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"stopDate": time.Now().Unix()})

	case "DescribeExecution":
		execArn := getString(body, "executionArn")
		h.store.mu.RLock()
		exec, ok := h.store.executions[execArn]
		h.store.mu.RUnlock()
		if !ok {
			writeErr(w, "ExecutionDoesNotExist", "Execution not found: "+execArn, 400)
			return
		}
		result := map[string]interface{}{
			"executionArn":    exec.Arn,
			"stateMachineArn": exec.StateMachineArn,
			"name":            exec.Name,
			"status":          exec.Status,
			"startDate":       exec.StartDate.Unix(),
			"input":           exec.Input,
		}
		if exec.Output != "" {
			result["output"] = exec.Output
		}
		if exec.StopDate != nil {
			result["stopDate"] = exec.StopDate.Unix()
		}
		writeOK(w, result)

	case "ListExecutions":
		smArn := getString(body, "stateMachineArn")
		statusFilter := getString(body, "statusFilter")
		h.store.mu.RLock()
		var execs []map[string]interface{}
		for _, exec := range h.store.executions {
			if exec.StateMachineArn != smArn {
				continue
			}
			if statusFilter != "" && exec.Status != statusFilter {
				continue
			}
			entry := map[string]interface{}{
				"executionArn":    exec.Arn,
				"stateMachineArn": exec.StateMachineArn,
				"name":            exec.Name,
				"status":          exec.Status,
				"startDate":       exec.StartDate.Unix(),
			}
			if exec.StopDate != nil {
				entry["stopDate"] = exec.StopDate.Unix()
			}
			execs = append(execs, entry)
		}
		h.store.mu.RUnlock()
		if execs == nil {
			execs = []map[string]interface{}{}
		}
		writeOK(w, map[string]interface{}{"executions": execs})

	case "GetExecutionHistory":
		execArn := getString(body, "executionArn")
		h.store.mu.RLock()
		exec, ok := h.store.executions[execArn]
		h.store.mu.RUnlock()

		if !ok {
			writeErr(w, "ExecutionDoesNotExist", "Execution not found: "+execArn, 400)
			return
		}

		var events []map[string]interface{}
		for _, ev := range exec.History {
			entry := map[string]interface{}{
				"id":        ev.ID,
				"type":      ev.Type,
				"timestamp": ev.Timestamp.Unix(),
			}
			for k, v := range ev.Details {
				entry[k] = v
			}
			events = append(events, entry)
		}
		if len(events) == 0 {
			// Synthesize a minimal started event if history is empty.
			events = []map[string]interface{}{
				{
					"id":        1,
					"type":      "ExecutionStarted",
					"timestamp": exec.StartDate.Unix(),
					"executionStartedEventDetails": map[string]string{
						"input": exec.Input,
					},
				},
			}
		}
		writeOK(w, map[string]interface{}{"events": events})

	case "ListTagsForResource":
		resourceArn := getString(body, "resourceArn")
		h.store.mu.RLock()
		sm, ok := h.store.stateMachines[resourceArn]
		h.store.mu.RUnlock()
		if !ok {
			writeErr(w, "StateMachineDoesNotExist", "State machine not found: "+resourceArn, 400)
			return
		}
		var tags []map[string]string
		h.store.mu.RLock()
		tags = append([]map[string]string{}, sm.Tags...)
		h.store.mu.RUnlock()
		if tags == nil {
			tags = []map[string]string{}
		}
		writeOK(w, map[string]interface{}{"tags": tags})

	case "TagResource":
		resourceArn := getString(body, "resourceArn")
		h.store.mu.Lock()
		sm, ok := h.store.stateMachines[resourceArn]
		if !ok {
			h.store.mu.Unlock()
			writeErr(w, "StateMachineDoesNotExist", "State machine not found: "+resourceArn, 400)
			return
		}
		// Tags can be an array of {key, value} objects
		if tagsRaw, ok := body["tags"].([]interface{}); ok {
			for _, tagRaw := range tagsRaw {
				if tagMap, ok := tagRaw.(map[string]interface{}); ok {
					key := getString(tagMap, "key")
					value := getString(tagMap, "value")
					if key != "" {
						// Check if key exists, update or add
						found := false
						for i, t := range sm.Tags {
							if t["key"] == key {
								sm.Tags[i]["value"] = value
								found = true
								break
							}
						}
						if !found {
							sm.Tags = append(sm.Tags, map[string]string{"key": key, "value": value})
						}
					}
				}
			}
		}
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{})

	case "UntagResource":
		resourceArn := getString(body, "resourceArn")
		h.store.mu.Lock()
		sm, ok := h.store.stateMachines[resourceArn]
		if !ok {
			h.store.mu.Unlock()
			writeErr(w, "StateMachineDoesNotExist", "State machine not found: "+resourceArn, 400)
			return
		}
		tagKeys := []string{}
		if keysRaw, ok := body["tagKeys"].([]interface{}); ok {
			for _, k := range keysRaw {
				if s, ok := k.(string); ok {
					tagKeys = append(tagKeys, s)
				}
			}
		}
		// Check that all requested tag keys exist.
		existingTagKeys := make(map[string]bool)
		for _, t := range sm.Tags {
			if k, ok := t["key"]; ok {
				existingTagKeys[k] = true
			}
		}
		for _, k := range tagKeys {
			if !existingTagKeys[k] {
				h.store.mu.Unlock()
				writeErr(w, "InvalidParameterValue", "Tag not found: "+k, 400)
				return
			}
		}
		newTags := sm.Tags[:0]
		for _, t := range sm.Tags {
			remove := false
			for _, k := range tagKeys {
				if t["key"] == k {
					remove = true
					break
				}
			}
			if !remove {
				newTags = append(newTags, t)
			}
		}
		sm.Tags = newTags
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{})

	default:
		writeErr(w, "ValidationException", "Unknown operation: "+operation, 400)
	}
}

func smNameFromARN(arn string) string {
	parts := strings.Split(arn, ":")
	if len(parts) > 0 {
		return parts[len(parts)-1]
	}
	return arn
}
