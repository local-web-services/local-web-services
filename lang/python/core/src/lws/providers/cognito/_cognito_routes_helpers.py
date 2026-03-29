"""Shared response helpers for Cognito route handlers."""

from __future__ import annotations

import json

from fastapi import Response


def json_response(data: dict, status_code: int = 200) -> Response:
    """Create a JSON response with the Cognito content type."""
    return Response(
        content=json.dumps(data),
        status_code=status_code,
        media_type="application/x-amz-json-1.1",
    )


def error_response(error_type: str, message: str) -> Response:
    """Create an error response."""
    return json_response(
        {"__type": error_type, "message": message},
        status_code=400,
    )
