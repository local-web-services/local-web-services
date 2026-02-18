"""Unit tests for _extractor_json_target DynamoDB."""

from __future__ import annotations

from starlette.requests import Request

from lws.providers._shared.aws_operation_mock import _extractor_json_target


def _make_request(
    headers: list[tuple[bytes, bytes]],
    method: str = "POST",
    path: str = "/",
) -> Request:
    """Create a minimal Starlette Request from a scope dict."""
    scope = {
        "type": "http",
        "method": method,
        "path": path,
        "headers": headers,
        "query_string": b"",
    }
    return Request(scope)


class TestExtractorJsonTargetDynamoDB:
    def test_dynamodb_get_item(self):
        # Arrange
        extractor = _extractor_json_target("DynamoDB_20120810.")
        request = _make_request(
            headers=[(b"x-amz-target", b"DynamoDB_20120810.GetItem")],
        )
        expected_operation = "get-item"

        # Act
        actual_operation = extractor(request, b"")

        # Assert
        assert actual_operation == expected_operation
