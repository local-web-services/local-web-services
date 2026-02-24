package lws

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
)

// IamBuilder configures IAM authentication mode for the local session.
// Obtain one via Session.Iam().
type IamBuilder struct {
	session    *Session
	updates    map[string]any
	identities map[string]*IdentityBuilder
}

// IdentityBuilder configures a single named IAM identity.
type IdentityBuilder struct {
	parent   *IamBuilder
	name     string
	policies []policyDoc
	boundary *policyDoc
}

type policyDoc struct {
	Effect   string   `json:"Effect"`
	Actions  []string `json:"Action"`
	Resource string   `json:"Resource"`
}

// Mode sets the IAM authentication mode (e.g. "enforce" or "permissive").
func (b *IamBuilder) Mode(mode string) *IamBuilder {
	b.updates["mode"] = mode
	return b
}

// DefaultIdentity sets the default identity used when no explicit identity is specified.
func (b *IamBuilder) DefaultIdentity(name string) *IamBuilder {
	b.updates["default_identity"] = name
	return b
}

// Identity returns an IdentityBuilder for the named identity.
func (b *IamBuilder) Identity(name string) *IdentityBuilder {
	ib := &IdentityBuilder{parent: b, name: name}
	b.identities[name] = ib
	return ib
}

// Apply POSTs the IAM configuration to the /_ldk/iam-auth management API.
func (b *IamBuilder) Apply() error {
	body := make(map[string]any)
	for k, v := range b.updates {
		body[k] = v
	}
	if len(b.identities) > 0 {
		identMap := make(map[string]any)
		for name, ib := range b.identities {
			entry := make(map[string]any)
			if len(ib.policies) > 0 {
				entry["inline_policies"] = ib.policies
			}
			if ib.boundary != nil {
				entry["boundary_policy"] = ib.boundary
			}
			identMap[name] = entry
		}
		body["identities"] = identMap
	}
	data, err := json.Marshal(body)
	if err != nil {
		return fmt.Errorf("iam: marshal payload: %w", err)
	}
	url := fmt.Sprintf("http://127.0.0.1:%d/_ldk/iam-auth", b.session.basePort)
	resp, err := http.Post(url, "application/json", bytes.NewReader(data)) //nolint:noctx
	if err != nil {
		return fmt.Errorf("iam: post to management API: %w", err)
	}
	resp.Body.Close()
	return nil
}

// Allow adds an allow policy statement for the given actions and resource.
func (b *IdentityBuilder) Allow(actions []string, resource string) *IdentityBuilder {
	b.policies = append(b.policies, policyDoc{Effect: "Allow", Actions: actions, Resource: resource})
	return b
}

// Deny adds a deny policy statement for the given actions and resource.
func (b *IdentityBuilder) Deny(actions []string, resource string) *IdentityBuilder {
	b.policies = append(b.policies, policyDoc{Effect: "Deny", Actions: actions, Resource: resource})
	return b
}

// Boundary sets a permissions boundary policy for the identity.
func (b *IdentityBuilder) Boundary(actions []string, resource string) *IdentityBuilder {
	p := policyDoc{Effect: "Allow", Actions: actions, Resource: resource}
	b.boundary = &p
	return b
}

// Apply registers this identity with the parent IamBuilder and returns the parent for chaining.
func (b *IdentityBuilder) Apply() *IamBuilder {
	return b.parent
}
