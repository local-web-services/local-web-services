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

        # Assert
        expected_status = 201
        expected_name = "my-api"
        expected_description = "test"
        assert resp.status_code == expected_status
        data = resp.json()
        assert data["name"] == expected_name
        assert data["description"] == expected_description
        assert "id" in data
        assert "rootResourceId" in data

    @pytest.mark.asyncio
    async def test_list_rest_apis(self, client: httpx.AsyncClient) -> None:
        await client.post("/restapis", json={"name": "api-1"})
        await client.post("/restapis", json={"name": "api-2"})

        resp = await client.get("/restapis")

        # Assert
        expected_status = 200
        expected_count = 2
        assert resp.status_code == expected_status
        assert len(resp.json()["item"]) == expected_count

    @pytest.mark.asyncio
    async def test_get_rest_api(self, client: httpx.AsyncClient) -> None:
        api_name = "my-api"
        create_resp = await client.post("/restapis", json={"name": api_name})
        api_id = create_resp.json()["id"]

        resp = await client.get(f"/restapis/{api_id}")

        # Assert
        expected_status = 200
        assert resp.status_code == expected_status
        assert resp.json()["name"] == api_name

    @pytest.mark.asyncio
    async def test_delete_rest_api(self, client: httpx.AsyncClient) -> None:
        create_resp = await client.post("/restapis", json={"name": "my-api"})
        api_id = create_resp.json()["id"]

        resp = await client.delete(f"/restapis/{api_id}")
        expected_delete_status = 202
        assert resp.status_code == expected_delete_status

        get_resp = await client.get(f"/restapis/{api_id}")
        expected_not_found_status = 404
        assert get_resp.status_code == expected_not_found_status

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

        # Assert
        expected_status = 201
        expected_path_part = "orders"
        expected_path = "/orders"
        assert resp.status_code == expected_status
        data = resp.json()
        assert data["pathPart"] == expected_path_part
        assert data["path"] == expected_path

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

        # Assert
        expected_status = 201
        expected_method = "GET"
        assert resp.status_code == expected_status
        assert resp.json()["httpMethod"] == expected_method

    @pytest.mark.asyncio
    async def test_create_deployment(self, client: httpx.AsyncClient) -> None:
        create_resp = await client.post("/restapis", json={"name": "my-api"})
        api_id = create_resp.json()["id"]

        resp = await client.post(
            f"/restapis/{api_id}/deployments",
            json={"description": "v1"},
        )

        # Assert
        expected_status = 201
        assert resp.status_code == expected_status
        assert "id" in resp.json()

    @pytest.mark.asyncio
    async def test_create_and_get_stage(self, client: httpx.AsyncClient) -> None:
        stage_name = "prod"
        create_resp = await client.post("/restapis", json={"name": "my-api"})
        api_id = create_resp.json()["id"]

        deploy_resp = await client.post(f"/restapis/{api_id}/deployments", json={})
        deployment_id = deploy_resp.json()["id"]

        stage_resp = await client.post(
            f"/restapis/{api_id}/stages",
            json={"stageName": stage_name, "deploymentId": deployment_id},
        )
        expected_create_status = 201
        assert stage_resp.status_code == expected_create_status

        get_resp = await client.get(f"/restapis/{api_id}/stages/{stage_name}")
        expected_get_status = 200
        assert get_resp.status_code == expected_get_status
        assert get_resp.json()["stageName"] == stage_name

    @pytest.mark.asyncio
    async def test_unknown_path_returns_not_found(self, client: httpx.AsyncClient) -> None:
        resp = await client.get("/some/unknown/path")

        # Assert
        expected_status = 404
        assert resp.status_code == expected_status
        body = resp.json()
        assert "lws" in body["message"]
        assert "API Gateway" in body["message"]
