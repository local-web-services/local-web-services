"""Tests for API Gateway V2 authorizer CRUD management routes."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.apigateway.routes import create_apigateway_management_app
from lws.providers.lambda_runtime.routes import LambdaRegistry


class TestV2AuthorizerCrud:
    """Test V2 HTTP API authorizer CRUD operations."""

    @pytest.fixture
    def registry(self):
        return LambdaRegistry()

    @pytest.fixture
    def client(self, registry):
        app = create_apigateway_management_app(lambda_registry=registry)
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://test")

    async def _create_api(self, client, name="test-api"):
        resp = await client.post("/v2/apis", json={"name": name, "protocolType": "HTTP"})
        return resp.json()["apiId"]

    @pytest.mark.asyncio
    async def test_create_authorizer(self, client) -> None:
        # Arrange
        api_id = await self._create_api(client)
        expected_name = "jwt-auth"
        expected_type = "JWT"

        # Act
        resp = await client.post(
            f"/v2/apis/{api_id}/authorizers",
            json={
                "name": expected_name,
                "authorizerType": expected_type,
                "identitySource": "$request.header.Authorization",
                "jwtConfiguration": {
                    "issuer": "https://example.com",
                    "audience": ["my-api"],
                },
            },
        )

        # Assert
        expected_status = 201
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        data = resp.json()
        assert data["name"] == expected_name, f'Expected {expected_name!r} but got {data["name"]!r}'
        assert (
            data["authorizerType"] == expected_type
        ), f'Expected {expected_type!r} but got {data["authorizerType"]!r}'
        assert "authorizerId" in data, f'Expected {"authorizerId"!r} to be in {data!r}'

    @pytest.mark.asyncio
    async def test_list_authorizers(self, client) -> None:
        # Arrange
        api_id = await self._create_api(client)
        await client.post(
            f"/v2/apis/{api_id}/authorizers",
            json={"name": "auth-1", "authorizerType": "JWT"},
        )
        await client.post(
            f"/v2/apis/{api_id}/authorizers",
            json={"name": "auth-2", "authorizerType": "JWT"},
        )

        # Act
        resp = await client.get(f"/v2/apis/{api_id}/authorizers")

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
    async def test_get_authorizer(self, client) -> None:
        # Arrange
        api_id = await self._create_api(client)
        expected_name = "my-jwt"
        create_resp = await client.post(
            f"/v2/apis/{api_id}/authorizers",
            json={"name": expected_name, "authorizerType": "JWT"},
        )
        authorizer_id = create_resp.json()["authorizerId"]

        # Act
        resp = await client.get(f"/v2/apis/{api_id}/authorizers/{authorizer_id}")

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
        api_id = await self._create_api(client)

        # Act
        resp = await client.get(f"/v2/apis/{api_id}/authorizers/nonexistent")

        # Assert
        expected_status = 404
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"

    @pytest.mark.asyncio
    async def test_delete_authorizer(self, client) -> None:
        # Arrange
        api_id = await self._create_api(client)
        create_resp = await client.post(
            f"/v2/apis/{api_id}/authorizers",
            json={"name": "to-delete", "authorizerType": "JWT"},
        )
        authorizer_id = create_resp.json()["authorizerId"]

        # Act
        resp = await client.delete(f"/v2/apis/{api_id}/authorizers/{authorizer_id}")

        # Assert
        expected_delete_status = 204
        expected_not_found_status = 404
        assert (
            resp.status_code == expected_delete_status
        ), f"Expected {expected_delete_status!r} but got {resp.status_code!r}"
        get_resp = await client.get(f"/v2/apis/{api_id}/authorizers/{authorizer_id}")
        assert (
            get_resp.status_code == expected_not_found_status
        ), f"Expected {expected_not_found_status!r} but got {get_resp.status_code!r}"

    @pytest.mark.asyncio
    async def test_create_authorizer_api_not_found(self, client) -> None:
        # Arrange
        # Act
        resp = await client.post(
            "/v2/apis/nonexistent/authorizers",
            json={"name": "auth", "authorizerType": "JWT"},
        )

        # Assert
        expected_status = 404
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"

    @pytest.mark.asyncio
    async def test_route_stores_authorization_type(self, client) -> None:
        # Arrange
        api_id = await self._create_api(client)
        expected_auth_type = "JWT"

        # Act
        resp = await client.post(
            f"/v2/apis/{api_id}/routes",
            json={
                "routeKey": "GET /secure",
                "target": "integrations/abc",
                "authorizationType": expected_auth_type,
                "authorizerId": "auth-123",
            },
        )

        # Assert
        expected_status = 201
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        data = resp.json()
        actual_auth_type = data["authorizationType"]
        assert (
            actual_auth_type == expected_auth_type
        ), f"Expected {expected_auth_type!r} but got {actual_auth_type!r}"
