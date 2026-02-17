"""Tests for API Gateway V2 multi-value headers, query params, and cookies."""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces import ICompute, InvocationResult
from lws.providers.apigateway.routes import create_apigateway_management_app
from lws.providers.lambda_runtime.routes import LambdaRegistry

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

_FUNC_CONFIG = {"FunctionName": "test", "Runtime": "python3.11", "Handler": "index.handler"}


def _make_compute_mock(payload: dict | None = None, error: str | None = None) -> ICompute:
    mock = AsyncMock(spec=ICompute)
    mock.invoke.return_value = InvocationResult(
        payload=payload, error=error, duration_ms=1.0, request_id="test-req"
    )
    return mock


async def _setup_v2_api_with_lambda(client, registry, function_name="my-func"):
    """Create a V2 API with an integration and $default route."""
    compute = _make_compute_mock({"statusCode": 200, "body": '{"ok": true}'})
    registry.register(function_name, {**_FUNC_CONFIG, "FunctionName": function_name}, compute)

    api_resp = await client.post("/v2/apis", json={"name": "test-api", "protocolType": "HTTP"})
    api_id = api_resp.json()["apiId"]

    int_resp = await client.post(
        f"/v2/apis/{api_id}/integrations",
        json={
            "integrationType": "AWS_PROXY",
            "integrationUri": f"arn:aws:lambda:us-east-1:000:function:{function_name}",
            "payloadFormatVersion": "2.0",
        },
    )
    integration_id = int_resp.json()["integrationId"]

    await client.post(
        f"/v2/apis/{api_id}/routes",
        json={"routeKey": "$default", "target": f"integrations/{integration_id}"},
    )

    return api_id, compute


# ---------------------------------------------------------------------------
# Tests
# ---------------------------------------------------------------------------


class TestV2MultiValue:
    """V2 comma-joined headers, query params, and cookies."""

    @pytest.fixture
    def registry(self):
        return LambdaRegistry()

    @pytest.fixture
    def client(self, registry):
        app = create_apigateway_management_app(lambda_registry=registry)
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://test")

    @pytest.mark.asyncio
    async def test_single_header_value(self, client, registry) -> None:
        # Arrange
        expected_key = "x-custom"
        expected_value = "val1"
        _, compute = await _setup_v2_api_with_lambda(client, registry)

        # Act
        await client.get("/test", headers={expected_key: expected_value})

        # Assert
        event = compute.invoke.call_args[0][0]
        actual_value = event["headers"][expected_key]
        assert actual_value == expected_value

    @pytest.mark.asyncio
    async def test_single_query_param(self, client, registry) -> None:
        # Arrange
        expected_key = "color"
        expected_value = "red"
        _, compute = await _setup_v2_api_with_lambda(client, registry)

        # Act
        await client.get(f"/test?{expected_key}={expected_value}")

        # Assert
        event = compute.invoke.call_args[0][0]
        actual_value = event["queryStringParameters"][expected_key]
        assert actual_value == expected_value

    @pytest.mark.asyncio
    async def test_repeated_query_param_comma_joined(self, client, registry) -> None:
        # Arrange
        expected_key = "color"
        expected_value = "red,blue"
        _, compute = await _setup_v2_api_with_lambda(client, registry)

        # Act
        await client.get("/test?color=red&color=blue")

        # Assert
        event = compute.invoke.call_args[0][0]
        actual_value = event["queryStringParameters"][expected_key]
        assert actual_value == expected_value

    @pytest.mark.asyncio
    async def test_cookies_become_set_cookie_headers(self, client, registry) -> None:
        # Arrange
        expected_cookie = "session=abc123; Path=/"
        compute = _make_compute_mock(
            {"statusCode": 200, "body": "{}", "cookies": [expected_cookie]}
        )
        registry.register("cookie-func", {**_FUNC_CONFIG, "FunctionName": "cookie-func"}, compute)

        api_resp = await client.post(
            "/v2/apis", json={"name": "cookie-api", "protocolType": "HTTP"}
        )
        api_id = api_resp.json()["apiId"]
        int_resp = await client.post(
            f"/v2/apis/{api_id}/integrations",
            json={
                "integrationType": "AWS_PROXY",
                "integrationUri": "arn:aws:lambda:us-east-1:000:function:cookie-func",
                "payloadFormatVersion": "2.0",
            },
        )
        integration_id = int_resp.json()["integrationId"]
        await client.post(
            f"/v2/apis/{api_id}/routes",
            json={
                "routeKey": "$default",
                "target": f"integrations/{integration_id}",
            },
        )

        # Act
        resp = await client.get("/test-cookie")

        # Assert
        actual_cookies = resp.headers.get_list("set-cookie")
        assert expected_cookie in actual_cookies
