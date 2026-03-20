package lws

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
)

// CapacityBuilder configures capacity slot limits for a service.
// Obtain one via Session.Capacity("service-name").
type CapacityBuilder struct {
	session *Session
	service string
	config  map[string]interface{}
}

func newCapacityBuilder(session *Session, service string) *CapacityBuilder {
	return &CapacityBuilder{session: session, service: service, config: map[string]interface{}{}}
}

// Exhaust sets the slot count to zero (no capacity available).
func (b *CapacityBuilder) Exhaust() *CapacityBuilder {
	b.config["slots"] = 0
	return b
}

// Slots sets the slot count to a specific value.
func (b *CapacityBuilder) Slots(n int) *CapacityBuilder {
	b.config["slots"] = n
	return b
}

// Unlimited removes the slot limit.
func (b *CapacityBuilder) Unlimited() *CapacityBuilder {
	b.config["slots"] = nil
	return b
}

// Apply sends the capacity config to the management API.
func (b *CapacityBuilder) Apply() error {
	payload := map[string]interface{}{b.service: b.config}
	body, err := json.Marshal(payload)
	if err != nil {
		return fmt.Errorf("capacity: marshal payload: %w", err)
	}
	url := fmt.Sprintf("http://127.0.0.1:%d/_ldk/capacity", b.session.basePort)
	resp, err := http.Post(url, "application/json", bytes.NewReader(body)) //nolint:noctx
	if err != nil {
		return fmt.Errorf("capacity: post to management API: %w", err)
	}
	resp.Body.Close()
	return nil
}

// Clear restores unlimited capacity for this service.
func (b *CapacityBuilder) Clear() error {
	return b.Unlimited().Apply()
}
