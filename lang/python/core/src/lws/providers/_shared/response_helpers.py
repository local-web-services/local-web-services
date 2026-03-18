"""Shared HTTP response helpers for AWS-style JSON APIs.

Includes helpers for lifecycle state guards used by DB service providers.
"""

from __future__ import annotations

import json
from datetime import UTC, datetime

from starlette.responses import Response


def json_response(data: dict, status_code: int = 200) -> Response:
    """Return a JSON response with the standard AWS media type."""
    return Response(
        content=json.dumps(data, default=str),
        status_code=status_code,
        media_type="application/x-amz-json-1.1",
    )


def error_response(
    code: str,
    message: str,
    *,
    status_code: int = 400,
    message_key: str = "Message",
) -> Response:
    """Return an error response in AWS JSON format."""
    error_body = {"__type": code, message_key: message}
    return json_response(error_body, status_code=status_code)


def iso_now() -> str:
    """Return the current UTC time in ISO 8601 format."""
    return datetime.now(UTC).strftime("%Y-%m-%dT%H:%M:%S.000Z")


def parse_endpoint(endpoint: str) -> tuple[str, int]:
    """Split a ``host:port`` endpoint string into ``(host, port)``."""
    host, port_str = endpoint.rsplit(":", 1)
    return host, int(port_str)


def creating_guard(
    resource_id: str,
    fault_code: str,
    resource_type: str,
    current_state: str | None,
) -> Response | None:
    """Return an error response if *current_state* is ``"CREATING"``, else None."""
    if current_state == "CREATING":
        return error_response(
            fault_code,
            f"{resource_type} {resource_id} is still being created",
            status_code=400,
        )
    return None
