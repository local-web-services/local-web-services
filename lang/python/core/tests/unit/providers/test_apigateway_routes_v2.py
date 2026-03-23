"""Tests for API Gateway V2 (HTTP API) management routes."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.apigateway.routes import create_apigateway_management_app
from lws.providers.lambda_runtime.routes import LambdaRegistry


class TestApiGatewayV2Routes:
    """Test API Gateway V2 management routes."""

    @pytest.fixture
    def registry(self):
        return LambdaRegistry()

    @pytest.fixture
    def client(self, registry):
        app = create_apigateway_management_app(lambda_registry=registry)[0]
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://test")

    @pytest.mark.asyncio
    async def test_create_api(self, client) -> None:
        expected_name = "my-http-api"
        expected_protocol = "HTTP"
        resp = await client.post(
            "/v2/apis",
            json={"name": expected_name, "protocolType": expected_protocol},
        )

        # Assert
        expected_status = 201
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        data = resp.json()
        assert data["name"] == expected_name, f'Expected {expected_name!r} but got {data["name"]!r}'
        assert (
            data["protocolType"] == expected_protocol
        ), f'Expected {expected_protocol!r} but got {data["protocolType"]!r}'
        assert "apiId" in data, f'Expected {"apiId"!r} to be in {data!r}'

    @pytest.mark.asyncio
    async def test_list_apis(self, client) -> None:
        await client.post("/v2/apis", json={"name": "api-1", "protocolType": "HTTP"})
        await client.post("/v2/apis", json={"name": "api-2", "protocolType": "HTTP"})

        resp = await client.get("/v2/apis")

        # Assert
        expected_status = 200
        expected_count = 2
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert (
            len(resp.json()["items"]) == expected_count
        ), f'Expected {expected_count!r} but got {len(resp.json()["items"])!r}'

    @pytest.mark.asyncio
    async def test_get_api(self, client) -> None:
        api_name = "my-api"
        create_resp = await client.post("/v2/apis", json={"name": api_name, "protocolType": "HTTP"})
        api_id = create_resp.json()["apiId"]

        resp = await client.get(f"/v2/apis/{api_id}")

        # Assert
        expected_status = 200
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert (
            resp.json()["name"] == api_name
        ), f'Expected {api_name!r} but got {resp.json()["name"]!r}'

    @pytest.mark.asyncio
    async def test_delete_api(self, client) -> None:
        create_resp = await client.post("/v2/apis", json={"name": "my-api", "protocolType": "HTTP"})
        api_id = create_resp.json()["apiId"]

        resp = await client.delete(f"/v2/apis/{api_id}")

        # Assert
        expected_delete_status = 204
        expected_not_found_status = 404
        assert (
            resp.status_code == expected_delete_status
        ), f"Expected {expected_delete_status!r} but got {resp.status_code!r}"

        get_resp = await client.get(f"/v2/apis/{api_id}")
        assert (
            get_resp.status_code == expected_not_found_status
        ), f"Expected {expected_not_found_status!r} but got {get_resp.status_code!r}"

    @pytest.mark.asyncio
    async def test_create_integration(self, client) -> None:
        create_resp = await client.post("/v2/apis", json={"name": "my-api", "protocolType": "HTTP"})
        api_id = create_resp.json()["apiId"]

        expected_integration_type = "AWS_PROXY"
        resp = await client.post(
            f"/v2/apis/{api_id}/integrations",
            json={
                "integrationType": expected_integration_type,
                "integrationUri": "arn:aws:lambda:us-east-1:000:function:my-func",
                "payloadFormatVersion": "2.0",
            },
        )

        # Assert
        expected_status = 201
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        data = resp.json()
        assert "integrationId" in data, f'Expected {"integrationId"!r} to be in {data!r}'
        assert (
            data["integrationType"] == expected_integration_type
        ), f'Expected {expected_integration_type!r} but got {data["integrationType"]!r}'

    @pytest.mark.asyncio
    async def test_create_route(self, client) -> None:
        create_resp = await client.post("/v2/apis", json={"name": "my-api", "protocolType": "HTTP"})
        api_id = create_resp.json()["apiId"]

        expected_route_key = "POST /orders"
        resp = await client.post(
            f"/v2/apis/{api_id}/routes",
            json={"routeKey": expected_route_key, "target": "integrations/abc123"},
        )

        # Assert
        expected_status = 201
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        data = resp.json()
        assert (
            data["routeKey"] == expected_route_key
        ), f'Expected {expected_route_key!r} but got {data["routeKey"]!r}'

    @pytest.mark.asyncio
    async def test_create_stage(self, client) -> None:
        create_resp = await client.post("/v2/apis", json={"name": "my-api", "protocolType": "HTTP"})
        api_id = create_resp.json()["apiId"]

        expected_stage_name = "$default"
        resp = await client.post(
            f"/v2/apis/{api_id}/stages",
            json={"stageName": expected_stage_name},
        )

        # Assert
        expected_status = 201
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert (
            resp.json()["stageName"] == expected_stage_name
        ), f'Expected {expected_stage_name!r} but got {resp.json()["stageName"]!r}'

    @pytest.mark.asyncio
    async def test_v1_routes_still_work(self, client) -> None:
        """V1 REST API routes continue to work alongside V2."""
        expected_name = "my-rest-api"
        resp = await client.post("/restapis", json={"name": expected_name})

        # Assert
        expected_status = 201
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert (
            resp.json()["name"] == expected_name
        ), f'Expected {expected_name!r} but got {resp.json()["name"]!r}'
