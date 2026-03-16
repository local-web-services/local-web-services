package lws

import (
	"encoding/json"
	"net/http"
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
