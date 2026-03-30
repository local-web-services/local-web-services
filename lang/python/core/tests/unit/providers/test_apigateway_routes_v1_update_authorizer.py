"""Tests for API Gateway V1 update_authorizer (PATCH) route."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.apigateway.routes import create_apigateway_management_app
from lws.providers.lambda_runtime.routes import LambdaRegistry


class TestV1UpdateAuthorizer:
    """Test PATCH /restapis/{api_id}/authorizers/{authorizer_id}."""

    @pytest.fixture
    def client(self):
        registry = LambdaRegistry()
        app = create_apigateway_management_app(lambda_registry=registry)[0]
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://test")

    async def _create_rest_api(self, client, name="test-api"):
        resp = await client.post("/restapis", json={"name": name})
        return resp.json()["id"]

    async def _create_authorizer(self, client, rest_api_id, name="my-auth", auth_type="TOKEN"):
        resp = await client.post(
            f"/restapis/{rest_api_id}/authorizers",
            json={"name": name, "type": auth_type},
        )
        return resp.json()["id"]

    @pytest.mark.asyncio
    async def test_update_authorizer_name(self, client) -> None:
        # Arrange
        rest_api_id = await self._create_rest_api(client)
        authorizer_id = await self._create_authorizer(client, rest_api_id, name="original-name")
        expected_name = "updated-name"

        # Act
        resp = await client.patch(
            f"/restapis/{rest_api_id}/authorizers/{authorizer_id}",
            json={"patchOperations": [{"op": "replace", "path": "/name", "value": expected_name}]},
        )

        # Assert
        expected_status = 200
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        actual_name = resp.json()["name"]
        assert actual_name == expected_name, f"Expected {expected_name!r} but got {actual_name!r}"

    @pytest.mark.asyncio
    async def test_update_authorizer_type(self, client) -> None:
        # Arrange
        rest_api_id = await self._create_rest_api(client)
        authorizer_id = await self._create_authorizer(client, rest_api_id, auth_type="TOKEN")
        expected_type = "COGNITO_USER_POOLS"

        # Act
        resp = await client.patch(
            f"/restapis/{rest_api_id}/authorizers/{authorizer_id}",
            json={"patchOperations": [{"op": "replace", "path": "/type", "value": expected_type}]},
        )

        # Assert
        expected_status = 200
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        actual_type = resp.json()["type"]
        assert actual_type == expected_type, f"Expected {expected_type!r} but got {actual_type!r}"

    @pytest.mark.asyncio
    async def test_update_authorizer_not_found(self, client) -> None:
        # Arrange
        rest_api_id = await self._create_rest_api(client)

        # Act
        resp = await client.patch(
            f"/restapis/{rest_api_id}/authorizers/nonexistent",
            json={"patchOperations": [{"op": "replace", "path": "/name", "value": "x"}]},
        )

        # Assert
        expected_status = 404
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
