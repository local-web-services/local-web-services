package lws

import (
	"encoding/json"
	"net/http"
	"strings"
	"time"

	"github.com/gorilla/websocket"
	lwsstate "github.com/local-web-services/local-web-services-go-core/lws/state"
)

var wsUpgrader = websocket.Upgrader{
	CheckOrigin: func(r *http.Request) bool { return true },
}

// RegisterManagementAPI registers the management HTTP endpoints on the given mux.
func RegisterManagementAPI(mux *http.ServeMux, state *ServerState, shutdownCh chan struct{}) {
	// GET /_ldk/status
	mux.HandleFunc("/_ldk/status", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodGet {
			http.NotFound(w, r)
			return
		}
		writeJSON(w, map[string]interface{}{"running": true, "providers": []string{}}, 200)
	})

	// POST /_ldk/reset
	mux.HandleFunc("/_ldk/reset", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodPost {
			http.NotFound(w, r)
			return
		}
		state.Reset()
		state.ResetCapacity()
		writeJSON(w, map[string]string{"status": "ok"}, 200)
	})

	// GET /_ldk/logs
	mux.HandleFunc("/_ldk/logs", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodGet {
			http.NotFound(w, r)
			return
		}
		logs := state.GetLogs()
		if logs == nil {
			logs = []LogEntry{}
		}
		writeJSON(w, map[string]interface{}{"logs": logs}, 200)
	})

	// GET /_ldk/ws/logs — WebSocket streaming log endpoint.
	// Sends existing log entries then polls for new ones every 50ms.
	mux.HandleFunc("/_ldk/ws/logs", func(w http.ResponseWriter, r *http.Request) {
		conn, err := wsUpgrader.Upgrade(w, r, nil)
		if err != nil {
			return
		}
		defer conn.Close() //nolint:errcheck

		sent := 0
		for {
			entries := state.GetLogs()
			for i := sent; i < len(entries); i++ {
				data, err := json.Marshal(wsLogEntry(entries[i]))
				if err != nil {
					continue
				}
				if err := conn.WriteMessage(websocket.TextMessage, data); err != nil {
					return
				}
			}
			sent = len(entries)
			time.Sleep(50 * time.Millisecond)
		}
	})

	// GET /_ldk/chaos and POST /_ldk/chaos
	mux.HandleFunc("/_ldk/chaos", func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			status := state.GetAllChaosStatus()
			writeJSON(w, status, 200)
		case http.MethodPost:
			var body map[string]map[string]interface{}
			if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
				writeJSONError(w, "ValidationException", "invalid JSON", 400)
				return
			}
			for service, config := range body {
				enabled, hasEnabled := config["enabled"]
				if hasEnabled {
					if b, ok := enabled.(bool); ok && !b {
						state.DisableChaos(service)
						continue
					}
				}

				nonEnabledKeys := 0
				for k := range config {
					if k != "enabled" {
						nonEnabledKeys++
					}
				}
				if nonEnabledKeys == 0 {
					state.EnableChaos(service)
					continue
				}

				rule := &ChaosRule{}
				if v, ok := config["error_rate"]; ok {
					rule.ErrorRate = toFloat64(v)
				}
				if v, ok := config["latency_min_ms"]; ok {
					rule.LatencyMinMs = int(toFloat64(v))
				}
				if v, ok := config["latency_max_ms"]; ok {
					rule.LatencyMaxMs = int(toFloat64(v))
				}
				if v, ok := config["error_code"]; ok {
					if s, ok := v.(string); ok {
						rule.ErrorCode = s
					}
				}
				state.EnableChaos(service)
				state.SetChaosRule(service, "*", rule)
			}
			writeJSON(w, map[string]string{"status": "ok"}, 200)
		default:
			http.NotFound(w, r)
		}
	})

	// GET /_ldk/lifecycle and POST /_ldk/lifecycle
	mux.HandleFunc("/_ldk/lifecycle", func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			// Return current lifecycle rules (not yet implemented for GET)
			writeJSON(w, map[string]interface{}{}, 200)
		case http.MethodPost:
			var body map[string]map[string]interface{}
			if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
				writeJSONError(w, "ValidationException", "invalid JSON", 400)
				return
			}
			for svc, config := range body {
				rule := LifecycleRule{}
				if v, ok := config["enabled"].(bool); ok {
					rule.Enabled = v
				} else {
					rule.Enabled = true
				}
				if v, ok := config["create_dwell_ms"].(float64); ok {
					rule.CreateDwellMs = int(v)
				}
				if v, ok := config["delete_dwell_ms"].(float64); ok {
					rule.DeleteDwellMs = int(v)
				}
				state.SetLifecycleRule(svc, rule)
			}
			writeJSON(w, map[string]string{"status": "ok"}, 200)
		default:
			http.NotFound(w, r)
		}
	})

	// GET /_ldk/capacity and POST /_ldk/capacity
	mux.HandleFunc("/_ldk/capacity", func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			status := state.GetAllCapacityStatus()
			result := make(map[string]map[string]interface{})
			for svc, rule := range status {
				result[svc] = map[string]interface{}{"slots": rule.Slots}
			}
			writeJSON(w, result, 200)
		case http.MethodPost:
			var body map[string]struct {
				Slots *int `json:"slots"`
			}
			if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
				writeJSONError(w, "ValidationException", "invalid JSON", 400)
				return
			}
			for svc, cfg := range body {
				state.SetCapacityRule(svc, CapacityRule{Slots: cfg.Slots})
			}
			writeJSON(w, map[string]string{"status": "ok"}, 200)
		default:
			http.NotFound(w, r)
		}
	})

	// GET /_ldk/iam-auth and POST /_ldk/iam-auth
	mux.HandleFunc("/_ldk/iam-auth", func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			cfg := state.GetIamConfig()
			mode := "disabled"
			if cfg.Enforce {
				mode = "enforce"
			}
			identitiesOut := make(map[string]interface{})
			for name, identity := range cfg.Identities {
				identitiesOut[name] = identity
			}
			writeJSON(w, map[string]interface{}{
				"mode":              mode,
				"default_identity":  cfg.DefaultIdentity,
				"identities":        identitiesOut,
				"resource_policies": cfg.ResourcePolicies,
			}, 200)
		case http.MethodPost:
			var body map[string]interface{}
			if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
				writeJSONError(w, "ValidationException", "invalid JSON", 400)
				return
			}
			cfg := state.GetIamConfig()

			if mode, ok := body["mode"].(string); ok {
				cfg.Enforce = mode == "enforce"
			}
			if v, ok := body["enforce"].(bool); ok {
				cfg.Enforce = v
			}
			if v, ok := body["default_identity"].(string); ok {
				cfg.DefaultIdentity = v
			}
			if identities, ok := body["identities"].(map[string]interface{}); ok {
				for name, identRaw := range identities {
					identMap, ok := identRaw.(map[string]interface{})
					if !ok {
						continue
					}
					identity := IamIdentity{}
					if policies, ok := identMap["inline_policies"].([]interface{}); ok {
						for _, pRaw := range policies {
							p := parseIamPolicy(pRaw)
							identity.InlinePolicies = append(identity.InlinePolicies, p)
						}
					}
					if bp, ok := identMap["boundary_policy"]; ok && bp != nil {
						p := parseIamPolicy(bp)
						identity.PermissionBoundary = &p
					}
					if bp, ok := identMap["permission_boundary"]; ok && bp != nil {
						p := parseIamPolicy(bp)
						identity.PermissionBoundary = &p
					}
					cfg.Identities[name] = identity
				}
			}
			state.SetIamConfig(cfg)
			writeJSON(w, map[string]string{"status": "ok"}, 200)
		default:
			http.NotFound(w, r)
		}
	})

	// POST /_ldk/shutdown
	mux.HandleFunc("/_ldk/shutdown", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodPost {
			http.NotFound(w, r)
			return
		}
		writeJSON(w, map[string]string{"status": "shutting down"}, 200)
		if shutdownCh != nil {
			go func() { shutdownCh <- struct{}{} }()
		}
	})

	// GET /_ldk/resources
	mux.HandleFunc("/_ldk/resources", func(w http.ResponseWriter, r *http.Request) {
		writeJSON(w, map[string]interface{}{"resources": map[string]interface{}{}}, 200)
	})

	// Per-service chaos: PUT/GET/DELETE /_ldk/chaos/{service}
	mux.HandleFunc("/_ldk/chaos/", func(w http.ResponseWriter, r *http.Request) {
		service := strings.TrimPrefix(r.URL.Path, "/_ldk/chaos/")
		if service == "" {
			http.NotFound(w, r)
			return
		}
		switch r.Method {
		case http.MethodPut:
			var body struct {
				ErrorRate float64 `json:"error_rate"`
				LatencyMs int     `json:"latency_ms"`
			}
			if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
				writeJSONError(w, "ValidationException", "invalid JSON", 400)
				return
			}
			rule := &ChaosRule{
				ErrorRate:    body.ErrorRate,
				LatencyMinMs: body.LatencyMs,
				LatencyMaxMs: body.LatencyMs,
			}
			state.SetChaosRule(service, "*", rule)
			writeJSON(w, map[string]string{"status": "ok"}, 200)
		case http.MethodGet:
			svcRules := state.GetAllChaosStatus()
			if info, ok := svcRules[service]; ok {
				writeJSON(w, info, 200)
			} else {
				writeJSON(w, map[string]interface{}{
					"enabled":        false,
					"error_rate":     0,
					"latency_min_ms": 0,
					"latency_max_ms": 0,
				}, 200)
			}
		case http.MethodDelete:
			state.DisableChaos(service)
			writeJSON(w, map[string]string{"status": "ok"}, 200)
		default:
			http.NotFound(w, r)
		}
	})

	// Per-service capacity: PUT/GET/DELETE /_ldk/capacity/{service}
	mux.HandleFunc("/_ldk/capacity/", func(w http.ResponseWriter, r *http.Request) {
		service := strings.TrimPrefix(r.URL.Path, "/_ldk/capacity/")
		if service == "" {
			http.NotFound(w, r)
			return
		}
		switch r.Method {
		case http.MethodPut:
			var body struct {
				Slots *int `json:"slots"`
			}
			if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
				writeJSONError(w, "ValidationException", "invalid JSON", 400)
				return
			}
			state.SetCapacityRule(service, CapacityRule{Slots: body.Slots})
			writeJSON(w, map[string]string{"status": "ok"}, 200)
		case http.MethodGet:
			rule := state.GetCapacityRule(service)
			writeJSON(w, map[string]interface{}{"slots": rule.Slots}, 200)
		case http.MethodDelete:
			state.SetCapacityRule(service, CapacityRule{})
			writeJSON(w, map[string]string{"status": "ok"}, 200)
		default:
			http.NotFound(w, r)
		}
	})

	// Fake server instances: POST/GET /_ldk/fake and GET /_ldk/fake/{name}
	mux.HandleFunc("/_ldk/fake", func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodPost:
			var body struct {
				Name     string `json:"name"`
				Endpoint string `json:"endpoint"`
			}
			if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
				writeJSONError(w, "ValidationException", "invalid JSON", 400)
				return
			}
			state.RegisterFakeServer(body.Name, body.Endpoint)
			writeJSON(w, map[string]string{"status": "ok"}, 200)
		case http.MethodGet:
			servers := state.ListFakeServers()
			writeJSON(w, servers, 200)
		default:
			http.NotFound(w, r)
		}
	})

	mux.HandleFunc("/_ldk/fake/", func(w http.ResponseWriter, r *http.Request) {
		name := strings.TrimPrefix(r.URL.Path, "/_ldk/fake/")
		if name == "" {
			http.NotFound(w, r)
			return
		}
		if r.Method != http.MethodGet {
			http.NotFound(w, r)
			return
		}
		endpoint, ok := state.GetFakeServer(name)
		if !ok {
			http.NotFound(w, r)
			return
		}
		writeJSON(w, map[string]string{"name": name, "endpoint": endpoint}, 200)
	})

	// State injection: PUT/GET/DELETE /_ldk/state/{service}/{resourceType}/{resourceId}
	mux.HandleFunc("/_ldk/state/", func(w http.ResponseWriter, r *http.Request) {
		parts := strings.SplitN(strings.TrimPrefix(r.URL.Path, "/_ldk/state/"), "/", 3)
		if len(parts) != 3 {
			writeJSONError(w, "ValidationException", "path must be /_ldk/state/{service}/{resourceType}/{resourceId}", 400)
			return
		}
		service, resourceType, resourceID := parts[0], parts[1], parts[2]
		switch r.Method {
		case http.MethodPut:
			var body struct {
				State string `json:"state"`
			}
			if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
				writeJSONError(w, "ValidationException", "invalid JSON", 400)
				return
			}
			state.SetInjectedState(service, resourceType, resourceID, body.State)
			writeJSON(w, map[string]string{"status": "ok"}, 200)
		case http.MethodGet:
			val, ok := state.GetInjectedState(service, resourceType, resourceID)
			if !ok {
				http.NotFound(w, r)
				return
			}
			writeJSON(w, map[string]string{"state": val}, 200)
		case http.MethodDelete:
			state.ClearInjectedState(service, resourceType, resourceID)
			writeJSON(w, map[string]string{"status": "ok"}, 200)
		default:
			http.NotFound(w, r)
		}
	})

	// POST /_ldk/aws-fake — configure fake responses for AWS service operations.
	// Body: { "stepfunctions": { "enabled": true, "rules": [...] } }
	mux.HandleFunc("/_ldk/aws-fake", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodPost {
			http.NotFound(w, r)
			return
		}
		var body map[string]map[string]interface{}
		if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
			writeJSONError(w, "ValidationException", "invalid JSON", 400)
			return
		}
		for service, config := range body {
			enabled, _ := config["enabled"].(bool)
			if !enabled {
				state.ClearFakeRules(service)
				continue
			}
			rulesRaw, ok := config["rules"].([]interface{})
			if !ok {
				state.ClearFakeRules(service)
				continue
			}
			var rules []lwsstate.FakeRule
			for _, rRaw := range rulesRaw {
				rMap, ok := rRaw.(map[string]interface{})
				if !ok {
					continue
				}
				operation, _ := rMap["operation"].(string)
				respRaw, _ := rMap["response"].(map[string]interface{})
				var resp lwsstate.FakeResponse
				if respRaw != nil {
					if v, ok := respRaw["status"].(float64); ok {
						resp.Status = int(v)
					}
					if v, ok := respRaw["content_type"].(string); ok {
						resp.ContentType = v
					}
					if v, ok := respRaw["body"].(string); ok {
						resp.Body = v
					}
					if v, ok := respRaw["delay_ms"].(float64); ok {
						resp.DelayMs = int(v)
					}
				}
				rules = append(rules, lwsstate.FakeRule{
					Operation: operation,
					Response:  resp,
				})
			}
			state.SetFakeRules(service, rules)
		}
		writeJSON(w, map[string]string{"status": "ok"}, 200)
	})
}

// wsLogEntry converts a state.LogEntry to the format the SDK's LogCapture expects.
// The SDK's LogEntry uses "handler" for the operation field.
func wsLogEntry(e LogEntry) map[string]interface{} {
	return map[string]interface{}{
		"service":     e.Service,
		"handler":     e.Operation,
		"level":       "info",
		"status_code": e.Status,
		"duration_ms": float64(e.DurationMs),
		"timestamp":   e.Timestamp,
	}
}

func toFloat64(v interface{}) float64 {
	switch t := v.(type) {
	case float64:
		return t
	case float32:
		return float64(t)
	case int:
		return float64(t)
	case int64:
		return float64(t)
	}
	return 0
}

func parseIamPolicy(raw interface{}) IamPolicy {
	policy := IamPolicy{}
	pMap, ok := raw.(map[string]interface{})
	if !ok {
		return policy
	}
	stmtsRaw, ok := pMap["Statement"].([]interface{})
	if !ok {
		return policy
	}
	for _, stmtRaw := range stmtsRaw {
		stmtMap, ok := stmtRaw.(map[string]interface{})
		if !ok {
			continue
		}
		stmt := IamStatement{}
		if v, ok := stmtMap["Effect"].(string); ok {
			stmt.Effect = v
		}
		stmt.Action = stmtMap["Action"]
		stmt.Resource = stmtMap["Resource"]
		policy.Statement = append(policy.Statement, stmt)
	}
	return policy
}
