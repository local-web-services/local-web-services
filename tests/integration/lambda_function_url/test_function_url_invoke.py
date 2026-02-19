"""Integration test for Lambda Function URL invoke."""

from __future__ import annotations

import httpx


class TestFunctionUrlInvoke:
    async def test_get_request_returns_lambda_response(
        self, client: httpx.AsyncClient, mock_compute
    ):
        # Arrange
        expected_status = 200
        expected_body = "Hello from Lambda!"
        mock_compute._response = {"statusCode": expected_status, "body": expected_body}

        # Act
        resp = await client.get("/hello")

        # Assert
        actual_status = resp.status_code
        assert actual_status == expected_status
        actual_body = resp.text
        assert actual_body == expected_body

    async def test_post_request_passes_body_to_lambda(
        self, client: httpx.AsyncClient, mock_compute
    ):
        # Arrange
        expected_body = '{"key": "value"}'
        mock_compute._response = {"statusCode": 200, "body": "ok"}

        # Act
        await client.post("/data", content=expected_body)

        # Assert
        actual_event = mock_compute.last_event
        actual_body = actual_event["body"]
        assert actual_body == expected_body

    async def test_event_has_v2_format(self, client: httpx.AsyncClient, mock_compute):
        # Arrange
        mock_compute._response = {"statusCode": 200, "body": "ok"}

        # Act
        await client.get("/test-path?key=val")

        # Assert
        event = mock_compute.last_event
        expected_version = "2.0"
        expected_route_key = "$default"
        expected_path = "/test-path"
        actual_version = event["version"]
        actual_route_key = event["routeKey"]
        actual_path = event["rawPath"]
        assert actual_version == expected_version
        assert actual_route_key == expected_route_key
        assert actual_path == expected_path
        assert "key" in event.get("queryStringParameters", {})

    async def test_lambda_error_returns_502(self, client: httpx.AsyncClient, mock_compute):
        # Arrange
        mock_compute._error = "Runtime.ImportModuleError"
        mock_compute._response = None

        # Act
        resp = await client.get("/")

        # Assert
        expected_status = 502
        actual_status = resp.status_code
        assert actual_status == expected_status

    async def test_lambda_response_with_headers(self, client: httpx.AsyncClient, mock_compute):
        # Arrange
        expected_header_value = "custom-value"
        mock_compute._response = {
            "statusCode": 200,
            "headers": {"x-custom": expected_header_value},
            "body": "ok",
        }

        # Act
        resp = await client.get("/")

        # Assert
        actual_header = resp.headers.get("x-custom")
        assert actual_header == expected_header_value

    async def test_lambda_response_with_cookies(self, client: httpx.AsyncClient, mock_compute):
        # Arrange
        expected_cookie = "session=abc; Path=/"
        mock_compute._response = {
            "statusCode": 200,
            "body": "ok",
            "cookies": [expected_cookie],
        }

        # Act
        resp = await client.get("/")

        # Assert
        actual_cookies = resp.headers.get_list("set-cookie")
        assert expected_cookie in actual_cookies

    async def test_root_path(self, client: httpx.AsyncClient, mock_compute):
        # Arrange
        mock_compute._response = {"statusCode": 200, "body": "root"}

        # Act
        resp = await client.get("/")

        # Assert
        expected_status = 200
        actual_status = resp.status_code
        assert actual_status == expected_status

    async def test_multiple_methods_supported(self, client: httpx.AsyncClient, mock_compute):
        # Arrange
        mock_compute._response = {"statusCode": 200, "body": "ok"}

        # Act
        methods = ["GET", "POST", "PUT", "PATCH", "DELETE"]
        for method in methods:
            await client.request(method, "/test")

            # Assert
            expected_method = method
            actual_method = mock_compute.last_event["requestContext"]["http"]["method"]
            assert actual_method == expected_method
