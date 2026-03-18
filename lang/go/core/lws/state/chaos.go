package state

import (
	"math/rand"
	"net/http"
	"time"
)

// ApplyChaos checks chaos rules and applies them. Returns true if response was sent.
func ApplyChaos(s *ServerState, service, operation string, w http.ResponseWriter, isXML bool, isS3 bool) bool {
	rule := s.GetChaosRule(service, operation)
	if rule == nil && s.HasChaosRules(service) {
		return false
	}
	if rule == nil {
		return false
	}

	// Latency-only mode
	if rule.ErrorRate <= 0 && (rule.LatencyMinMs > 0 || rule.LatencyMaxMs > 0) {
		latency := applyLatency(rule)
		if latency > 0 {
			time.Sleep(time.Duration(latency) * time.Millisecond)
		}
		return false
	}

	// Error rate check
	if rule.ErrorRate > 0 {
		if rand.Float64() > rule.ErrorRate {
			if rule.LatencyMinMs > 0 || rule.LatencyMaxMs > 0 {
				latency := applyLatency(rule)
				if latency > 0 {
					time.Sleep(time.Duration(latency) * time.Millisecond)
				}
			}
			return false
		}
	}

	// Apply latency before error
	if rule.LatencyMinMs > 0 || rule.LatencyMaxMs > 0 {
		latency := applyLatency(rule)
		if latency > 0 {
			time.Sleep(time.Duration(latency) * time.Millisecond)
		}
	}

	errorCode := rule.ErrorCode
	if errorCode == "" {
		errorCode = "ServiceUnavailable"
	}

	if isS3 {
		w.Header().Set("Content-Type", "application/xml")
		w.WriteHeader(500)
		w.Write([]byte(`<?xml version="1.0" encoding="UTF-8"?><Error><Code>` + errorCode + `</Code><Message>chaos</Message></Error>`))
	} else if isXML {
		w.Header().Set("Content-Type", "application/xml")
		w.WriteHeader(500)
		w.Write([]byte(`<?xml version="1.0" encoding="UTF-8"?><ErrorResponse><Error><Code>` + errorCode + `</Code><Message>chaos</Message></Error></ErrorResponse>`))
	} else {
		WriteJSONError(w, errorCode, "chaos", 500)
	}
	return true
}

func applyLatency(rule *ChaosRule) int {
	if rule.LatencyMinMs <= 0 && rule.LatencyMaxMs <= 0 {
		return 0
	}
	min := rule.LatencyMinMs
	max := rule.LatencyMaxMs
	if max <= min {
		return min
	}
	return min + rand.Intn(max-min+1)
}
