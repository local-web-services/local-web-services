"""Tests for API Gateway V1 Lambda proxy (AWS_PROXY) integration."""

from __future__ import annotations

import json
from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces import ICompute, InvocationResult
from lws.providers.apigateway.routes import create_apigateway_management_app
from lws.providers.lambda_runtime.routes import LambdaRegistry

_LAMBDA_URI = (
    "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/"
    "arn:aws:lambda:us-east-1:000000000000:function:my-func/invocations"
)


def _make_compute_fake(payload: dict | None = None) -> ICompute:
    fake = AsyncMock(spec=ICompute)
    fake.invoke.return_value = InvocationResult(
        payload=payload,
        error=None,
        duration_ms=1.0,
        request_id="req-id",
    )
    return fake


class TestV1LambdaProxy:
    """Test V1 REST API Lambda proxy integration (AWS_PROXY)."""

    @pytest.fixture
    def registry(self):
        return LambdaRegistry()

    @pytest.fixture
    def client(self, registry):
        app = create_apigateway_management_app(lambda_registry=registry)[0]
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://test")

    async def _setup_api(self, client, registry):
        """Create a REST API with a Lambda proxy integration and deploy it."""
        expected_payload = {"statusCode": 200, "body": json.dumps({"result": "ok"})}
        fake_compute = _make_compute_fake(payload=expected_payload)
        registry.register("my-func", {"FunctionName": "my-func"}, fake_compute)

        # Create REST API
        api_resp = await client.post("/restapis", json={"name": "my-api"})
        rest_api_id = api_resp.json()["id"]
        root_resource_id = api_resp.json()["rootResourceId"]

        # Create resource
        resource_resp = await client.post(
            f"/restapis/{rest_api_id}/resources/{root_resource_id}",
            json={"pathPart": "items"},
        )
        resource_id = resource_resp.json()["id"]

        # Create method
        await client.put(
            f"/restapis/{rest_api_id}/resources/{resource_id}/methods/GET",
            json={"authorizationType": "NONE"},
        )

        # Create integration
        await client.put(
            f"/restapis/{rest_api_id}/resources/{resource_id}/methods/GET/integration",
            json={"type": "AWS_PROXY", "httpMethod": "POST", "uri": _LAMBDA_URI},
        )

        # Create deployment and stage
        deployment_resp = await client.post(
            f"/restapis/{rest_api_id}/deployments", json={"description": "v1"}
        )
        deployment_id = deployment_resp.json()["id"]
        await client.post(
            f"/restapis/{rest_api_id}/stages",
            json={"stageName": "prod", "deploymentId": deployment_id},
        )

        return rest_api_id, fake_compute

    @pytest.mark.asyncio
    async def test_lambda_proxy_invokes_function(self, client, registry) -> None:
        # Arrange
        rest_api_id, fake_compute = await self._setup_api(client, registry)

        # Act
        resp = await client.get(f"/{rest_api_id}/prod/items")

        # Assert
        expected_status = 200
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert fake_compute.invoke.called, "Expected compute.invoke to have been called"

    @pytest.mark.asyncio
    async def test_lambda_proxy_event_has_v1_structure(self, client, registry) -> None:
        # Arrange
        rest_api_id, fake_compute = await self._setup_api(client, registry)

        # Act
        await client.get(f"/{rest_api_id}/prod/items?foo=bar")

        # Assert
        call_args = fake_compute.invoke.call_args
        actual_event = call_args[0][0]
        expected_version = "1.0"
        expected_http_method = "GET"
        assert (
            actual_event["version"] == expected_version
        ), f"Expected {expected_version!r} but got {actual_event['version']!r}"
        assert (
            actual_event["httpMethod"] == expected_http_method
        ), f"Expected {expected_http_method!r} but got {actual_event['httpMethod']!r}"
        assert "requestContext" in actual_event, "Expected 'requestContext' to be in event"

    @pytest.mark.asyncio
    async def test_lambda_proxy_returns_lambda_response_body(self, client, registry) -> None:
        # Arrange
        rest_api_id, _ = await self._setup_api(client, registry)

        # Act
        resp = await client.get(f"/{rest_api_id}/prod/items")

        # Assert
        expected_body_key = "result"
        actual_body = resp.json()
        assert (
            expected_body_key in actual_body
        ), f"Expected {expected_body_key!r} to be in {actual_body!r}"
