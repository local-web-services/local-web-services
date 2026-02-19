"""Pure-function IAM policy evaluation engine.

Evaluates whether a principal is allowed to perform a set of actions
on a resource, given identity policies, an optional boundary policy,
and an optional resource policy.  Follows the simplified AWS policy
evaluation logic:

1. Explicit Deny in any policy -> DENY
2. Resource policy Allow -> ALLOW
3. Boundary check: action must be allowed by boundary else DENY
4. Identity policy Allow -> ALLOW
5. Implicit DENY
"""

from __future__ import annotations

from dataclasses import dataclass, field
from enum import Enum
from fnmatch import fnmatch


class Decision(Enum):
    """Authorization decision."""

    ALLOW = "ALLOW"
    DENY = "DENY"


@dataclass
class EvaluationContext:
    """All inputs needed for a single authorization decision."""

    principal: str
    actions: list[str]
    resource: str
    identity_policies: list[dict] = field(default_factory=list)
    boundary_policy: dict | None = None
    resource_policy: dict | None = None


def evaluate(context: EvaluationContext) -> tuple[Decision, str]:
    """Evaluate IAM authorization for the given context.

    Returns a (Decision, reason) tuple.
    """
    all_policies = _collect_all_policies(context)

    # Step 1: Explicit Deny in any policy
    if _has_explicit_deny(all_policies, context.actions, context.resource):
        return Decision.DENY, "Explicit Deny"

    # Step 2: Resource policy Allow
    if _resource_policy_allows(context):
        return Decision.ALLOW, "Resource policy Allow"

    # Step 3: Boundary check
    if context.boundary_policy is not None:
        if not _all_actions_allowed_by_policy(
            context.boundary_policy, context.actions, context.resource
        ):
            return Decision.DENY, "Not allowed by permissions boundary"

    # Step 4: Identity policy Allow
    if not _all_actions_allowed_by_identity(context):
        return Decision.DENY, "Implicit Deny"

    return Decision.ALLOW, "Identity policy Allow"


def _collect_all_policies(context: EvaluationContext) -> list[dict]:
    """Collect all policies (identity, boundary, resource) into a single list."""
    all_policies = list(context.identity_policies)
    if context.boundary_policy is not None:
        all_policies.append(context.boundary_policy)
    if context.resource_policy is not None:
        all_policies.append(context.resource_policy)
    return all_policies


def _has_explicit_deny(policies: list[dict], actions: list[str], resource: str) -> bool:
    """Check if any policy contains an explicit Deny for the given actions."""
    for policy in policies:
        for statement in policy.get("Statement", []):
            if statement.get("Effect") != "Deny":
                continue
            if _statement_matches(statement, actions, resource):
                return True
    return False


def _resource_policy_allows(context: EvaluationContext) -> bool:
    """Check if the resource policy explicitly allows the request."""
    if context.resource_policy is None:
        return False
    for statement in context.resource_policy.get("Statement", []):
        if statement.get("Effect") != "Allow":
            continue
        if not _principal_matches(statement, context.principal):
            continue
        if _statement_matches(statement, context.actions, context.resource):
            return True
    return False


def _all_actions_allowed_by_policy(policy: dict, actions: list[str], resource: str) -> bool:
    """Check if all actions are allowed by the given policy."""
    return all(_action_allowed_by_policy(policy, action, resource) for action in actions)


def _all_actions_allowed_by_identity(context: EvaluationContext) -> bool:
    """Check if all actions are allowed by the identity policies."""
    return all(
        _action_allowed_by_identity_policies(context.identity_policies, action, context.resource)
        for action in context.actions
    )


def _statement_matches(statement: dict, actions: list[str], resource: str) -> bool:
    """Check if a statement matches any of the given actions and the resource."""
    stmt_actions = _normalize_list(statement.get("Action", []))
    stmt_resources = _normalize_list(statement.get("Resource", ["*"]))

    action_match = any(
        _matches_action(pattern, action) for pattern in stmt_actions for action in actions
    )
    resource_match = any(_matches_resource(pattern, resource) for pattern in stmt_resources)
    return action_match and resource_match


def _principal_matches(statement: dict, principal: str) -> bool:
    """Check if a statement's Principal matches the given principal."""
    stmt_principal = statement.get("Principal", "*")
    if stmt_principal == "*":
        return True
    principals = _normalize_list(stmt_principal)
    return any(p in ("*", principal) for p in principals)


def _action_allowed_by_policy(policy: dict, action: str, resource: str) -> bool:
    """Check if a single action is allowed by at least one Allow statement."""
    for statement in policy.get("Statement", []):
        if statement.get("Effect") != "Allow":
            continue
        stmt_actions = _normalize_list(statement.get("Action", []))
        stmt_resources = _normalize_list(statement.get("Resource", ["*"]))
        action_ok = any(_matches_action(p, action) for p in stmt_actions)
        resource_ok = any(_matches_resource(p, resource) for p in stmt_resources)
        if action_ok and resource_ok:
            return True
    return False


def _action_allowed_by_identity_policies(policies: list[dict], action: str, resource: str) -> bool:
    """Check if a single action is allowed by any identity policy."""
    return any(_action_allowed_by_policy(policy, action, resource) for policy in policies)


def _matches_action(pattern: str, action: str) -> bool:
    """Check if an action matches a pattern using fnmatch-style wildcards."""
    return fnmatch(action.lower(), pattern.lower())


def _matches_resource(pattern: str, resource: str) -> bool:
    """Check if a resource matches a pattern using fnmatch-style wildcards."""
    return fnmatch(resource, pattern)


def _normalize_list(value: str | list[str]) -> list[str]:
    """Normalize a string-or-list value to a list."""
    if isinstance(value, str):
        return [value]
    return value
