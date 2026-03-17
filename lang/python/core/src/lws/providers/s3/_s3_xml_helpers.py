"""Shared XML helper utilities for S3 route handlers."""

from __future__ import annotations

from fastapi import Response


def _xml_response(body: str, status_code: int = 200) -> Response:
    """Return an XML response with the standard S3 content type."""
    return Response(
        content=body,
        status_code=status_code,
        media_type="application/xml",
    )


def _json_s3_response(body: str, status_code: int = 200) -> Response:
    """Return a JSON response (used for GetBucketPolicy etc.)."""
    return Response(
        content=body,
        status_code=status_code,
        media_type="application/json",
    )


def _xml_escape(text: str) -> str:
    """Escape special XML characters."""
    return (
        text.replace("&", "&amp;")
        .replace("<", "&lt;")
        .replace(">", "&gt;")
        .replace('"', "&quot;")
        .replace("'", "&apos;")
    )


def _error_xml(code: str, message: str, status_code: int = 400) -> Response:
    """Return an S3-style XML error response."""
    body = (
        '<?xml version="1.0" encoding="UTF-8"?>'
        "<Error>"
        f"<Code>{_xml_escape(code)}</Code>"
        f"<Message>{_xml_escape(message)}</Message>"
        "</Error>"
    )
    return _xml_response(body, status_code=status_code)
