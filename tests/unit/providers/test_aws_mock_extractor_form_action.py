"""Unit tests for _extractor_form_action query param."""

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


class TestExtractorFormActionQueryParam:
    def test_action_in_query_params(self):
        # Arrange
        extractor = _extractor_form_action()
        request = _make_request(query_string=b"Action=Publish")
        expected_operation = "publish"

        # Act
        actual_operation = extractor(request, b"")

        # Assert
        assert actual_operation == expected_operation
