package eventbridge

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

type Rule struct {
	Name               string
	EventBusName       string
	State              string
	ScheduleExpression string
	EventPattern       string
	Targets            []map[string]interface{}
}

type EventBus struct {
	Name string
	Arn  string
	Tags []map[string]string
}

// DeliveryRecord records an event delivery to a target (for test verification).
type DeliveryRecord struct {
	TargetArn   string
	TargetId    string
	RuleName    string
	EventBusName string
	Event        map[string]interface{}
	DeliveredAt  time.Time
}

type Store struct {
	mu           sync.RWMutex
	eventBuses   map[string]*EventBus
	rules        map[string]*Rule // key: busName/ruleName
	deliveries   []DeliveryRecord
}

func NewStore() *Store {
	s := &Store{
		eventBuses: make(map[string]*EventBus),
		rules:      make(map[string]*Rule),
	}
	// Create default bus
	s.eventBuses["default"] = &EventBus{Name: "default", Arn: fmt.Sprintf("arn:aws:events:%s:%s:event-bus/default", region, accountID)}
	return s
}

func (s *Store) Reset() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.eventBuses = make(map[string]*EventBus)
	s.eventBuses["default"] = &EventBus{Name: "default", Arn: fmt.Sprintf("arn:aws:events:%s:%s:event-bus/default", region, accountID)}
	s.rules = make(map[string]*Rule)
	s.deliveries = nil
}

func busARN(name string) string {
	return fmt.Sprintf("arn:aws:events:%s:%s:event-bus/%s", region, accountID, name)
}

func ruleARN(busName, ruleName string) string {
	return fmt.Sprintf("arn:aws:events:%s:%s:rule/%s/%s", region, accountID, busName, ruleName)
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
	target := r.Header.Get("X-Amz-Target")
	operation := ""
	if strings.HasPrefix(target, "AmazonEventBridge.") {
		operation = strings.TrimPrefix(target, "AmazonEventBridge.")
	} else {
		parts := strings.SplitN(target, ".", 2)
		if len(parts) == 2 {
			operation = parts[1]
		}
	}

	if state.ApplyIAMAuth(h.state, "events", operation, r, w, false) {
		return
	}
	if state.ApplyChaos(h.state, "events", operation, w, false, false) {
		return
	}

	var body map[string]interface{}
	json.NewDecoder(r.Body).Decode(&body) //nolint:errcheck
	if body == nil {
		body = make(map[string]interface{})
	}

	h.handle(w, operation, body)
}

func writeOK(w http.ResponseWriter, data interface{}) {
	w.Header().Set("Content-Type", "application/x-amz-json-1.1")
	w.WriteHeader(200)
	json.NewEncoder(w).Encode(data) //nolint:errcheck
}

func writeErr(w http.ResponseWriter, code, msg string) {
	w.Header().Set("Content-Type", "application/x-amz-json-1.1")
	w.WriteHeader(400)
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

// matchesPattern checks if an event matches an EventBridge rule event pattern.
// Pattern format: {"source": ["com.example"], "detail-type": ["OrderCreated"], ...}
func matchesPattern(pattern string, event map[string]interface{}) bool {
	if pattern == "" {
		return true
	}
	var patternMap map[string]interface{}
	if err := json.Unmarshal([]byte(pattern), &patternMap); err != nil {
		return false
	}

	// Check "source" field
	if sources, ok := patternMap["source"]; ok {
		eventSource := getString(event, "Source")
		if eventSource == "" {
			eventSource = getString(event, "source")
		}
		if !matchesStringList(sources, eventSource) {
			return false
		}
	}

	// Check "detail-type" field
	if detailTypes, ok := patternMap["detail-type"]; ok {
		eventDT := getString(event, "DetailType")
		if eventDT == "" {
			eventDT = getString(event, "detail-type")
		}
		if !matchesStringList(detailTypes, eventDT) {
			return false
		}
	}

	// Check "resources" field
	if _, ok := patternMap["resources"]; ok {
		// Simplified: just pass if present
	}

	return true
}

func matchesStringList(patternVal interface{}, value string) bool {
	switch v := patternVal.(type) {
	case []interface{}:
		for _, item := range v {
			if s, ok := item.(string); ok && s == value {
				return true
			}
		}
		return false
	case string:
		return v == value
	}
	return false
}

// recordDelivery logs an event delivery to a target.
func (h *Handler) recordDelivery(ruleName, busName string, target map[string]interface{}, event map[string]interface{}) {
	targetArn := getString(target, "Arn")
	targetId := getString(target, "Id")
	record := DeliveryRecord{
		TargetArn:    targetArn,
		TargetId:     targetId,
		RuleName:     ruleName,
		EventBusName: busName,
		Event:        event,
		DeliveredAt:  time.Now(),
	}
	h.store.mu.Lock()
	h.store.deliveries = append(h.store.deliveries, record)
	h.store.mu.Unlock()
}

// processEventForRules matches an event against rules and records deliveries.
func (h *Handler) processEventForRules(event map[string]interface{}) {
	busName := getString(event, "EventBusName")
	if busName == "" {
		busName = "default"
	}
	// Also check for bare bus name in event
	if busName == "" {
		busName = "default"
	}

	h.store.mu.RLock()
	var matchingRules []*Rule
	for key, rule := range h.store.rules {
		if strings.HasPrefix(key, busName+"/") && rule.State == "ENABLED" {
			if matchesPattern(rule.EventPattern, event) {
				matchingRules = append(matchingRules, rule)
			}
		}
	}
	h.store.mu.RUnlock()

	for _, rule := range matchingRules {
		for _, target := range rule.Targets {
			h.recordDelivery(rule.Name, busName, target, event)
		}
	}
}

func (h *Handler) handle(w http.ResponseWriter, operation string, body map[string]interface{}) {
	switch operation {
	case "PutEvents":
		entries, _ := body["Entries"].([]interface{})
		var results []map[string]interface{}
		for _, entryRaw := range entries {
			entry, _ := entryRaw.(map[string]interface{})
			if entry == nil {
				entry = make(map[string]interface{})
			}
			// Check that the referenced event bus exists
			busName := getString(entry, "EventBusName")
			if busName == "" {
				busName = "default"
			}
			h.store.mu.RLock()
			_, busExists := h.store.eventBuses[busName]
			// Check that at least one enabled rule with at least one target exists for the bus.
			hasEnabledRuleWithTarget := false
			for key, rule := range h.store.rules {
				if strings.HasPrefix(key, busName+"/") && rule.State == "ENABLED" && len(rule.Targets) > 0 {
					hasEnabledRuleWithTarget = true
					break
				}
			}
			h.store.mu.RUnlock()
			if !busExists {
				writeErr(w, "ResourceNotFoundException", "Event bus not found: "+busName)
				return
			}
			if !hasEnabledRuleWithTarget {
				writeErr(w, "ResourceNotFoundException", "No enabled rule with targets found for event bus: "+busName)
				return
			}
			results = append(results, map[string]interface{}{
				"EventId": fmt.Sprintf("event-%d", time.Now().UnixNano()),
			})
			// Process event against rules for target delivery
			h.processEventForRules(entry)
		}
		if results == nil {
			results = []map[string]interface{}{}
		}
		writeOK(w, map[string]interface{}{"FailedEntryCount": 0, "Entries": results})

	case "CreateEventBus":
		name := getString(body, "Name")
		arn := busARN(name)
		h.store.mu.Lock()
		if _, exists := h.store.eventBuses[name]; exists {
			h.store.mu.Unlock()
			writeErr(w, "ResourceAlreadyExistsException", "Event bus already exists: "+name)
			return
		}
		h.store.eventBuses[name] = &EventBus{Name: name, Arn: arn}
		h.store.mu.Unlock()
		writeOK(w, map[string]string{"EventBusArn": arn})

	case "DeleteEventBus":
		name := getString(body, "Name")
		if name == "default" {
			writeErr(w, "OperationDisabledException", "Cannot delete the default event bus")
			return
		}
		h.store.mu.Lock()
		if _, exists := h.store.eventBuses[name]; !exists {
			h.store.mu.Unlock()
			writeErr(w, "ResourceNotFoundException", "Event bus not found: "+name)
			return
		}
		delete(h.store.eventBuses, name)
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{})

	case "ListEventBuses":
		h.store.mu.RLock()
		var buses []map[string]string
		for _, b := range h.store.eventBuses {
			buses = append(buses, map[string]string{"Name": b.Name, "Arn": b.Arn})
		}
		h.store.mu.RUnlock()
		if buses == nil {
			buses = []map[string]string{}
		}
		writeOK(w, map[string]interface{}{"EventBuses": buses})

	case "DescribeEventBus":
		name := getString(body, "Name")
		if name == "" {
			name = "default"
		}
		h.store.mu.RLock()
		b, ok := h.store.eventBuses[name]
		h.store.mu.RUnlock()
		if !ok {
			writeErr(w, "ResourceNotFoundException", "Event bus not found: "+name)
			return
		}
		writeOK(w, map[string]string{"Name": b.Name, "Arn": b.Arn})

	case "PutRule":
		name := getString(body, "Name")
		busName := getString(body, "EventBusName")
		if busName == "" {
			busName = "default"
		}
		ruleState := getString(body, "State")
		if ruleState == "" {
			ruleState = "ENABLED"
		}
		key := busName + "/" + name
		h.store.mu.Lock()
		// Check bus exists
		if _, busExists := h.store.eventBuses[busName]; !busExists {
			h.store.mu.Unlock()
			writeErr(w, "ResourceNotFoundException", "Event bus not found: "+busName)
			return
		}
		// Check if rule already exists
		if _, exists := h.store.rules[key]; exists {
			h.store.mu.Unlock()
			writeErr(w, "ResourceAlreadyExistsException", "Rule already exists: "+name)
			return
		}
		h.store.rules[key] = &Rule{
			Name:               name,
			EventBusName:       busName,
			State:              ruleState,
			ScheduleExpression: getString(body, "ScheduleExpression"),
			EventPattern:       getString(body, "EventPattern"),
		}
		h.store.mu.Unlock()
		writeOK(w, map[string]string{"RuleArn": ruleARN(busName, name)})

	case "DeleteRule":
		name := getString(body, "Name")
		busName := getString(body, "EventBusName")
		if busName == "" {
			busName = "default"
		}
		h.store.mu.Lock()
		key := busName + "/" + name
		rule, exists := h.store.rules[key]
		if !exists {
			h.store.mu.Unlock()
			writeErr(w, "ResourceNotFoundException", "Rule not found: "+name)
			return
		}
		// Cannot delete a rule that has targets
		if len(rule.Targets) > 0 {
			h.store.mu.Unlock()
			writeErr(w, "ValidationException", "Rule has targets; remove targets before deleting rule")
			return
		}
		delete(h.store.rules, key)
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{})

	case "DescribeRule":
		name := getString(body, "Name")
		busName := getString(body, "EventBusName")
		if busName == "" {
			busName = "default"
		}
		h.store.mu.RLock()
		rule, ok := h.store.rules[busName+"/"+name]
		h.store.mu.RUnlock()
		if !ok {
			writeErr(w, "ResourceNotFoundException", "Rule not found: "+name)
			return
		}
		writeOK(w, map[string]string{
			"Name":               rule.Name,
			"EventBusName":       rule.EventBusName,
			"State":              rule.State,
			"Arn":                ruleARN(rule.EventBusName, rule.Name),
			"ScheduleExpression": rule.ScheduleExpression,
		})

	case "ListRules":
		busName := getString(body, "EventBusName")
		if busName == "" {
			busName = "default"
		}
		h.store.mu.RLock()
		_, busExists := h.store.eventBuses[busName]
		var rules []map[string]string
		if busExists {
			for key, rule := range h.store.rules {
				if strings.HasPrefix(key, busName+"/") {
					rules = append(rules, map[string]string{
						"Name":         rule.Name,
						"Arn":          ruleARN(rule.EventBusName, rule.Name),
						"State":        rule.State,
						"EventBusName": rule.EventBusName,
					})
				}
			}
		}
		h.store.mu.RUnlock()
		if !busExists {
			writeErr(w, "ResourceNotFoundException", "Event bus not found: "+busName)
			return
		}
		if rules == nil {
			rules = []map[string]string{}
		}
		writeOK(w, map[string]interface{}{"Rules": rules})

	case "PutTargets":
		rule := getString(body, "Rule")
		busName := getString(body, "EventBusName")
		if busName == "" {
			busName = "default"
		}
		targets, _ := body["Targets"].([]interface{})
		h.store.mu.Lock()
		key := busName + "/" + rule
		r, ruleExists := h.store.rules[key]
		if !ruleExists {
			h.store.mu.Unlock()
			writeErr(w, "ResourceNotFoundException", "Rule not found: "+rule)
			return
		}
		for _, t := range targets {
			if tm, ok := t.(map[string]interface{}); ok {
				r.Targets = append(r.Targets, tm)
			}
		}
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"FailedEntryCount": 0, "FailedEntries": []interface{}{}})

	case "RemoveTargets":
		rule := getString(body, "Rule")
		busName := getString(body, "EventBusName")
		if busName == "" {
			busName = "default"
		}
		ids, _ := body["Ids"].([]interface{})
		h.store.mu.Lock()
		key := busName + "/" + rule
		r, ruleExists := h.store.rules[key]
		if !ruleExists {
			h.store.mu.Unlock()
			writeErr(w, "ResourceNotFoundException", "Rule not found: "+rule)
			return
		}
		if r != nil && len(ids) > 0 {
			// Check that all requested target IDs exist in the rule.
			// Targets may use "Id" or "id" keys depending on SDK serialization.
			existingIDs := make(map[string]bool)
			for _, t := range r.Targets {
				if id, ok := t["Id"].(string); ok {
					existingIDs[id] = true
				}
				if id, ok := t["id"].(string); ok {
					existingIDs[id] = true
				}
			}
			for _, id := range ids {
				if s, ok := id.(string); ok {
					if !existingIDs[s] {
						h.store.mu.Unlock()
						writeErr(w, "ResourceNotFoundException", "Target not found: "+s)
						return
					}
				}
			}
			idsToRemove := make(map[string]bool)
			for _, id := range ids {
				if s, ok := id.(string); ok {
					idsToRemove[s] = true
				}
			}
			var remaining []map[string]interface{}
			for _, t := range r.Targets {
				tID := ""
				if id, ok := t["Id"].(string); ok {
					tID = id
				} else if id, ok := t["id"].(string); ok {
					tID = id
				}
				if tID == "" || !idsToRemove[tID] {
					remaining = append(remaining, t)
				}
			}
			r.Targets = remaining
		}
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{"FailedEntryCount": 0, "FailedEntries": []interface{}{}})

	case "ListTargetsByRule":
		rule := getString(body, "Rule")
		busName := getString(body, "EventBusName")
		if busName == "" {
			busName = "default"
		}
		h.store.mu.RLock()
		r, ruleExists := h.store.rules[busName+"/"+rule]
		h.store.mu.RUnlock()
		if !ruleExists {
			writeErr(w, "ResourceNotFoundException", "Rule not found: "+rule)
			return
		}
		targets := r.Targets
		if targets == nil {
			targets = []map[string]interface{}{}
		}
		writeOK(w, map[string]interface{}{"Targets": targets})

	case "EnableRule":
		name := getString(body, "Name")
		busName := getString(body, "EventBusName")
		if busName == "" {
			busName = "default"
		}
		h.store.mu.Lock()
		r, ok := h.store.rules[busName+"/"+name]
		if !ok {
			h.store.mu.Unlock()
			writeErr(w, "ResourceNotFoundException", "Rule not found: "+name)
			return
		}
		if r.State == "ENABLED" {
			h.store.mu.Unlock()
			writeErr(w, "ValidationException", "Rule is already enabled: "+name)
			return
		}
		r.State = "ENABLED"
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{})

	case "DisableRule":
		name := getString(body, "Name")
		busName := getString(body, "EventBusName")
		if busName == "" {
			busName = "default"
		}
		h.store.mu.Lock()
		r, ok := h.store.rules[busName+"/"+name]
		if !ok {
			h.store.mu.Unlock()
			writeErr(w, "ResourceNotFoundException", "Rule not found: "+name)
			return
		}
		if r.State == "DISABLED" {
			h.store.mu.Unlock()
			writeErr(w, "ValidationException", "Rule is already disabled: "+name)
			return
		}
		r.State = "DISABLED"
		h.store.mu.Unlock()
		writeOK(w, map[string]interface{}{})

	case "ListTagsForResource":
		writeOK(w, map[string]interface{}{"Tags": []interface{}{}})

	case "TagResource":
		writeOK(w, map[string]interface{}{})

	case "UntagResource":
		writeOK(w, map[string]interface{}{})

	// Management endpoint: list recorded deliveries for test verification
	case "ListDeliveries":
		h.store.mu.RLock()
		deliveries := make([]map[string]interface{}, 0, len(h.store.deliveries))
		for _, d := range h.store.deliveries {
			deliveries = append(deliveries, map[string]interface{}{
				"TargetArn":    d.TargetArn,
				"TargetId":     d.TargetId,
				"RuleName":     d.RuleName,
				"EventBusName": d.EventBusName,
				"Event":        d.Event,
				"DeliveredAt":  d.DeliveredAt.Format(time.RFC3339),
			})
		}
		h.store.mu.RUnlock()
		writeOK(w, map[string]interface{}{"Deliveries": deliveries})

	default:
		writeErr(w, "ValidationException", "Unknown operation: "+operation)
	}
}
