"""Tests for Cognito AdminDeleteUser operation."""

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


class TestAdminDeleteUser:
    async def test_delete_existing_user(self, client: httpx.AsyncClient) -> None:
        # Arrange
        username = "to-delete"
        await _request(
            client,
            "AdminCreateUser",
            {"UserPoolId": POOL_ID, "Username": username},
        )

        # Act
        resp = await _request(
            client,
            "AdminDeleteUser",
            {"UserPoolId": POOL_ID, "Username": username},
        )

        # Assert
        expected_delete_status = 200
        assert resp.status_code == expected_delete_status

        # Verify the user is gone
        expected_error_status = 400
        expected_error_type = "UserNotFoundException"
        resp = await _request(
            client,
            "AdminGetUser",
            {"UserPoolId": POOL_ID, "Username": username},
        )
        assert resp.status_code == expected_error_status
        actual_error_type = resp.json()["__type"]
        assert actual_error_type == expected_error_type

    async def test_delete_nonexistent_user_returns_error(self, client: httpx.AsyncClient) -> None:
        # Act
        resp = await _request(
            client,
            "AdminDeleteUser",
            {"UserPoolId": POOL_ID, "Username": "no-such-user"},
        )

        # Assert
        expected_status = 400
        expected_error_type = "UserNotFoundException"
        assert resp.status_code == expected_status
        actual_error_type = resp.json()["__type"]
        assert actual_error_type == expected_error_type
