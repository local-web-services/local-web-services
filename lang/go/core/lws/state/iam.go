package state

import (
	"fmt"
	"net/http"
	"regexp"
	"strings"
)

func wildcardMatch(pattern, value string) bool {
	escaped := regexp.QuoteMeta(pattern)
	escaped = strings.ReplaceAll(escaped, `\*`, ".*")
	escaped = strings.ReplaceAll(escaped, `\?`, ".")
	re, err := regexp.Compile("(?i)^" + escaped + "$")
	if err != nil {
		return false
	}
	return re.MatchString(value)
}

func toStringSlice(v interface{}) []string {
	if v == nil {
		return nil
	}
	switch t := v.(type) {
	case string:
		return []string{t}
	case []string:
		return t
	case []interface{}:
		var result []string
		for _, item := range t {
			if s, ok := item.(string); ok {
				result = append(result, s)
			}
		}
		return result
	}
	return nil
}

type evalResult int

const (
	evalNoMatch evalResult = iota
	evalAllow
	evalDeny
)

func evaluateStatement(stmt IamStatement, action, resource string) evalResult {
	actions := toStringSlice(stmt.Action)
	resources := toStringSlice(stmt.Resource)

	actionMatch := false
	for _, a := range actions {
		if wildcardMatch(a, action) {
			actionMatch = true
			break
		}
	}
	if !actionMatch {
		return evalNoMatch
	}

	resourceMatch := false
	for _, r := range resources {
		if wildcardMatch(r, resource) {
			resourceMatch = true
			break
		}
	}
	if !resourceMatch {
		return evalNoMatch
	}

	if stmt.Effect == "Allow" {
		return evalAllow
	}
	return evalDeny
}

func evaluatePolicy(policy IamPolicy, action, resource string) evalResult {
	result := evalNoMatch
	for _, stmt := range policy.Statement {
		r := evaluateStatement(stmt, action, resource)
		if r == evalDeny {
			return evalDeny
		}
		if r == evalAllow {
			result = evalAllow
		}
	}
	return result
}

func isAuthorized(cfg IamConfig, accessKeyID, action, resource string) bool {
	identity, ok := cfg.Identities[accessKeyID]
	if !ok {
		if cfg.DefaultIdentity != "" {
			identity, ok = cfg.Identities[cfg.DefaultIdentity]
		}
		if !ok {
			identity, ok = cfg.Identities["default"]
		}
		if !ok {
			return false
		}
	}

	for _, policy := range identity.InlinePolicies {
		for _, stmt := range policy.Statement {
			if stmt.Effect == "Deny" {
				if evaluateStatement(stmt, action, resource) == evalDeny {
					return false
				}
			}
		}
	}

	if identity.PermissionBoundary != nil {
		if evaluatePolicy(*identity.PermissionBoundary, action, resource) != evalAllow {
			return false
		}
	}

	for _, policy := range identity.InlinePolicies {
		if evaluatePolicy(policy, action, resource) == evalAllow {
			return true
		}
	}

	return false
}

// ApplyIAMAuth checks IAM rules. Returns true if response was sent (access denied).
func ApplyIAMAuth(s *ServerState, service, operation string, r *http.Request, w http.ResponseWriter, isXML bool) bool {
	cfg := s.GetIamConfig()
	if !cfg.Enforce {
		return false
	}

	authHeader := r.Header.Get("Authorization")
	accessKeyID := "anonymous"
	if authHeader != "" {
		re := regexp.MustCompile(`Credential=([^/,]+)`)
		if m := re.FindStringSubmatch(authHeader); len(m) > 1 {
			accessKeyID = m[1]
		}
	}

	action := fmt.Sprintf("%s:%s", strings.ToLower(service), operation)
	resource := "*"

	if !isAuthorized(cfg, accessKeyID, action, resource) {
		if isXML {
			w.Header().Set("Content-Type", "application/xml")
			w.WriteHeader(403)
			fmt.Fprintf(w, `<?xml version="1.0" encoding="UTF-8"?><Error><Code>AccessDenied</Code><Message>Access Denied: User is not authorized to perform: %s</Message></Error>`, action)
		} else {
			WriteJSONError(w, "AccessDeniedException",
				fmt.Sprintf("User: arn:aws:iam::000000000000:user/%s is not authorized to perform: %s", accessKeyID, action),
				403)
		}
		return true
	}
	return false
}
