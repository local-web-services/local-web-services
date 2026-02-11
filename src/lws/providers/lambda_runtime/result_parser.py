"""Shared invocation result parsing for Lambda runtime providers."""

from __future__ import annotations

import json

from lws.interfaces import InvocationResult


def parse_invocation_output(raw: str, duration_ms: float, request_id: str) -> InvocationResult:
    """Parse JSON emitted by a Lambda bootstrap into an InvocationResult."""
    try:
        data = json.loads(raw)
    except json.JSONDecodeError:
        return InvocationResult(
            payload=None,
            error=f"Failed to parse subprocess output: {raw!r}",
            duration_ms=duration_ms,
            request_id=request_id,
        )

    if "error" in data:
        err = data["error"]
        error_message = err.get("errorMessage", str(err)) if isinstance(err, dict) else str(err)
        return InvocationResult(
            payload=None,
            error=error_message,
            duration_ms=duration_ms,
            request_id=request_id,
        )

    return InvocationResult(
        payload=data.get("result"),
        error=None,
        duration_ms=duration_ms,
        request_id=request_id,
    )
