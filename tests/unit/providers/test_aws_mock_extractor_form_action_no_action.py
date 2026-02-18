"""Unit tests for _extractor_form_action when no action present."""

from __future__ import annotations

from starlette.requests import Request

from lws.providers._shared.aws_operation_mock import _extractor_form_action


def _make_request(
    method: str = "POST",
    path: str = "/",
    headers: list[tuple[bytes, bytes]] | None = None,
    query_string: bytes = b"",
) -> Request:
    """Create a minimal Starlette Request from a scope dict."""
    scope = {
        "type": "http",
        "method": method,
        "path": path,
        "headers": headers or [],
        "query_string": query_string,
    }
    return Request(scope)


class TestExtractorFormActionNoAction:
    def test_no_action_returns_none(self):
        # Arrange
        extractor = _extractor_form_action()
        request = _make_request()

        # Act
        actual_operation = extractor(request, b"")

        # Assert
        assert actual_operation is None
