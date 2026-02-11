"""Shared request body parsing utilities for AWS-style JSON APIs."""

from __future__ import annotations

import json

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
