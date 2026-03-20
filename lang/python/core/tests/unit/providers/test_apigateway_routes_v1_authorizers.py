"""Tests for API Gateway V1 authorizer CRUD management routes."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.apigateway.routes import create_apigateway_management_app
from lws.providers.lambda_runtime.routes import LambdaRegistry


class TestV1AuthorizerCrud:
    """Test V1 REST API authorizer CRUD operations."""

    @pytest.fixture
    def registry(self):
        return LambdaRegistry()

    @pytest.fixture
    def client(self, registry):
        app = create_apigateway_management_app(lambda_registry=registry)
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://test")

    async def _create_rest_api(self, client, name="test-api"):
        resp = await client.post("/restapis", json={"name": name})
        return resp.json()["id"]

    @pytest.mark.asyncio
    async def test_create_authorizer(self, client) -> None:
        # Arrange
        rest_api_id = await self._create_rest_api(client)
        expected_name = "my-authorizer"
        expected_type = "COGNITO_USER_POOLS"

        # Act
        resp = await client.post(
            f"/restapis/{rest_api_id}/authorizers",
            json={
                "name": expected_name,
                "type": expected_type,
                "providerARNs": ["arn:aws:cognito-idp:us-east-1:000:userpool/pool-1"],
            },
        )

        # Assert
        expected_status = 201
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        data = resp.json()
        assert data["name"] == expected_name, f'Expected {expected_name!r} but got {data["name"]!r}'
        assert data["type"] == expected_type, f'Expected {expected_type!r} but got {data["type"]!r}'
        assert "id" in data, f'Expected {"id"!r} to be in {data!r}'

    @pytest.mark.asyncio
    async def test_list_authorizers(self, client) -> None:
        # Arrange
        rest_api_id = await self._create_rest_api(client)
        await client.post(
            f"/restapis/{rest_api_id}/authorizers",
            json={"name": "auth-1", "type": "TOKEN"},
        )
        await client.post(
            f"/restapis/{rest_api_id}/authorizers",
            json={"name": "auth-2", "type": "TOKEN"},
        )

        # Act
        resp = await client.get(f"/restapis/{rest_api_id}/authorizers")

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
    async def test_get_authorizer(self, client) -> None:
        # Arrange
        rest_api_id = await self._create_rest_api(client)
        expected_name = "my-auth"
        create_resp = await client.post(
            f"/restapis/{rest_api_id}/authorizers",
            json={"name": expected_name, "type": "TOKEN"},
        )
        authorizer_id = create_resp.json()["id"]

        # Act
        resp = await client.get(f"/restapis/{rest_api_id}/authorizers/{authorizer_id}")

        # Assert
        expected_status = 200
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        assert (
            resp.json()["name"] == expected_name
        ), f'Expected {expected_name!r} but got {resp.json()["name"]!r}'

    @pytest.mark.asyncio
    async def test_get_authorizer_not_found(self, client) -> None:
        # Arrange
        rest_api_id = await self._create_rest_api(client)

        # Act
        resp = await client.get(f"/restapis/{rest_api_id}/authorizers/nonexistent")

        # Assert
        expected_status = 404
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"

    @pytest.mark.asyncio
    async def test_delete_authorizer(self, client) -> None:
        # Arrange
        rest_api_id = await self._create_rest_api(client)
        create_resp = await client.post(
            f"/restapis/{rest_api_id}/authorizers",
            json={"name": "to-delete", "type": "TOKEN"},
        )
        authorizer_id = create_resp.json()["id"]

        # Act
        resp = await client.delete(f"/restapis/{rest_api_id}/authorizers/{authorizer_id}")

        # Assert
        expected_delete_status = 202
        expected_not_found_status = 404
        assert (
            resp.status_code == expected_delete_status
        ), f"Expected {expected_delete_status!r} but got {resp.status_code!r}"
        get_resp = await client.get(f"/restapis/{rest_api_id}/authorizers/{authorizer_id}")
        assert (
            get_resp.status_code == expected_not_found_status
        ), f"Expected {expected_not_found_status!r} but got {get_resp.status_code!r}"

    @pytest.mark.asyncio
    async def test_create_authorizer_api_not_found(self, client) -> None:
        # Arrange
        # Act
        resp = await client.post(
            "/restapis/nonexistent/authorizers",
            json={"name": "auth", "type": "TOKEN"},
        )

        # Assert
        expected_status = 404
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
