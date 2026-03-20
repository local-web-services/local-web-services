"""Tests for API Gateway V2 proxy invocation through Lambda."""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces import ICompute, InvocationResult
from lws.providers.apigateway.routes import create_apigateway_management_app
from lws.providers.lambda_runtime.routes import LambdaRegistry


def _make_compute_fake(payload: dict | None = None) -> ICompute:
    """Return a fake ICompute whose invoke resolves to the given result."""
    fake = AsyncMock(spec=ICompute)
    fake.invoke.return_value = InvocationResult(
        payload=payload,
        error=None,
        duration_ms=1.0,
        request_id="test-request-id",
    )
    return fake


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
        fake_compute = _make_compute_fake(payload={"statusCode": 200, "body": '{"orderId": "123"}'})
        registry.register("create-order", {"FunctionName": "create-order"}, fake_compute)

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
        assert resp.status_code == expected_status, f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert '{"orderId": "123"}' in resp.text, "Expected {0!r} to be in {1!r}".format('{"orderId": "123"}', resp.text)

        # Verify Lambda was invoked with V2 event format
        call_args = fake_compute.invoke.call_args
        event = call_args[0][0]
        assert event["version"] == expected_version, f'Expected {expected_version!r} but got {event["version"]!r}'
        assert event["routeKey"] == expected_route_key, f'Expected {expected_route_key!r} but got {event["routeKey"]!r}'
        assert event["rawPath"] == expected_raw_path, f'Expected {expected_raw_path!r} but got {event["rawPath"]!r}'

    @pytest.mark.asyncio
    async def test_proxy_with_path_variables(self, client, registry) -> None:
        """Route with path variable {id} matches concrete paths."""
        fake_compute = _make_compute_fake(payload={"statusCode": 200, "body": '{"orderId": "abc"}'})
        registry.register("get-order", {"FunctionName": "get-order"}, fake_compute)

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
        assert resp.status_code == expected_status, f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert "abc" in resp.text, f'Expected {"abc"!r} to be in {resp.text!r}'

    @pytest.mark.asyncio
    async def test_proxy_with_invoke_arn_uri(self, client, registry) -> None:
        """Integration URI in invoke_arn format resolves to correct function."""
        fake_compute = _make_compute_fake(payload={"statusCode": 200, "body": '{"ok": true}'})
        registry.register("my-func", {"FunctionName": "my-func"}, fake_compute)

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
        assert resp.status_code == expected_status, f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert resp.json().get("ok") is True, "Expected value to be truthy"

    @pytest.mark.asyncio
    async def test_unmatched_path_returns_not_found(self, client) -> None:
        """Unmatched paths return 404 Not Found."""
        resp = await client.get("/nonexistent")

        # Assert
        expected_status = 404
        assert resp.status_code == expected_status, f"Expected {expected_status!r} but got {resp.status_code!r}"
        body = resp.json()
        assert "lws" in body["message"], f'Expected {"lws"!r} to be in {body["message"]!r}'
        assert "API Gateway" in body["message"], f'Expected {"API Gateway"!r} to be in {body["message"]!r}'
