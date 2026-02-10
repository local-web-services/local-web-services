"""Tests for API Gateway management routes (Terraform wire protocol)."""

from __future__ import annotations

import httpx
import pytest
from httpx import ASGITransport

from lws.providers.apigateway.routes import create_apigateway_management_app


class TestApiGatewayManagementRoutes:
    @pytest.fixture
    async def client(self):
        app = create_apigateway_management_app()
        transport = ASGITransport(app=app)
        async with httpx.AsyncClient(transport=transport, base_url="http://test") as c:
            yield c

    @pytest.mark.asyncio
    async def test_create_rest_api(self, client: httpx.AsyncClient) -> None:
        resp = await client.post("/restapis", json={"name": "my-api", "description": "test"})

        assert resp.status_code == 201
        data = resp.json()
        assert data["name"] == "my-api"
        assert data["description"] == "test"
        assert "id" in data
        assert "rootResourceId" in data

    @pytest.mark.asyncio
    async def test_list_rest_apis(self, client: httpx.AsyncClient) -> None:
        await client.post("/restapis", json={"name": "api-1"})
        await client.post("/restapis", json={"name": "api-2"})

        resp = await client.get("/restapis")

        assert resp.status_code == 200
        assert len(resp.json()["item"]) == 2

    @pytest.mark.asyncio
    async def test_get_rest_api(self, client: httpx.AsyncClient) -> None:
        create_resp = await client.post("/restapis", json={"name": "my-api"})
        api_id = create_resp.json()["id"]

        resp = await client.get(f"/restapis/{api_id}")

        assert resp.status_code == 200
        assert resp.json()["name"] == "my-api"

    @pytest.mark.asyncio
    async def test_delete_rest_api(self, client: httpx.AsyncClient) -> None:
        create_resp = await client.post("/restapis", json={"name": "my-api"})
        api_id = create_resp.json()["id"]

        resp = await client.delete(f"/restapis/{api_id}")
        assert resp.status_code == 202

        get_resp = await client.get(f"/restapis/{api_id}")
        assert get_resp.status_code == 404

    @pytest.mark.asyncio
    async def test_create_resource(self, client: httpx.AsyncClient) -> None:
        create_resp = await client.post("/restapis", json={"name": "my-api"})
        api = create_resp.json()
        api_id = api["id"]
        root_id = api["rootResourceId"]

        resp = await client.post(
            f"/restapis/{api_id}/resources/{root_id}",
            json={"pathPart": "orders"},
        )

        assert resp.status_code == 201
        data = resp.json()
        assert data["pathPart"] == "orders"
        assert data["path"] == "/orders"

    @pytest.mark.asyncio
    async def test_put_method(self, client: httpx.AsyncClient) -> None:
        create_resp = await client.post("/restapis", json={"name": "my-api"})
        api = create_resp.json()
        api_id = api["id"]
        root_id = api["rootResourceId"]

        resp = await client.put(
            f"/restapis/{api_id}/resources/{root_id}/methods/GET",
            json={"authorizationType": "NONE"},
        )

        assert resp.status_code == 201
        assert resp.json()["httpMethod"] == "GET"

    @pytest.mark.asyncio
    async def test_create_deployment(self, client: httpx.AsyncClient) -> None:
        create_resp = await client.post("/restapis", json={"name": "my-api"})
        api_id = create_resp.json()["id"]

        resp = await client.post(
            f"/restapis/{api_id}/deployments",
            json={"description": "v1"},
        )

        assert resp.status_code == 201
        assert "id" in resp.json()

    @pytest.mark.asyncio
    async def test_create_and_get_stage(self, client: httpx.AsyncClient) -> None:
        create_resp = await client.post("/restapis", json={"name": "my-api"})
        api_id = create_resp.json()["id"]

        deploy_resp = await client.post(f"/restapis/{api_id}/deployments", json={})
        deployment_id = deploy_resp.json()["id"]

        stage_resp = await client.post(
            f"/restapis/{api_id}/stages",
            json={"stageName": "prod", "deploymentId": deployment_id},
        )
        assert stage_resp.status_code == 201

        get_resp = await client.get(f"/restapis/{api_id}/stages/prod")
        assert get_resp.status_code == 200
        assert get_resp.json()["stageName"] == "prod"

    @pytest.mark.asyncio
    async def test_unknown_path_returns_not_found(self, client: httpx.AsyncClient) -> None:
        resp = await client.get("/some/unknown/path")

        assert resp.status_code == 404
        body = resp.json()
        assert "lws" in body["message"]
        assert "API Gateway" in body["message"]
