package lws

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
)

// FakeBuilder configures fake responses for a single AWS service.
// Obtain one via Session.Fake("service-name").
type FakeBuilder struct {
	session *Session
	service string
	rules   []fakeRule
}

type fakeRule struct {
	Operation    string          `json:"operation"`
	MatchHeaders map[string]string `json:"match_headers,omitempty"`
	Response     fakeResponse    `json:"response"`
}

type fakeResponse struct {
	Status      int    `json:"status"`
	ContentType string `json:"content_type"`
	Body        string `json:"body,omitempty"`
	DelayMs     int    `json:"delay_ms,omitempty"`
}

// Fake returns a FakeBuilder for the given service (e.g. "stepfunctions").
func (s *Session) Fake(service string) *FakeBuilder {
	return &FakeBuilder{session: s, service: service}
}

// Operation starts building a fake rule for the named operation
// (e.g. "start-execution"). Chain Respond or Error to finish the rule.
func (b *FakeBuilder) Operation(operationName string) *FakeRuleBuilder {
	return &FakeRuleBuilder{parent: b, operation: operationName}
}

// Clear removes all fake rules for this service.
func (b *FakeBuilder) Clear() error {
	b.rules = nil
	return b.apply(false)
}

func (b *FakeBuilder) apply(enabled bool) error {
	payload := map[string]any{
		b.service: map[string]any{
			"enabled": enabled,
			"rules":   b.rules,
		},
	}
	data, err := json.Marshal(payload)
	if err != nil {
		return fmt.Errorf("fake: marshal payload: %w", err)
	}
	url := fmt.Sprintf("http://127.0.0.1:%d/_ldk/aws-fake", b.session.basePort)
	resp, err := http.Post(url, "application/json", bytes.NewReader(data)) //nolint:noctx
	if err != nil {
		return fmt.Errorf("fake: post to management API: %w", err)
	}
	resp.Body.Close()
	return nil
}

// FakeRuleBuilder builds a single fake rule for one operation.
type FakeRuleBuilder struct {
	parent    *FakeBuilder
	operation string
	headers   map[string]string
	delayMs   int
}

// WithHeader adds a required request header match to the rule.
func (r *FakeRuleBuilder) WithHeader(name, value string) *FakeRuleBuilder {
	if r.headers == nil {
		r.headers = make(map[string]string)
	}
	r.headers[name] = value
	return r
}

// DelayMs sets a response delay in milliseconds for the rule.
func (r *FakeRuleBuilder) DelayMs(ms int) *FakeRuleBuilder {
	r.delayMs = ms
	return r
}

// Respond configures a success response for the operation.
// body may be nil, a string, or any JSON-serialisable value.
func (r *FakeRuleBuilder) Respond(statusCode int, body any) (*FakeBuilder, error) {
	bodyStr, err := marshalBody(body)
	if err != nil {
		return nil, err
	}
	rule := fakeRule{
		Operation:    r.operation,
		MatchHeaders: r.headers,
		Response: fakeResponse{
			Status:      statusCode,
			ContentType: "application/json",
			Body:        bodyStr,
			DelayMs:     r.delayMs,
		},
	}
	r.parent.rules = append(r.parent.rules, rule)
	if err := r.parent.apply(true); err != nil {
		return nil, err
	}
	return r.parent, nil
}

// Error configures the operation to return an AWS-style error response.
func (r *FakeRuleBuilder) Error(errorType, message string) (*FakeBuilder, error) {
	body, err := json.Marshal(map[string]string{"__type": errorType, "message": message})
	if err != nil {
		return nil, err
	}
	return r.Respond(400, string(body))
}

func marshalBody(body any) (string, error) {
	if body == nil {
		return "", nil
	}
	switch v := body.(type) {
	case string:
		return v, nil
	default:
		b, err := json.Marshal(v)
		if err != nil {
			return "", fmt.Errorf("fake: marshal body: %w", err)
		}
		return string(b), nil
	}
}
