"""Tests for API Gateway V2 CORS preflight and response headers."""

from __future__ import annotations

from unittest.mock import AsyncMock

import httpx
import pytest

from lws.interfaces import ICompute, InvocationResult
from lws.providers.apigateway.routes import (
    _build_cors_headers,
    create_apigateway_management_app,
)
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


# ---------------------------------------------------------------------------
# Tests
# ---------------------------------------------------------------------------


class TestV2Cors:
    """V2 CORS header builder, preflight responses, and proxy response headers."""

    def test_wildcard_origin(self) -> None:
        # Arrange
        cors = {"allowOrigins": ["*"]}
        expected_origin = "*"

        # Act
        headers = _build_cors_headers(cors, "http://example.com")

        # Assert
        actual_origin = headers["access-control-allow-origin"]
        assert actual_origin == expected_origin

    def test_specific_origin_match(self) -> None:
        # Arrange
        expected_origin = "http://example.com"
        cors = {"allowOrigins": [expected_origin]}

        # Act
        headers = _build_cors_headers(cors, expected_origin)

        # Assert
        actual_origin = headers["access-control-allow-origin"]
        assert actual_origin == expected_origin

    def test_specific_origin_no_match(self) -> None:
        # Arrange
        cors = {"allowOrigins": ["http://other.com"]}

        # Act
        headers = _build_cors_headers(cors, "http://example.com")

        # Assert
        assert "access-control-allow-origin" not in headers

    def test_allow_methods(self) -> None:
        # Arrange
        expected_methods = "GET,POST"
        cors = {"allowOrigins": ["*"], "allowMethods": ["GET", "POST"]}

        # Act
        headers = _build_cors_headers(cors, "*")

        # Assert
        actual_methods = headers["access-control-allow-methods"]
        assert actual_methods == expected_methods

    def test_allow_credentials(self) -> None:
        # Arrange
        expected_credentials = "true"
        cors = {"allowOrigins": ["http://example.com"], "allowCredentials": True}

        # Act
        headers = _build_cors_headers(cors, "http://example.com")

        # Assert
        actual_credentials = headers["access-control-allow-credentials"]
        assert actual_credentials == expected_credentials

    def test_max_age(self) -> None:
        # Arrange
        expected_max_age = "3600"
        cors = {"allowOrigins": ["*"], "maxAge": 3600}

        # Act
        headers = _build_cors_headers(cors, "*")

        # Assert
        actual_max_age = headers["access-control-max-age"]
        assert actual_max_age == expected_max_age

    @pytest.fixture
    def registry(self):
        return LambdaRegistry()

    @pytest.fixture
    def client(self, registry):
        app = create_apigateway_management_app(lambda_registry=registry)
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://test")

    @pytest.mark.asyncio
    async def test_options_returns_cors_headers(self, client, registry) -> None:
        # Arrange
        expected_origin = "*"
        expected_methods = "GET,POST"
        cors_config = {
            "allowOrigins": ["*"],
            "allowMethods": ["GET", "POST"],
            "allowHeaders": ["Content-Type"],
        }
        compute = _make_compute_mock({"statusCode": 200, "body": "{}"})
        registry.register("cors-func", {**_FUNC_CONFIG, "FunctionName": "cors-func"}, compute)

        await client.post(
            "/v2/apis",
            json={
                "name": "cors-api",
                "protocolType": "HTTP",
                "corsConfiguration": cors_config,
            },
        )
        api_resp = await client.get("/v2/apis")
        api_id = api_resp.json()["items"][0]["apiId"]
        int_resp = await client.post(
            f"/v2/apis/{api_id}/integrations",
            json={
                "integrationType": "AWS_PROXY",
                "integrationUri": "arn:aws:lambda:us-east-1:000:function:cors-func",
            },
        )
        integration_id = int_resp.json()["integrationId"]
        await client.post(
            f"/v2/apis/{api_id}/routes",
            json={
                "routeKey": "GET /items",
                "target": f"integrations/{integration_id}",
            },
        )

        # Act
        resp = await client.options("/items", headers={"origin": "http://example.com"})

        # Assert
        expected_status = 204
        assert resp.status_code == expected_status
        actual_origin = resp.headers.get("access-control-allow-origin")
        assert actual_origin == expected_origin
        actual_methods = resp.headers.get("access-control-allow-methods")
        assert actual_methods == expected_methods

    @pytest.mark.asyncio
    async def test_proxy_response_includes_cors(self, client, registry) -> None:
        # Arrange
        expected_origin = "*"
        cors_config = {"allowOrigins": ["*"], "allowMethods": ["GET"]}
        compute = _make_compute_mock({"statusCode": 200, "body": '{"data": 1}'})
        registry.register(
            "cors-resp-func", {**_FUNC_CONFIG, "FunctionName": "cors-resp-func"}, compute
        )

        api_resp = await client.post(
            "/v2/apis",
            json={
                "name": "cors-resp-api",
                "protocolType": "HTTP",
                "corsConfiguration": cors_config,
            },
        )
        api_id = api_resp.json()["apiId"]
        int_resp = await client.post(
            f"/v2/apis/{api_id}/integrations",
            json={
                "integrationType": "AWS_PROXY",
                "integrationUri": "arn:aws:lambda:us-east-1:000:function:cors-resp-func",
            },
        )
        integration_id = int_resp.json()["integrationId"]
        await client.post(
            f"/v2/apis/{api_id}/routes",
            json={
                "routeKey": "GET /data",
                "target": f"integrations/{integration_id}",
            },
        )

        # Act
        resp = await client.get("/data", headers={"origin": "http://example.com"})

        # Assert
        expected_status = 200
        assert resp.status_code == expected_status
        actual_origin = resp.headers.get("access-control-allow-origin")
        assert actual_origin == expected_origin
