"""CloudTrail shared response helpers."""

from __future__ import annotations

import json

from fastapi import Response


def _json_response(body: dict, status_code: int = 200) -> Response:
    """Return a JSON response with AWS CloudTrail media type."""
    return Response(
        content=json.dumps(body),
        status_code=status_code,
        media_type="application/x-amz-json-1.1",
    )


def _error_response(error_type: str, message: str, status_code: int = 400) -> Response:
    """Return an AWS-style error JSON response."""
    return Response(
        content=json.dumps({"__type": error_type, "Message": message}),
        status_code=status_code,
        media_type="application/x-amz-json-1.1",
    )
