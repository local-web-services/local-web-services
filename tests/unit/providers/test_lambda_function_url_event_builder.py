"""Tests for Lambda Function URL event builder (payload format 2.0)."""

from __future__ import annotations

from unittest.mock import MagicMock

from lws.providers.lambda_function_url.routes import build_function_url_event


def _make_request(
    method: str = "GET",
    path: str = "/",
    query_string: str = "",
    headers: dict | None = None,
    body: bytes = b"",
    client_host: str = "127.0.0.1",
) -> MagicMock:
    """Create a mock Starlette Request."""
    request = MagicMock()
    request.method = method
    request.url.path = path
    request.scope = {"http_version": "1.1"}

    # Headers
    header_items = list((headers or {}).items())
    request.headers = MagicMock()
    request.headers.items.return_value = header_items
    request.headers.get = lambda key, default="": dict(header_items).get(key.lower(), default)
    request.headers.__iter__ = lambda self: iter(dict(header_items))

    # Query params
    if query_string:
        from urllib.parse import parse_qs

        params = {k: v[0] for k, v in parse_qs(query_string).items()}
        request.query_params = params
    else:
        request.query_params = {}

    # Client
    client = MagicMock()
    client.host = client_host
    request.client = client

    return request


class TestBuildFunctionUrlEvent:
    def test_basic_get_request(self):
        # Arrange
        request = _make_request(method="GET", path="/hello")

        # Act
        event = build_function_url_event(request, b"")

        # Assert
        expected_version = "2.0"
        expected_route_key = "$default"
        expected_path = "/hello"
        expected_method = "GET"
        actual_version = event["version"]
        actual_route_key = event["routeKey"]
        actual_path = event["rawPath"]
        actual_method = event["requestContext"]["http"]["method"]
        assert actual_version == expected_version
        assert actual_route_key == expected_route_key
        assert actual_path == expected_path
        assert actual_method == expected_method
        assert event["isBase64Encoded"] is False

    def test_post_with_body(self):
        # Arrange
        expected_body = '{"key": "value"}'
        request = _make_request(method="POST", path="/data")

        # Act
        event = build_function_url_event(request, expected_body.encode())

        # Assert
        actual_body = event["body"]
        assert actual_body == expected_body
        assert event["isBase64Encoded"] is False

    def test_binary_body_base64(self):
        # Arrange
        binary_data = bytes(range(256))
        request = _make_request(method="POST", path="/upload")

        # Act
        event = build_function_url_event(request, binary_data)

        # Assert
        assert event["isBase64Encoded"] is True
        assert "body" in event

    def test_query_string_parameters(self):
        # Arrange
        expected_key = "value"
        request = _make_request(path="/search", query_string="key=value")

        # Act
        event = build_function_url_event(request, b"")

        # Assert
        actual_key = event["queryStringParameters"]["key"]
        assert actual_key == expected_key

    def test_headers_lowercased(self):
        # Arrange
        expected_content_type = "application/json"
        request = _make_request(headers={"content-type": expected_content_type})

        # Act
        event = build_function_url_event(request, b"")

        # Assert
        actual_content_type = event["headers"]["content-type"]
        assert actual_content_type == expected_content_type

    def test_request_context_fields(self):
        # Arrange
        request = _make_request(
            method="PUT",
            path="/items/123",
            client_host="192.168.1.1",
            headers={"user-agent": "test-agent"},
        )

        # Act
        event = build_function_url_event(request, b"")

        # Assert
        ctx = event["requestContext"]
        expected_account_id = "000000000000"
        expected_source_ip = "192.168.1.1"
        expected_user_agent = "test-agent"
        actual_account_id = ctx["accountId"]
        actual_source_ip = ctx["http"]["sourceIp"]
        actual_user_agent = ctx["http"]["userAgent"]
        assert actual_account_id == expected_account_id
        assert actual_source_ip == expected_source_ip
        assert actual_user_agent == expected_user_agent
        assert "requestId" in ctx
        assert "timeEpoch" in ctx

    def test_no_body_key_when_empty(self):
        # Arrange
        request = _make_request(method="GET", path="/")

        # Act
        event = build_function_url_event(request, b"")

        # Assert
        assert "body" not in event

    def test_no_query_params_key_when_empty(self):
        # Arrange
        request = _make_request(method="GET", path="/")

        # Act
        event = build_function_url_event(request, b"")

        # Assert
        assert "queryStringParameters" not in event
