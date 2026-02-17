"""Route matching engine for mock servers.

Converts route rules into a matching pipeline: path regex, method check,
criteria evaluation, and template rendering.
"""

from __future__ import annotations

import re
from typing import Any

from lws.providers.mockserver.models import MatchCriteria, MockResponse, RouteRule
from lws.providers.mockserver.operators import match_value
from lws.providers.mockserver.template import render_template

_PATH_PARAM_RE = re.compile(r"\{(\w+)\}")


def _path_to_regex(path: str) -> re.Pattern[str]:
    """Convert a path pattern like ``/v1/payments/{id}`` to a regex."""
    regex = _PATH_PARAM_RE.sub(r"(?P<\1>[^/]+)", path)
    return re.compile(f"^{regex}$")


def _match_headers(criteria: MatchCriteria, headers: dict[str, str]) -> bool:
    """Check if all criteria headers match (supports regex)."""
    lower_headers = {k.lower(): v for k, v in headers.items()}
    for name, pattern in criteria.headers.items():
        actual = lower_headers.get(name.lower())
        if actual is None:
            return False
        if not re.search(pattern, actual):
            return False
    return True


def _match_path_params(criteria: MatchCriteria, path_params: dict[str, str]) -> bool:
    """Check if all criteria path params match (supports regex)."""
    for name, pattern in criteria.path_params.items():
        actual = path_params.get(name)
        if actual is None:
            return False
        if not re.fullmatch(pattern, actual):
            return False
    return True


def _match_query_params(criteria: MatchCriteria, query_params: dict[str, str]) -> bool:
    """Check if all criteria query params match (supports regex)."""
    for name, pattern in criteria.query_params.items():
        actual = query_params.get(name)
        if actual is None:
            return False
        if not re.search(pattern, actual):
            return False
    return True


def _resolve_dotpath(obj: Any, dotpath: str) -> Any:
    """Resolve a dot-separated path against a nested dict."""
    parts = dotpath.split(".")
    current = obj
    for part in parts:
        if isinstance(current, dict):
            current = current.get(part)
        else:
            return None
        if current is None:
            return None
    return current


def _match_body(criteria: MatchCriteria, body: Any) -> bool:
    """Check if all body matchers match the request body."""
    if not criteria.body_matchers:
        return True
    if body is None:
        return False
    for dotpath, matcher in criteria.body_matchers.items():
        actual = _resolve_dotpath(body, dotpath)
        if not match_value(actual, matcher):
            return False
    return True


def _match_criteria(
    criteria: MatchCriteria,
    *,
    headers: dict[str, str],
    path_params: dict[str, str],
    query_params: dict[str, str],
    body: Any,
) -> bool:
    """Evaluate all criteria against the incoming request."""
    if not _match_headers(criteria, headers):
        return False
    if not _match_path_params(criteria, path_params):
        return False
    if not _match_query_params(criteria, query_params):
        return False
    if not _match_body(criteria, body):
        return False
    return True


class RouteMatchEngine:
    """Matches incoming requests against a list of route rules."""

    def __init__(self, rules: list[RouteRule]) -> None:
        self._compiled: list[tuple[re.Pattern[str], RouteRule]] = [
            (_path_to_regex(rule.path), rule) for rule in rules
        ]

    def match(
        self,
        *,
        method: str,
        path: str,
        headers: dict[str, str] | None = None,
        query_params: dict[str, str] | None = None,
        body: Any = None,
    ) -> tuple[MockResponse, dict[str, str]] | None:
        """Find the first matching response for the given request.

        Returns ``(rendered_response, path_params)`` or ``None``.
        """
        headers = headers or {}
        query_params = query_params or {}

        for pattern, rule in self._compiled:
            if rule.method.upper() != method.upper():
                continue
            m = pattern.match(path)
            if not m:
                continue
            path_params = m.groupdict()

            for criteria, response in rule.responses:
                if _match_criteria(
                    criteria,
                    headers=headers,
                    path_params=path_params,
                    query_params=query_params,
                    body=body,
                ):
                    rendered = _render_response(
                        response,
                        path_params=path_params,
                        query_params=query_params,
                        headers=headers,
                        body=body,
                    )
                    return rendered, path_params
        return None


def _render_response(
    response: MockResponse,
    *,
    path_params: dict[str, str],
    query_params: dict[str, str],
    headers: dict[str, str],
    body: Any,
) -> MockResponse:
    """Render template tokens in the response body and headers."""
    rendered_body = render_template(
        response.body,
        path_params=path_params,
        query_params=query_params,
        headers=headers,
        body=body,
    )
    rendered_headers = {
        k: render_template(
            v, path_params=path_params, query_params=query_params, headers=headers, body=body
        )
        for k, v in response.headers.items()
    }
    return MockResponse(
        status=response.status,
        headers=rendered_headers,
        body=rendered_body,
        delay_ms=response.delay_ms,
    )
