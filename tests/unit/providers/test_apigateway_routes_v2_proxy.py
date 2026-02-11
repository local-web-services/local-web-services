"""Tests for API Gateway V2 proxy invocation through Lambda."""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces import ICompute, InvocationResult
from lws.providers.apigateway.routes import create_apigateway_management_app
from lws.providers.lambda_runtime.routes import LambdaRegistry


def _make_compute_mock(payload: dict | None = None) -> ICompute:
    """Return a mock ICompute whose invoke resolves to the given result."""
    mock = AsyncMock(spec=ICompute)
    mock.invoke.return_value = InvocationResult(
        payload=payload,
        error=None,
        duration_ms=1.0,
        request_id="test-request-id",
    )
    return mock


class TestApiGatewayV2Proxy:
    """Test API Gateway V2 proxy invocation."""

    @pytest.fixture
    def registry(self):
        return LambdaRegistry()

    @pytest.fixture
    def client(self, registry):
        app = create_apigateway_management_app(lambda_registry=registry)
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://test")

    @pytest.mark.asyncio
    async def test_proxy_invokes_lambda(self, client, registry) -> None:
        """Proxy request through V2 route to Lambda and return response."""
        mock_compute = _make_compute_mock(payload={"statusCode": 200, "body": '{"orderId": "123"}'})
        registry.register("create-order", {"FunctionName": "create-order"}, mock_compute)

        # Create V2 API, integration, and route
        api_resp = await client.post(
            "/v2/apis", json={"name": "orders-api", "protocolType": "HTTP"}
        )
        api_id = api_resp.json()["apiId"]

        int_resp = await client.post(
            f"/v2/apis/{api_id}/integrations",
            json={
                "integrationType": "AWS_PROXY",
                "integrationUri": ("arn:aws:lambda:us-east-1:000:function:create-order"),
            },
        )
        integration_id = int_resp.json()["integrationId"]

        await client.post(
            f"/v2/apis/{api_id}/routes",
            json={
                "routeKey": "POST /orders",
                "target": f"integrations/{integration_id}",
            },
        )

        # Proxy request
        resp = await client.post("/orders", json={"item": "widget"})

        # Assert
        expected_status = 200
        expected_version = "2.0"
        expected_route_key = "POST /orders"
        expected_raw_path = "/orders"
        assert resp.status_code == expected_status
        assert '{"orderId": "123"}' in resp.text

        # Verify Lambda was invoked with V2 event format
        call_args = mock_compute.invoke.call_args
        event = call_args[0][0]
        assert event["version"] == expected_version
        assert event["routeKey"] == expected_route_key
        assert event["rawPath"] == expected_raw_path

    @pytest.mark.asyncio
    async def test_proxy_with_path_variables(self, client, registry) -> None:
        """Route with path variable {id} matches concrete paths."""
        mock_compute = _make_compute_mock(payload={"statusCode": 200, "body": '{"orderId": "abc"}'})
        registry.register("get-order", {"FunctionName": "get-order"}, mock_compute)

        api_resp = await client.post(
            "/v2/apis", json={"name": "orders-api", "protocolType": "HTTP"}
        )
        api_id = api_resp.json()["apiId"]

        int_resp = await client.post(
            f"/v2/apis/{api_id}/integrations",
            json={
                "integrationType": "AWS_PROXY",
                "integrationUri": "arn:aws:lambda:us-east-1:000:function:get-order",
            },
        )
        integration_id = int_resp.json()["integrationId"]

        await client.post(
            f"/v2/apis/{api_id}/routes",
            json={
                "routeKey": "GET /orders/{id}",
                "target": f"integrations/{integration_id}",
            },
        )

        resp = await client.get("/orders/abc123")

        # Assert
        expected_status = 200
        assert resp.status_code == expected_status
        assert "abc" in resp.text

    @pytest.mark.asyncio
    async def test_proxy_with_invoke_arn_uri(self, client, registry) -> None:
        """Integration URI in invoke_arn format resolves to correct function."""
        mock_compute = _make_compute_mock(payload={"statusCode": 200, "body": '{"ok": true}'})
        registry.register("my-func", {"FunctionName": "my-func"}, mock_compute)

        api_resp = await client.post("/v2/apis", json={"name": "test-api", "protocolType": "HTTP"})
        api_id = api_resp.json()["apiId"]

        invoke_arn = (
            "arn:aws:apigateway:us-east-1:lambda:path"
            "/2015-03-31/functions"
            "/arn:aws:lambda:us-east-1:000000000000:function:my-func"
            "/invocations"
        )
        int_resp = await client.post(
            f"/v2/apis/{api_id}/integrations",
            json={"integrationType": "AWS_PROXY", "integrationUri": invoke_arn},
        )
        integration_id = int_resp.json()["integrationId"]

        await client.post(
            f"/v2/apis/{api_id}/routes",
            json={
                "routeKey": "POST /test",
                "target": f"integrations/{integration_id}",
            },
        )

        resp = await client.post("/test", json={})

        # Assert
        expected_status = 200
        assert resp.status_code == expected_status
        assert resp.json().get("ok") is True

    @pytest.mark.asyncio
    async def test_unmatched_path_returns_not_found(self, client) -> None:
        """Unmatched paths return 404 Not Found."""
        resp = await client.get("/nonexistent")

        # Assert
        expected_status = 404
        assert resp.status_code == expected_status
        body = resp.json()
        assert "lws" in body["message"]
        assert "API Gateway" in body["message"]
