"""Tests for Cognito CreateUserPoolClient operation."""

from __future__ import annotations

import json
from pathlib import Path

import httpx
import pytest

from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.routes import create_cognito_app
from lws.providers.cognito.user_store import UserPoolConfig

POOL_ID = "us-east-1_testpool"
POOL_NAME = "test-pool"


@pytest.fixture()
async def client(tmp_path: Path) -> httpx.AsyncClient:
    config = UserPoolConfig(
        user_pool_id=POOL_ID,
        user_pool_name=POOL_NAME,
    )
    provider = CognitoProvider(data_dir=tmp_path, config=config)
    await provider.start()
    app = create_cognito_app(provider)
    transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
    client = httpx.AsyncClient(transport=transport, base_url="http://testserver")
    yield client
    await provider.stop()


async def _request(client: httpx.AsyncClient, operation: str, body: dict) -> httpx.Response:
    return await client.post(
        "/",
        content=json.dumps(body),
        headers={
            "X-Amz-Target": f"AWSCognitoIdentityProviderService.{operation}",
            "Content-Type": "application/x-amz-json-1.1",
        },
    )


class TestCreateUserPoolClient:
    async def test_create_client_returns_client_info(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_client_name = "my-app"

        # Act
        resp = await _request(
            client,
            "CreateUserPoolClient",
            {"UserPoolId": POOL_ID, "ClientName": expected_client_name},
        )

        # Assert
        expected_status = 200
        assert resp.status_code == expected_status, f"Expected {expected_status!r} but got {resp.status_code!r}"
        data = resp.json()
        assert "UserPoolClient" in data, f'Expected {"UserPoolClient"!r} to be in {data!r}'
        upc = data["UserPoolClient"]
        actual_client_name = upc["ClientName"]
        actual_pool_id = upc["UserPoolId"]
        assert actual_client_name == expected_client_name, f"Expected {expected_client_name!r} but got {actual_client_name!r}"
        assert actual_pool_id == POOL_ID, f"Expected {POOL_ID!r} but got {actual_pool_id!r}"
        assert "ClientId" in upc, f'Expected {"ClientId"!r} to be in {upc!r}'

    async def test_create_client_with_explicit_auth_flows(self, client: httpx.AsyncClient) -> None:
        flows = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
        resp = await _request(
            client,
            "CreateUserPoolClient",
            {
                "UserPoolId": POOL_ID,
                "ClientName": "my-app",
                "ExplicitAuthFlows": flows,
            },
        )
        assert resp.status_code == 200, f"Expected {200!r} but got {resp.status_code!r}"
        data = resp.json()
        assert data["UserPoolClient"]["ExplicitAuthFlows"] == flows, f'Expected {flows!r} but got {data["UserPoolClient"]["ExplicitAuthFlows"]!r}'

    async def test_create_client_wrong_pool_returns_error(self, client: httpx.AsyncClient) -> None:
        # Act
        resp = await _request(
            client,
            "CreateUserPoolClient",
            {"UserPoolId": "us-east-1_wrong", "ClientName": "my-app"},
        )

        # Assert
        expected_status = 400
        expected_error_type = "ResourceNotFoundException"
        assert resp.status_code == expected_status, f"Expected {expected_status!r} but got {resp.status_code!r}"
        actual_error_type = resp.json()["__type"]
        assert actual_error_type == expected_error_type, f"Expected {expected_error_type!r} but got {actual_error_type!r}"
