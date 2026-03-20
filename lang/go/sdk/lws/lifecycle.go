package lws

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
)

// LifecycleBuilder configures resource lifecycle simulation for a single AWS service.
// Obtain one via Session.Lifecycle("service-name").
type LifecycleBuilder struct {
	session *Session
	service string
	config  map[string]any
}

// Lifecycle returns a LifecycleBuilder for the given service (e.g. "dynamodb").
func (s *Session) Lifecycle(service string) *LifecycleBuilder {
	return &LifecycleBuilder{
		session: s,
		service: service,
		config:  map[string]any{"enabled": true},
	}
}

// CreateDwellMs sets the time resources spend in CREATING state before becoming ACTIVE.
func (b *LifecycleBuilder) CreateDwellMs(ms int) *LifecycleBuilder {
	b.config["create_dwell_ms"] = ms
	return b
}

// DeleteDwellMs sets the time resources spend in DELETING state before removal.
func (b *LifecycleBuilder) DeleteDwellMs(ms int) *LifecycleBuilder {
	b.config["delete_dwell_ms"] = ms
	return b
}

// Apply POSTs the lifecycle configuration to the management API.
func (b *LifecycleBuilder) Apply() error {
	return b.post(map[string]any{b.service: b.config})
}

// Clear disables lifecycle simulation for this service.
func (b *LifecycleBuilder) Clear() error {
	return b.post(map[string]any{
		b.service: map[string]any{
			"enabled":         false,
			"create_dwell_ms": 0,
			"delete_dwell_ms": 0,
		},
	})
}

func (b *LifecycleBuilder) post(payload map[string]any) error {
	data, err := json.Marshal(payload)
	if err != nil {
		return fmt.Errorf("lifecycle: marshal payload: %w", err)
	}
	url := fmt.Sprintf("http://127.0.0.1:%d/_ldk/lifecycle", b.session.basePort)
	resp, err := http.Post(url, "application/json", bytes.NewReader(data)) //nolint:noctx
	if err != nil {
		return fmt.Errorf("lifecycle: post to management API: %w", err)
	}
	resp.Body.Close()
	return nil
}
