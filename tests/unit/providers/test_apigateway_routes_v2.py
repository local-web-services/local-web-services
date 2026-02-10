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
        app = create_apigateway_management_app(lambda_registry=registry)
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://test")

    @pytest.mark.asyncio
    async def test_create_api(self, client) -> None:
        resp = await client.post(
            "/v2/apis",
            json={"name": "my-http-api", "protocolType": "HTTP"},
        )
        assert resp.status_code == 201
        data = resp.json()
        assert data["name"] == "my-http-api"
        assert data["protocolType"] == "HTTP"
        assert "apiId" in data

    @pytest.mark.asyncio
    async def test_list_apis(self, client) -> None:
        await client.post("/v2/apis", json={"name": "api-1", "protocolType": "HTTP"})
        await client.post("/v2/apis", json={"name": "api-2", "protocolType": "HTTP"})

        resp = await client.get("/v2/apis")
        assert resp.status_code == 200
        assert len(resp.json()["items"]) == 2

    @pytest.mark.asyncio
    async def test_get_api(self, client) -> None:
        create_resp = await client.post("/v2/apis", json={"name": "my-api", "protocolType": "HTTP"})
        api_id = create_resp.json()["apiId"]

        resp = await client.get(f"/v2/apis/{api_id}")
        assert resp.status_code == 200
        assert resp.json()["name"] == "my-api"

    @pytest.mark.asyncio
    async def test_delete_api(self, client) -> None:
        create_resp = await client.post("/v2/apis", json={"name": "my-api", "protocolType": "HTTP"})
        api_id = create_resp.json()["apiId"]

        resp = await client.delete(f"/v2/apis/{api_id}")
        assert resp.status_code == 204

        get_resp = await client.get(f"/v2/apis/{api_id}")
        assert get_resp.status_code == 404

    @pytest.mark.asyncio
    async def test_create_integration(self, client) -> None:
        create_resp = await client.post("/v2/apis", json={"name": "my-api", "protocolType": "HTTP"})
        api_id = create_resp.json()["apiId"]

        resp = await client.post(
            f"/v2/apis/{api_id}/integrations",
            json={
                "integrationType": "AWS_PROXY",
                "integrationUri": "arn:aws:lambda:us-east-1:000:function:my-func",
                "payloadFormatVersion": "2.0",
            },
        )
        assert resp.status_code == 201
        data = resp.json()
        assert "integrationId" in data
        assert data["integrationType"] == "AWS_PROXY"

    @pytest.mark.asyncio
    async def test_create_route(self, client) -> None:
        create_resp = await client.post("/v2/apis", json={"name": "my-api", "protocolType": "HTTP"})
        api_id = create_resp.json()["apiId"]

        resp = await client.post(
            f"/v2/apis/{api_id}/routes",
            json={"routeKey": "POST /orders", "target": "integrations/abc123"},
        )
        assert resp.status_code == 201
        data = resp.json()
        assert data["routeKey"] == "POST /orders"

    @pytest.mark.asyncio
    async def test_create_stage(self, client) -> None:
        create_resp = await client.post("/v2/apis", json={"name": "my-api", "protocolType": "HTTP"})
        api_id = create_resp.json()["apiId"]

        resp = await client.post(
            f"/v2/apis/{api_id}/stages",
            json={"stageName": "$default"},
        )
        assert resp.status_code == 201
        assert resp.json()["stageName"] == "$default"

    @pytest.mark.asyncio
    async def test_v1_routes_still_work(self, client) -> None:
        """V1 REST API routes continue to work alongside V2."""
        resp = await client.post("/restapis", json={"name": "my-rest-api"})
        assert resp.status_code == 201
        assert resp.json()["name"] == "my-rest-api"
