"""Tests for API Gateway V1 delete_deployment route."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.apigateway.routes import create_apigateway_management_app
from lws.providers.lambda_runtime.routes import LambdaRegistry


class TestV1DeleteDeployment:
    """Test DELETE /restapis/{api_id}/deployments/{deployment_id}."""

    @pytest.fixture
    def client(self):
        registry = LambdaRegistry()
        app = create_apigateway_management_app(lambda_registry=registry)[0]
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://test")

    async def _create_rest_api(self, client, name="test-api"):
        resp = await client.post("/restapis", json={"name": name})
        return resp.json()["id"]

    async def _create_deployment(self, client, rest_api_id, description=""):
        resp = await client.post(
            f"/restapis/{rest_api_id}/deployments",
            json={"description": description},
        )
        return resp.json()["id"]

    @pytest.mark.asyncio
    async def test_delete_deployment_succeeds(self, client) -> None:
        # Arrange
        rest_api_id = await self._create_rest_api(client)
        deployment_id = await self._create_deployment(client, rest_api_id)

        # Act
        resp = await client.delete(f"/restapis/{rest_api_id}/deployments/{deployment_id}")

        # Assert
        expected_status = 202
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"

    @pytest.mark.asyncio
    async def test_delete_deployment_removes_from_list(self, client) -> None:
        # Arrange
        rest_api_id = await self._create_rest_api(client)
        deployment_id = await self._create_deployment(client, rest_api_id)

        # Act
        await client.delete(f"/restapis/{rest_api_id}/deployments/{deployment_id}")
        list_resp = await client.get(f"/restapis/{rest_api_id}/deployments")

        # Assert
        actual_ids = [d["id"] for d in list_resp.json()["item"]]
        assert (
            deployment_id not in actual_ids
        ), f"Expected {deployment_id!r} to not be in {actual_ids!r}"
