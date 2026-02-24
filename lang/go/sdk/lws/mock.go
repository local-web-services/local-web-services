package lws

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
)

// MockBuilder configures mock responses for a single AWS service.
// Obtain one via Session.Mock("service-name").
type MockBuilder struct {
	session *Session
	service string
	rules   []mockRule
}

type mockRule struct {
	Operation    string          `json:"operation"`
	MatchHeaders map[string]string `json:"match_headers,omitempty"`
	Response     mockResponse    `json:"response"`
}

type mockResponse struct {
	Status      int    `json:"status"`
	ContentType string `json:"content_type"`
	Body        string `json:"body,omitempty"`
	DelayMs     int    `json:"delay_ms,omitempty"`
}

// Mock returns a MockBuilder for the given service (e.g. "stepfunctions").
func (s *Session) Mock(service string) *MockBuilder {
	return &MockBuilder{session: s, service: service}
}

// Operation starts building a mock rule for the named operation
// (e.g. "start-execution"). Chain Respond or Error to finish the rule.
func (b *MockBuilder) Operation(operationName string) *MockRuleBuilder {
	return &MockRuleBuilder{parent: b, operation: operationName}
}

// Clear removes all mock rules for this service.
func (b *MockBuilder) Clear() error {
	b.rules = nil
	return b.apply(false)
}

func (b *MockBuilder) apply(enabled bool) error {
	payload := map[string]any{
		b.service: map[string]any{
			"enabled": enabled,
			"rules":   b.rules,
		},
	}
	data, err := json.Marshal(payload)
	if err != nil {
		return fmt.Errorf("mock: marshal payload: %w", err)
	}
	url := fmt.Sprintf("http://127.0.0.1:%d/_ldk/aws-mock", b.session.basePort)
	resp, err := http.Post(url, "application/json", bytes.NewReader(data)) //nolint:noctx
	if err != nil {
		return fmt.Errorf("mock: post to management API: %w", err)
	}
	resp.Body.Close()
	return nil
}

// MockRuleBuilder builds a single mock rule for one operation.
type MockRuleBuilder struct {
	parent    *MockBuilder
	operation string
	headers   map[string]string
	delayMs   int
}

// WithHeader adds a required request header match to the rule.
func (r *MockRuleBuilder) WithHeader(name, value string) *MockRuleBuilder {
	if r.headers == nil {
		r.headers = make(map[string]string)
	}
	r.headers[name] = value
	return r
}

// DelayMs sets a response delay in milliseconds for the rule.
func (r *MockRuleBuilder) DelayMs(ms int) *MockRuleBuilder {
	r.delayMs = ms
	return r
}

// Respond configures a success response for the operation.
// body may be nil, a string, or any JSON-serialisable value.
func (r *MockRuleBuilder) Respond(statusCode int, body any) (*MockBuilder, error) {
	bodyStr, err := marshalBody(body)
	if err != nil {
		return nil, err
	}
	rule := mockRule{
		Operation:    r.operation,
		MatchHeaders: r.headers,
		Response: mockResponse{
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
func (r *MockRuleBuilder) Error(errorType, message string) (*MockBuilder, error) {
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
			return "", fmt.Errorf("mock: marshal body: %w", err)
		}
		return string(b), nil
	}
}
