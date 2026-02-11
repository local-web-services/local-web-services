"""Tests for API Gateway V2 proxy: full Terraform-like flow.

Simulates the exact sequence Terraform performs:
1. Create Lambda function via the Lambda management API
2. Create V2 API, integration (using invoke_arn), route, stage via
   the API Gateway management API
3. Send a proxy request to the route
4. Verify the Lambda function is invoked and the response is correct

This catches regressions where:
- The V2 management endpoints don't store state correctly
- The proxy catch-all fails to match registered routes
- The integration URI (invoke_arn format) doesn't resolve to the function
"""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces import ICompute, InvocationResult
from lws.providers.apigateway.routes import create_apigateway_management_app
from lws.providers.lambda_runtime.routes import LambdaRegistry


def _make_compute_mock(payload: dict | None = None) -> ICompute:
    mock = AsyncMock(spec=ICompute)
    mock.invoke.return_value = InvocationResult(
        payload=payload, error=None, duration_ms=1.0, request_id="req-1"
    )
    return mock


class TestApiGatewayV2TerraformFlow:
    """Simulate the full Terraform apply → test-invoke-method flow."""

    @pytest.fixture
    def registry(self):
        return LambdaRegistry()

    @pytest.fixture
    def client(self, registry):
        app = create_apigateway_management_app(lambda_registry=registry)
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://test")

    @pytest.mark.asyncio
    async def test_terraform_creates_v2_api_and_proxy_invokes_lambda(
        self, client, registry
    ) -> None:
        """Full flow: create V2 resources then proxy POST /orders to Lambda.

        This is the exact scenario from sample-project-terraform.
        Terraform creates CreateOrderFunction, then an HTTP API with a
        POST /orders route pointing to the Lambda via invoke_arn.
        """
        # 1. Simulate Terraform creating the Lambda function.
        #    In production, Terraform calls the Lambda management API on
        #    port+9; here we register the compute mock directly (the
        #    Lambda management API is tested separately).
        mock_compute = _make_compute_mock(
            payload={
                "statusCode": 200,
                "body": '{"orderId": "order-001"}',
                "headers": {"Content-Type": "application/json"},
            }
        )
        registry.register(
            "CreateOrderFunction",
            {"FunctionName": "CreateOrderFunction"},
            mock_compute,
        )

        # 2. Terraform creates the V2 HTTP API
        api_resp = await client.post(
            "/v2/apis",
            json={"name": "orders-http-api", "protocolType": "HTTP"},
        )
        expected_create_status = 201
        assert api_resp.status_code == expected_create_status
        api_id = api_resp.json()["apiId"]

        # 3. Terraform creates the integration with invoke_arn format
        invoke_arn = (
            "arn:aws:apigateway:us-east-1:lambda:path"
            "/2015-03-31/functions"
            "/arn:aws:lambda:us-east-1:000000000000:function:CreateOrderFunction"
            "/invocations"
        )
        int_resp = await client.post(
            f"/v2/apis/{api_id}/integrations",
            json={
                "integrationType": "AWS_PROXY",
                "integrationUri": invoke_arn,
                "payloadFormatVersion": "2.0",
            },
        )
        assert int_resp.status_code == expected_create_status
        integration_id = int_resp.json()["integrationId"]

        # 4. Terraform creates the route
        route_resp = await client.post(
            f"/v2/apis/{api_id}/routes",
            json={
                "routeKey": "POST /orders",
                "target": f"integrations/{integration_id}",
            },
        )
        assert route_resp.status_code == expected_create_status

        # 5. Terraform creates the stage
        stage_resp = await client.post(
            f"/v2/apis/{api_id}/stages",
            json={"stageName": "$default", "autoDeploy": True},
        )
        assert stage_resp.status_code == expected_create_status

        # 6. Now simulate: lws apigateway test-invoke-method --resource /orders --http-method POST
        #    This sends POST /orders to the API Gateway management port.
        resp = await client.post("/orders", json={"item": "widget", "quantity": 1})

        # Assert
        expected_proxy_status = 200
        expected_version = "2.0"
        expected_route_key = "POST /orders"
        expected_raw_path = "/orders"
        expected_method = "POST"
        assert resp.status_code == expected_proxy_status
        assert "order-001" in resp.text

        # Verify Lambda was actually invoked
        mock_compute.invoke.assert_called_once()
        event = mock_compute.invoke.call_args[0][0]
        assert event["version"] == expected_version
        assert event["routeKey"] == expected_route_key
        assert event["rawPath"] == expected_raw_path
        assert event["requestContext"]["http"]["method"] == expected_method

    @pytest.mark.asyncio
    async def test_terraform_creates_get_route_with_path_param(self, client, registry) -> None:
        """Terraform creates GET /orders/{id} route and proxy resolves it."""
        mock_compute = _make_compute_mock(
            payload={
                "statusCode": 200,
                "body": '{"orderId": "abc-123", "status": "completed"}',
            }
        )
        registry.register(
            "GetOrderFunction",
            {"FunctionName": "GetOrderFunction"},
            mock_compute,
        )

        api_resp = await client.post(
            "/v2/apis",
            json={"name": "orders-api", "protocolType": "HTTP"},
        )
        api_id = api_resp.json()["apiId"]

        invoke_arn = (
            "arn:aws:apigateway:us-east-1:lambda:path"
            "/2015-03-31/functions"
            "/arn:aws:lambda:us-east-1:000000000000:function:GetOrderFunction"
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
                "routeKey": "GET /orders/{id}",
                "target": f"integrations/{integration_id}",
            },
        )

        resp = await client.get("/orders/abc-123")

        # Assert
        expected_status = 200
        assert resp.status_code == expected_status
        assert "abc-123" in resp.text
        mock_compute.invoke.assert_called_once()

    @pytest.mark.asyncio
    async def test_no_v2_routes_returns_not_found(self, client) -> None:
        """When no V2 routes exist, proxy falls through to 404."""
        resp = await client.post("/orders", json={"item": "widget"})

        # Assert
        expected_status = 404
        assert resp.status_code == expected_status
        body = resp.json()
        assert "lws" in body["message"]
        assert "API Gateway" in body["message"]

    @pytest.mark.asyncio
    async def test_v2_route_wrong_method_returns_stub(self, client, registry) -> None:
        """POST /orders route does not match GET /orders."""
        mock_compute = _make_compute_mock(payload={"statusCode": 200, "body": "{}"})
        registry.register("fn", {"FunctionName": "fn"}, mock_compute)

        api_resp = await client.post("/v2/apis", json={"name": "api", "protocolType": "HTTP"})
        api_id = api_resp.json()["apiId"]

        int_resp = await client.post(
            f"/v2/apis/{api_id}/integrations",
            json={
                "integrationType": "AWS_PROXY",
                "integrationUri": "arn:aws:lambda:us-east-1:000:function:fn",
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

        # Assert - GET should NOT match the POST route
        resp = await client.get("/orders")
        expected_status = 404
        assert resp.status_code == expected_status
        body = resp.json()
        assert "lws" in body["message"]
        assert "API Gateway" in body["message"]
        mock_compute.invoke.assert_not_called()
