"""Tests for API Gateway V1 update_method (PATCH) route."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.apigateway.routes import create_apigateway_management_app
from lws.providers.lambda_runtime.routes import LambdaRegistry


class TestV1UpdateMethod:
    """Test PATCH /restapis/{api_id}/resources/{resource_id}/methods/{http_method}."""

    @pytest.fixture
    def client(self):
        registry = LambdaRegistry()
        app = create_apigateway_management_app(lambda_registry=registry)[0]
        transport = httpx.ASGITransport(app=app)
        return httpx.AsyncClient(transport=transport, base_url="http://test")

    async def _create_api_with_resource_and_method(self, client):
        api_resp = await client.post("/restapis", json={"name": "test-api"})
        rest_api_id = api_resp.json()["id"]
        root_resource_id = api_resp.json()["rootResourceId"]
        resource_resp = await client.post(
            f"/restapis/{rest_api_id}/resources/{root_resource_id}",
            json={"pathPart": "items"},
        )
        resource_id = resource_resp.json()["id"]
        await client.put(
            f"/restapis/{rest_api_id}/resources/{resource_id}/methods/GET",
            json={"authorizationType": "NONE"},
        )
        return rest_api_id, resource_id

    @pytest.mark.asyncio
    async def test_update_method_authorization_type(self, client) -> None:
        # Arrange
        rest_api_id, resource_id = await self._create_api_with_resource_and_method(client)
        expected_auth_type = "COGNITO_USER_POOLS"
        expected_authorizer_id = "abc123"

        # Act
        resp = await client.patch(
            f"/restapis/{rest_api_id}/resources/{resource_id}/methods/GET",
            json={
                "patchOperations": [
                    {"op": "replace", "path": "/authorizationType", "value": expected_auth_type},
                    {"op": "replace", "path": "/authorizerId", "value": expected_authorizer_id},
                ]
            },
        )

        # Assert
        expected_status = 200
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        actual_auth_type = resp.json()["authorizationType"]
        actual_authorizer_id = resp.json()["authorizerId"]
        assert (
            actual_auth_type == expected_auth_type
        ), f"Expected {expected_auth_type!r} but got {actual_auth_type!r}"
        assert (
            actual_authorizer_id == expected_authorizer_id
        ), f"Expected {expected_authorizer_id!r} but got {actual_authorizer_id!r}"

    @pytest.mark.asyncio
    async def test_update_method_not_found(self, client) -> None:
        # Arrange
        api_resp = await client.post("/restapis", json={"name": "test-api"})
        rest_api_id = api_resp.json()["id"]
        root_resource_id = api_resp.json()["rootResourceId"]

        # Act
        patch_ops = [{"op": "replace", "path": "/authorizationType", "value": "NONE"}]
        resp = await client.patch(
            f"/restapis/{rest_api_id}/resources/{root_resource_id}/methods/DELETE",
            json={"patchOperations": patch_ops},
        )

        # Assert
        expected_status = 404
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
