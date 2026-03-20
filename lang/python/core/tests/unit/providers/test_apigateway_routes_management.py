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
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        data = resp.json()
        assert data["name"] == expected_name, f'Expected {expected_name!r} but got {data["name"]!r}'
        assert (
            data["description"] == expected_description
        ), f'Expected {expected_description!r} but got {data["description"]!r}'
        assert "id" in data, f'Expected {"id"!r} to be in {data!r}'
        assert "rootResourceId" in data, f'Expected {"rootResourceId"!r} to be in {data!r}'

    @pytest.mark.asyncio
    async def test_list_rest_apis(self, client: httpx.AsyncClient) -> None:
        await client.post("/restapis", json={"name": "api-1"})
        await client.post("/restapis", json={"name": "api-2"})

        resp = await client.get("/restapis")

        # Assert
        expected_status = 200
        expected_count = 2
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert (
            len(resp.json()["item"]) == expected_count
        ), f'Expected {expected_count!r} but got {len(resp.json()["item"])!r}'

    @pytest.mark.asyncio
    async def test_get_rest_api(self, client: httpx.AsyncClient) -> None:
        api_name = "my-api"
        create_resp = await client.post("/restapis", json={"name": api_name})
        api_id = create_resp.json()["id"]

        resp = await client.get(f"/restapis/{api_id}")

        # Assert
        expected_status = 200
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert (
            resp.json()["name"] == api_name
        ), f'Expected {api_name!r} but got {resp.json()["name"]!r}'

    @pytest.mark.asyncio
    async def test_delete_rest_api(self, client: httpx.AsyncClient) -> None:
        create_resp = await client.post("/restapis", json={"name": "my-api"})
        api_id = create_resp.json()["id"]

        resp = await client.delete(f"/restapis/{api_id}")
        expected_delete_status = 202
        assert (
            resp.status_code == expected_delete_status
        ), f"Expected {expected_delete_status!r} but got {resp.status_code!r}"

        get_resp = await client.get(f"/restapis/{api_id}")
        expected_not_found_status = 404
        assert (
            get_resp.status_code == expected_not_found_status
        ), f"Expected {expected_not_found_status!r} but got {get_resp.status_code!r}"

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
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        data = resp.json()
        assert (
            data["pathPart"] == expected_path_part
        ), f'Expected {expected_path_part!r} but got {data["pathPart"]!r}'
        assert data["path"] == expected_path, f'Expected {expected_path!r} but got {data["path"]!r}'

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
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert (
            resp.json()["httpMethod"] == expected_method
        ), f'Expected {expected_method!r} but got {resp.json()["httpMethod"]!r}'

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
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert "id" in resp.json(), f'Expected {"id"!r} to be in {resp.json()!r}'

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
        assert (
            stage_resp.status_code == expected_create_status
        ), f"Expected {expected_create_status!r} but got {stage_resp.status_code!r}"

        get_resp = await client.get(f"/restapis/{api_id}/stages/{stage_name}")
        expected_get_status = 200
        assert (
            get_resp.status_code == expected_get_status
        ), f"Expected {expected_get_status!r} but got {get_resp.status_code!r}"
        assert (
            get_resp.json()["stageName"] == stage_name
        ), f'Expected {stage_name!r} but got {get_resp.json()["stageName"]!r}'

    @pytest.mark.asyncio
    async def test_unknown_path_returns_not_found(self, client: httpx.AsyncClient) -> None:
        resp = await client.get("/some/unknown/path")

        # Assert
        expected_status = 404
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        body = resp.json()
        assert "lws" in body["message"], f'Expected {"lws"!r} to be in {body["message"]!r}'
        assert (
            "API Gateway" in body["message"]
        ), f'Expected {"API Gateway"!r} to be in {body["message"]!r}'
