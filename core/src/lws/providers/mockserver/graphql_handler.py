"""GraphQL operation matching for mock servers.

Parses GraphQL requests (simple JSON body parsing, no external GraphQL library)
and matches against configured GraphQL route definitions.
"""

from __future__ import annotations

import re
from typing import Any

from lws.providers.mockserver.models import GraphQLRoute
from lws.providers.mockserver.operators import match_value
from lws.providers.mockserver.template import render_template

_OPERATION_RE = re.compile(
    r"(?:query|mutation|subscription)\s+(\w+)",
    re.IGNORECASE,
)


def extract_operation_info(body: dict[str, Any]) -> tuple[str, str, dict[str, Any]]:
    """Extract operation type, name, and variables from a GraphQL request body.

    Returns ``(operation_type, operation_name, variables)``.
    The operation_type is ``Query``, ``Mutation``, or ``Subscription``.
    """
    query = body.get("query", "")
    variables = body.get("variables") or {}
    operation_name = body.get("operationName", "")

    # Try to extract from query string
    op_type = "Query"
    match = _OPERATION_RE.search(query)
    if match:
        op_word = query[: match.start() + len(match.group(0))].strip().split()[0].lower()
        if op_word == "mutation":
            op_type = "Mutation"
        elif op_word == "subscription":
            op_type = "Subscription"
        if not operation_name:
            operation_name = match.group(1)

    # Extract field name from query body
    field_name = _extract_field_name(query)

    return op_type, field_name or operation_name, variables


def _extract_field_name(query: str) -> str:
    """Extract the first field name from a GraphQL query body."""
    # Remove operation header
    stripped = re.sub(r"^(query|mutation|subscription)\s+\w*\s*(\([^)]*\))?\s*", "", query.strip())
    # Find first field inside braces
    brace_match = re.search(r"\{\s*(\w+)", stripped)
    if brace_match:
        return brace_match.group(1)
    return ""


def match_graphql_request(
    routes: list[GraphQLRoute],
    body: dict[str, Any],
) -> dict[str, Any] | None:
    """Match a GraphQL request against configured routes.

    Returns the rendered response dict or None.
    """
    op_type, field_name, variables = extract_operation_info(body)
    operation_key = f"{op_type}.{field_name}"

    for route in routes:
        if route.operation != operation_key:
            continue

        match_spec = route.match
        if not match_spec:
            return _render_graphql_response(route.response, variables)

        # Match against variables
        var_matchers = match_spec.get("variables", {})
        if var_matchers and not _match_variables(var_matchers, variables):
            continue

        return _render_graphql_response(route.response, variables)

    return None


def _match_variables(matchers: dict[str, Any], variables: dict[str, Any]) -> bool:
    """Check if variables match the specified matchers."""
    for key, matcher in matchers.items():
        actual = variables.get(key)
        if not match_value(actual, matcher):
            return False
    return True


def _render_graphql_response(response: dict[str, Any], variables: dict[str, Any]) -> dict[str, Any]:
    """Render template variables in a GraphQL response."""
    return render_template(response, variables=variables)
