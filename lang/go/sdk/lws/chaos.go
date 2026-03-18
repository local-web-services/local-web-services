package lws

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
)

type chaosPayload struct {
	Enabled             bool    `json:"enabled"`
	ErrorRate           float64 `json:"error_rate,omitempty"`
	LatencyMinMs        int     `json:"latency_min_ms,omitempty"`
	LatencyMaxMs        int     `json:"latency_max_ms,omitempty"`
	ConnectionResetRate float64 `json:"connection_reset_rate,omitempty"`
	TimeoutRate         float64 `json:"timeout_rate,omitempty"`
}

// ChaosBuilder configures chaos engineering settings for a single service.
// Obtain one via Session.Chaos("service-name").
type ChaosBuilder struct {
	session *Session
	service string
	cfg     chaosPayload
}

// ErrorRate sets the probability (0.0–1.0) that requests return an error.
func (b *ChaosBuilder) ErrorRate(r float64) *ChaosBuilder {
	b.cfg.ErrorRate = r
	return b
}

// Latency configures artificial latency range applied to requests.
func (b *ChaosBuilder) Latency(minMs, maxMs int) *ChaosBuilder {
	b.cfg.LatencyMinMs = minMs
	b.cfg.LatencyMaxMs = maxMs
	return b
}

// ConnectionResetRate sets the probability (0.0–1.0) that connections are reset.
func (b *ChaosBuilder) ConnectionResetRate(r float64) *ChaosBuilder {
	b.cfg.ConnectionResetRate = r
	return b
}

// TimeoutRate sets the probability (0.0–1.0) that requests time out.
func (b *ChaosBuilder) TimeoutRate(r float64) *ChaosBuilder {
	b.cfg.TimeoutRate = r
	return b
}

// Apply sends the chaos configuration to the management API with enabled:true.
func (b *ChaosBuilder) Apply() error {
	b.cfg.Enabled = true
	return b.post()
}

// Clear disables chaos for this service and resets all rates to zero.
func (b *ChaosBuilder) Clear() error {
	b.cfg = chaosPayload{Enabled: false}
	return b.post()
}

func (b *ChaosBuilder) post() error {
	payload := map[string]any{b.service: b.cfg}
	data, err := json.Marshal(payload)
	if err != nil {
		return fmt.Errorf("chaos: marshal payload: %w", err)
	}
	url := fmt.Sprintf("http://127.0.0.1:%d/_ldk/chaos", b.session.basePort)
	resp, err := http.Post(url, "application/json", bytes.NewReader(data)) //nolint:noctx
	if err != nil {
		return fmt.Errorf("chaos: post to management API: %w", err)
	}
	resp.Body.Close()
	return nil
}
