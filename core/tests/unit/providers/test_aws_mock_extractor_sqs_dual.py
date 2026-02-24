"""Unit tests for _extractor_sqs_dual."""

from __future__ import annotations

from starlette.requests import Request

from lws.providers._shared.aws_operation_mock import _extractor_sqs_dual


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


class TestExtractorSqsDual:
    def test_json_target_send_message(self):
        # Arrange
        extractor = _extractor_sqs_dual()
        request = _make_request(
            headers=[(b"x-amz-target", b"AmazonSQS.SendMessage")],
        )
        expected_operation = "send-message"

        # Act
        actual_operation = extractor(request, b"")

        # Assert
        assert actual_operation == expected_operation

    def test_form_action_receive_message(self):
        # Arrange
        extractor = _extractor_sqs_dual()
        request = _make_request(
            headers=[(b"content-type", b"application/x-www-form-urlencoded")],
        )
        body = b"Action=ReceiveMessage"
        expected_operation = "receive-message"

        # Act
        actual_operation = extractor(request, body)

        # Assert
        assert actual_operation == expected_operation

    def test_neither_returns_none(self):
        # Arrange
        extractor = _extractor_sqs_dual()
        request = _make_request()

        # Act
        actual_operation = extractor(request, b"")

        # Assert
        assert actual_operation is None
