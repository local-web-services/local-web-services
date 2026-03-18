"""Shared request body parsing utilities for AWS-style JSON APIs."""

from __future__ import annotations

import json
from typing import Any

from starlette.requests import Request


async def parse_json_body(request: Request) -> dict:
    """Parse the JSON request body, returning an empty dict on failure."""
    body_bytes = await request.body()
    if not body_bytes:
        return {}
    try:
        return json.loads(body_bytes)
    except json.JSONDecodeError:
        return {}


def resolve_api_action(target: str, body: dict) -> str:
    """Resolve the API action from the X-Amz-Target header or body."""
    if target:
        return target.rsplit(".", 1)[-1] if "." in target else target
    return body.get("Action", "")


_BINARY_CONTENT_TYPES = frozenset(
    {
        "application/octet-stream",
        "image/png",
        "image/jpeg",
        "image/gif",
        "image/webp",
        "application/pdf",
        "application/zip",
        "application/x-protobuf",
        "application/grpc",
    }
)


async def action_dispatch(
    request: Request,
    state: Any,
    tracker: Any,
    action_handlers: dict,
    service_name: str,
    logger: Any,
    error_factory: Any,
) -> Any:
    """Standard AWS action dispatch: parse request, look up handler, invoke it."""
    target = request.headers.get("x-amz-target", "")
    body = await parse_json_body(request)
    action = resolve_api_action(target, body)
    handler = action_handlers.get(action)
    if handler is None:
        logger.warning("Unknown %s action: %s", service_name, action)
        return error_factory(
            "InvalidAction",
            f"lws: {service_name} operation '{action}' is not yet implemented",
        )
    return await handler(state, body, tracker)


def is_binary_content_type(content_type: str) -> bool:
    """Return True if the content type indicates binary data."""
    ct = content_type.split(";")[0].strip().lower()
    return ct in _BINARY_CONTENT_TYPES or ct.startswith(("image/", "audio/", "video/"))
