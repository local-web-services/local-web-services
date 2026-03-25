// Package state holds the shared ServerState used by lws and all providers.
package state

import (
	"strings"
	"sync"
	"time"
)

// ChaosRule holds chaos injection configuration for a service/operation.
type ChaosRule struct {
	ErrorRate       float64
	LatencyMinMs    int
	LatencyMaxMs    int
	ErrorCode       string
	ConnectionReset bool
	Timeout         bool
}

// CapacityRule holds the slot configuration for a service.
type CapacityRule struct {
	Slots *int `json:"slots"` // nil = unlimited; 0 = exhausted
}

// IsExhausted returns true when slots is set to zero.
func (r CapacityRule) IsExhausted() bool {
	return r.Slots != nil && *r.Slots == 0
}

// IamStatement is a single IAM policy statement.
type IamStatement struct {
	Effect   string      // "Allow" or "Deny"
	Action   interface{} // string or []string
	Resource interface{} // string or []string
}

// IamPolicy is a list of IAM statements.
type IamPolicy struct {
	Statement []IamStatement
}

// IamIdentity holds policies for an identity.
type IamIdentity struct {
	InlinePolicies     []IamPolicy
	PermissionBoundary *IamPolicy
}

// IamConfig holds the current IAM configuration.
type IamConfig struct {
	Enforce          bool
	DefaultIdentity  string
	Identities       map[string]IamIdentity
	ResourcePolicies map[string]IamPolicy
}

// LogEntry represents a single log record.
type LogEntry struct {
	Timestamp  string `json:"timestamp"`
	Service    string `json:"service"`
	Operation  string `json:"operation"`
	Method     string `json:"method"`
	Path       string `json:"path"`
	Status     int    `json:"status"`
	DurationMs int64  `json:"duration_ms"`
	RequestID  string `json:"request_id"`
}

// FakeResponse holds a configured fake HTTP response.
type FakeResponse struct {
	Status      int
	ContentType string
	Body        string
	DelayMs     int
}

// FakeRule maps an operation to a fake response.
type FakeRule struct {
	Operation string
	Response  FakeResponse
}

// LifecycleRule holds lifecycle simulation configuration for a service.
// When create_dwell_ms > 0, newly created resources start in CREATING state
// and become ACTIVE after the specified duration.
type LifecycleRule struct {
	Enabled       bool `json:"enabled"`
	CreateDwellMs int  `json:"create_dwell_ms"`
	DeleteDwellMs int  `json:"delete_dwell_ms"`
}

// ServerState holds all mutable server state.
type ServerState struct {
	mu sync.RWMutex

	// chaosRules: service -> operation -> ChaosRule
	chaosRules map[string]map[string]*ChaosRule

	// iamConfig
	iamConfig IamConfig

	// logBuffer (circular, max 500)
	logBuffer []LogEntry

	// fakeRules: service -> []FakeRule
	fakeRules map[string][]FakeRule

	// capacityRules: service -> CapacityRule
	capacityRules map[string]CapacityRule

	// lifecycleRules: service -> LifecycleRule
	lifecycleRules map[string]LifecycleRule

	// resourceCreatedAt: "service/resourceID" -> creation time
	resourceCreatedAt map[string]time.Time

	// resetCallbacks called on POST /_ldk/reset
	resetCallbacks []func()
}

// NewServerState creates a new ServerState with all maps initialized.
func NewServerState() *ServerState {
	return &ServerState{
		chaosRules:        make(map[string]map[string]*ChaosRule),
		fakeRules:         make(map[string][]FakeRule),
		capacityRules:     make(map[string]CapacityRule),
		lifecycleRules:    make(map[string]LifecycleRule),
		resourceCreatedAt: make(map[string]time.Time),
		iamConfig: IamConfig{
			Identities:       make(map[string]IamIdentity),
			ResourcePolicies: make(map[string]IamPolicy),
		},
	}
}

// AddResetCallback registers a function to be called on Reset.
func (s *ServerState) AddResetCallback(cb func()) {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.resetCallbacks = append(s.resetCallbacks, cb)
}

// Reset clears all mutable state and calls all reset callbacks.
func (s *ServerState) Reset() {
	s.mu.Lock()
	s.chaosRules = make(map[string]map[string]*ChaosRule)
	s.fakeRules = make(map[string][]FakeRule)
	s.capacityRules = make(map[string]CapacityRule)
	s.lifecycleRules = make(map[string]LifecycleRule)
	s.resourceCreatedAt = make(map[string]time.Time)
	s.iamConfig = IamConfig{
		Identities:       make(map[string]IamIdentity),
		ResourcePolicies: make(map[string]IamPolicy),
	}
	s.logBuffer = nil
	callbacks := s.resetCallbacks
	s.mu.Unlock()

	for _, cb := range callbacks {
		cb()
	}
}

// GetChaosRule returns the chaos rule for a service+operation (falls back to wildcard).
func (s *ServerState) GetChaosRule(service, operation string) *ChaosRule {
	s.mu.RLock()
	defer s.mu.RUnlock()
	svcRules, ok := s.chaosRules[service]
	if !ok {
		return nil
	}
	if r, ok := svcRules[operation]; ok {
		return r
	}
	return svcRules["*"]
}

// HasChaosRules returns true when chaos is enabled for a service.
func (s *ServerState) HasChaosRules(service string) bool {
	s.mu.RLock()
	defer s.mu.RUnlock()
	_, ok := s.chaosRules[service]
	return ok
}

// SetChaosRule sets or clears a chaos rule for a service+operation.
func (s *ServerState) SetChaosRule(service, operation string, rule *ChaosRule) {
	s.mu.Lock()
	defer s.mu.Unlock()
	if _, ok := s.chaosRules[service]; !ok {
		s.chaosRules[service] = make(map[string]*ChaosRule)
	}
	if rule == nil {
		delete(s.chaosRules[service], operation)
	} else {
		s.chaosRules[service][operation] = rule
	}
}

// EnableChaos marks chaos as enabled for a service (without setting any specific rule).
func (s *ServerState) EnableChaos(service string) {
	s.mu.Lock()
	defer s.mu.Unlock()
	if _, ok := s.chaosRules[service]; !ok {
		s.chaosRules[service] = make(map[string]*ChaosRule)
	}
}

// DisableChaos removes all chaos rules for a service.
func (s *ServerState) DisableChaos(service string) {
	s.mu.Lock()
	defer s.mu.Unlock()
	delete(s.chaosRules, service)
}

// GetAllChaosStatus returns the chaos status for all known services.
func (s *ServerState) GetAllChaosStatus() map[string]map[string]interface{} {
	s.mu.RLock()
	defer s.mu.RUnlock()
	services := []string{"dynamodb", "sqs", "s3", "sns", "stepfunctions", "events", "ssm", "secretsmanager", "cognito-idp"}
	result := make(map[string]map[string]interface{})
	for _, svc := range services {
		rules, ok := s.chaosRules[svc]
		enabled := ok
		var errRate float64
		var latMin, latMax int
		if ok {
			if r, found := rules["*"]; found {
				errRate = r.ErrorRate
				latMin = r.LatencyMinMs
				latMax = r.LatencyMaxMs
			}
		}
		result[svc] = map[string]interface{}{
			"enabled":        enabled,
			"error_rate":     errRate,
			"latency_min_ms": latMin,
			"latency_max_ms": latMax,
		}
	}
	return result
}

// GetIamConfig returns a copy of the current IAM configuration.
func (s *ServerState) GetIamConfig() IamConfig {
	s.mu.RLock()
	defer s.mu.RUnlock()
	return s.iamConfig
}

// SetIamConfig replaces the current IAM configuration.
func (s *ServerState) SetIamConfig(cfg IamConfig) {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.iamConfig = cfg
}

// AppendLog adds a log entry to the circular buffer (max 500).
func (s *ServerState) AppendLog(entry LogEntry) {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.logBuffer = append(s.logBuffer, entry)
	if len(s.logBuffer) > 500 {
		s.logBuffer = s.logBuffer[len(s.logBuffer)-500:]
	}
}

// GetLogs returns a copy of all log entries.
func (s *ServerState) GetLogs() []LogEntry {
	s.mu.RLock()
	defer s.mu.RUnlock()
	result := make([]LogEntry, len(s.logBuffer))
	copy(result, s.logBuffer)
	return result
}

// GetFakeRule returns the first fake rule matching service+operation, or nil.
// Matches both CamelCase (e.g. "StartExecution") and kebab-case (e.g. "start-execution").
func (s *ServerState) GetFakeRule(service, operation string) *FakeResponse {
	s.mu.RLock()
	defer s.mu.RUnlock()
	rules, ok := s.fakeRules[service]
	if !ok {
		return nil
	}
	opKebab := toKebab(operation)
	for i := range rules {
		ruleOp := rules[i].Operation
		if strings.EqualFold(ruleOp, operation) || strings.EqualFold(ruleOp, opKebab) {
			resp := rules[i].Response
			return &resp
		}
	}
	return nil
}

// SetFakeRules replaces all fake rules for a service.
func (s *ServerState) SetFakeRules(service string, rules []FakeRule) {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.fakeRules[service] = rules
}

// ClearFakeRules removes all fake rules for a service.
func (s *ServerState) ClearFakeRules(service string) {
	s.mu.Lock()
	defer s.mu.Unlock()
	delete(s.fakeRules, service)
}

// GetLifecycleRule returns the LifecycleRule for a service.
func (s *ServerState) GetLifecycleRule(service string) LifecycleRule {
	s.mu.RLock()
	defer s.mu.RUnlock()
	return s.lifecycleRules[service]
}

// SetLifecycleRule sets the LifecycleRule for a service.
func (s *ServerState) SetLifecycleRule(service string, rule LifecycleRule) {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.lifecycleRules[service] = rule
}

// GetCapacityRule returns the CapacityRule for a service (default: unlimited).
func (s *ServerState) GetCapacityRule(service string) CapacityRule {
	s.mu.RLock()
	defer s.mu.RUnlock()
	return s.capacityRules[service]
}

// SetCapacityRule sets the CapacityRule for a service.
func (s *ServerState) SetCapacityRule(service string, rule CapacityRule) {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.capacityRules[service] = rule
}

// ResetCapacity clears all capacity rules back to unlimited.
func (s *ServerState) ResetCapacity() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.capacityRules = make(map[string]CapacityRule)
}

// GetAllCapacityStatus returns a copy of all current capacity rules.
func (s *ServerState) GetAllCapacityStatus() map[string]CapacityRule {
	s.mu.RLock()
	defer s.mu.RUnlock()
	result := make(map[string]CapacityRule, len(s.capacityRules))
	for k, v := range s.capacityRules {
		result[k] = v
	}
	return result
}

// TrackResourceCreation records the creation time for a resource under a service.
// The key is "service/resourceID".
func (s *ServerState) TrackResourceCreation(service, resourceID string) {
	s.mu.Lock()
	defer s.mu.Unlock()
	key := service + "/" + resourceID
	s.resourceCreatedAt[key] = time.Now()
}

// IsResourceInDwell returns true when a resource was recently created and the
// lifecycle create_dwell_ms window has not yet elapsed.
func (s *ServerState) IsResourceInDwell(service, resourceID string) bool {
	s.mu.RLock()
	defer s.mu.RUnlock()
	rule := s.lifecycleRules[service]
	if !rule.Enabled || rule.CreateDwellMs <= 0 {
		return false
	}
	key := service + "/" + resourceID
	createdAt, ok := s.resourceCreatedAt[key]
	if !ok {
		return false
	}
	elapsed := time.Since(createdAt).Milliseconds()
	return elapsed < int64(rule.CreateDwellMs)
}

// toKebab converts CamelCase to kebab-case for operation matching.
func toKebab(s string) string {
	var result []byte
	for i, c := range s {
		if c >= 'A' && c <= 'Z' && i > 0 {
			result = append(result, '-')
		}
		result = append(result, byte(strings.ToLower(string(c))[0]))
	}
	return string(result)
}
