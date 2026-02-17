"""Template variable rendering for mock responses.

Supports tokens like ``{{uuid}}``, ``{{path.x}}``, ``{{query.y}}``,
``{{header.z}}``, ``{{body.a.b}}``, ``{{timestamp}}``, ``{{random_int(1,10)}}``,
and ``{{random_choice(a,b,c)}}``.
"""

from __future__ import annotations

import random
import re
import uuid
from datetime import UTC, datetime
from typing import Any

_TOKEN_RE = re.compile(r"\{\{(.+?)\}\}")
_RANDOM_INT_RE = re.compile(r"random_int\((\d+),(\d+)\)")
_RANDOM_CHOICE_RE = re.compile(r"random_choice\((.+)\)")


def _resolve_dotpath(obj: Any, dotpath: str) -> Any:
    """Resolve a dot-separated path against a nested dict/list."""
    parts = dotpath.split(".")
    current = obj
    for part in parts:
        if isinstance(current, dict):
            current = current.get(part)
        elif isinstance(current, list) and part.isdigit():
            idx = int(part)
            current = current[idx] if idx < len(current) else None
        else:
            return None
        if current is None:
            return None
    return current


_STATIC_TOKENS: dict[str, Any] = {
    "uuid": lambda: str(uuid.uuid4()),
    "timestamp": lambda: datetime.now(UTC).isoformat(),
    "timestamp_epoch": lambda: str(int(datetime.now(UTC).timestamp())),
}

_PREFIX_SOURCES = {
    "path.": lambda t, ctx: str(ctx["path_params"].get(t[5:], "")),
    "query.": lambda t, ctx: str(ctx["query_params"].get(t[6:], "")),
    "header.": lambda t, ctx: str(ctx["headers"].get(t[7:], "")),
    "variables.": lambda t, ctx: str(ctx["variables"].get(t[10:], "")),
}


def _resolve_body_token(token: str, body: Any, prefix_len: int) -> str:
    val = _resolve_dotpath(body, token[prefix_len:])
    return str(val) if val is not None else ""


def _resolve_token(
    token: str,
    *,
    path_params: dict[str, str] | None = None,
    query_params: dict[str, str] | None = None,
    headers: dict[str, str] | None = None,
    body: Any = None,
    variables: dict[str, Any] | None = None,
) -> str:
    """Resolve a single template token to its string value."""
    token = token.strip()

    if token in _STATIC_TOKENS:
        return _STATIC_TOKENS[token]()

    m = _RANDOM_INT_RE.match(token)
    if m:
        return str(random.randint(int(m.group(1)), int(m.group(2))))

    m = _RANDOM_CHOICE_RE.match(token)
    if m:
        choices = [c.strip() for c in m.group(1).split(",")]
        return random.choice(choices)  # noqa: S311

    ctx = {
        "path_params": path_params or {},
        "query_params": query_params or {},
        "headers": headers or {},
        "variables": variables or {},
    }
    for prefix, resolver in _PREFIX_SOURCES.items():
        if token.startswith(prefix):
            return resolver(token, ctx)

    for body_prefix in ("body.", "request."):
        if token.startswith(body_prefix) and body is not None:
            return _resolve_body_token(token, body, len(body_prefix))

    return f"{{{{{token}}}}}"


def render_template(
    value: Any,
    *,
    path_params: dict[str, str] | None = None,
    query_params: dict[str, str] | None = None,
    headers: dict[str, str] | None = None,
    body: Any = None,
    variables: dict[str, Any] | None = None,
) -> Any:
    """Recursively render template tokens in a value (str, dict, or list)."""
    if isinstance(value, str):
        return _TOKEN_RE.sub(
            lambda m: _resolve_token(
                m.group(1),
                path_params=path_params,
                query_params=query_params,
                headers=headers,
                body=body,
                variables=variables,
            ),
            value,
        )
    if isinstance(value, dict):
        return {
            render_template(
                k,
                path_params=path_params,
                query_params=query_params,
                headers=headers,
                body=body,
                variables=variables,
            ): render_template(
                v,
                path_params=path_params,
                query_params=query_params,
                headers=headers,
                body=body,
                variables=variables,
            )
            for k, v in value.items()
        }
    if isinstance(value, list):
        return [
            render_template(
                item,
                path_params=path_params,
                query_params=query_params,
                headers=headers,
                body=body,
                variables=variables,
            )
            for item in value
        ]
    return value
