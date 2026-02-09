"""Environment variable validator.

Checks Lambda environment variables for CloudFormation Ref/Fn::GetAtt
references and validates that the referenced resources exist in the
application graph. Designed to run at startup time.
"""

from __future__ import annotations

import re
from typing import Any

from lws.graph.builder import AppGraph
from lws.validation.engine import (
    ValidationContext,
    ValidationIssue,
    ValidationLevel,
    Validator,
)

# Patterns that indicate unresolved CloudFormation references.
_REF_PATTERN = re.compile(r"\$\{([^}]+)\}")
_FN_GET_ATT_MARKERS = ("Fn::GetAtt", "!GetAtt")
_REF_MARKERS = ("Ref:", "!Ref")


class EnvVarValidator(Validator):
    """Validates that environment variable references resolve to known resources."""

    def __init__(self, app_graph: AppGraph) -> None:
        self._app_graph = app_graph

    @property
    def name(self) -> str:
        return "env_var"

    def validate(self, context: ValidationContext) -> list[ValidationIssue]:
        """Check environment variables in context data for unresolvable references."""
        environment = context.data.get("environment", {})
        if not environment:
            return []

        issues: list[ValidationIssue] = []
        for env_key, env_value in environment.items():
            issues.extend(
                _check_env_value(
                    env_key,
                    env_value,
                    self._app_graph,
                    context,
                )
            )
        return issues


def _check_env_value(
    env_key: str,
    env_value: Any,
    app_graph: AppGraph,
    context: ValidationContext,
) -> list[ValidationIssue]:
    """Check a single environment variable value for unresolved references."""
    if not isinstance(env_value, str):
        return []

    issues: list[ValidationIssue] = []
    issues.extend(_check_cfn_markers(env_key, env_value, app_graph, context))
    issues.extend(_check_interpolation_refs(env_key, env_value, app_graph, context))
    return issues


def _check_cfn_markers(
    env_key: str,
    env_value: str,
    app_graph: AppGraph,
    context: ValidationContext,
) -> list[ValidationIssue]:
    """Check for CloudFormation Ref and Fn::GetAtt markers."""
    issues: list[ValidationIssue] = []

    for marker in _REF_MARKERS:
        if marker in env_value:
            ref_name = env_value.split(marker)[-1].strip()
            if ref_name and ref_name not in app_graph.nodes:
                issues.append(_unresolvable_ref(env_key, ref_name, context))

    for marker in _FN_GET_ATT_MARKERS:
        if marker in env_value:
            parts = env_value.split(marker)[-1].strip().split(".")
            resource_name = parts[0].strip() if parts else ""
            if resource_name and resource_name not in app_graph.nodes:
                issues.append(_unresolvable_ref(env_key, resource_name, context))

    return issues


def _check_interpolation_refs(
    env_key: str,
    env_value: str,
    app_graph: AppGraph,
    context: ValidationContext,
) -> list[ValidationIssue]:
    """Check for ${ResourceName} style interpolation references."""
    issues: list[ValidationIssue] = []
    for match in _REF_PATTERN.finditer(env_value):
        ref_name = match.group(1).strip()
        # Skip if it looks like a resolved ARN or URL
        if ref_name.startswith("arn:") or "://" in ref_name:
            continue
        if ref_name not in app_graph.nodes:
            issues.append(_unresolvable_ref(env_key, ref_name, context))
    return issues


def _unresolvable_ref(
    env_key: str,
    ref_name: str,
    context: ValidationContext,
) -> ValidationIssue:
    """Create an issue for an unresolvable reference."""
    return ValidationIssue(
        level=ValidationLevel.ERROR,
        message=(f"Environment variable '{env_key}' references " f"unknown resource '{ref_name}'"),
        resource=context.resource_id,
        operation=context.operation,
    )
