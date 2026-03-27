"""Tests for Cognito AdminSetUserPassword route."""

from __future__ import annotations

import json
from pathlib import Path

import httpx
import pytest

from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.routes import create_cognito_app
from lws.providers.cognito.user_store import UserPoolConfig

POOL_ID = "us-east-1_setpwpooltest"
POOL_NAME = "setpw-pool"


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
    async_client = httpx.AsyncClient(transport=transport, base_url="http://testserver")
    yield async_client
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


class TestAdminSetUserPassword:
    async def test_admin_set_user_password_returns_200(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 200
        username = "pw-user@example.com"
        await _request(
            client,
            "AdminCreateUser",
            {"UserPoolId": POOL_ID, "Username": username, "TemporaryPassword": "TempPass1!"},
        )

        # Act
        resp = await _request(
            client,
            "AdminSetUserPassword",
            {
                "UserPoolId": POOL_ID,
                "Username": username,
                "Password": "NewPass123!",
                "Permanent": True,
            },
        )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"

    async def test_admin_set_user_password_user_not_found_returns_error(
        self, client: httpx.AsyncClient
    ) -> None:
        # Arrange
        expected_error_type = "UserNotFoundException"

        # Act
        resp = await _request(
            client,
            "AdminSetUserPassword",
            {
                "UserPoolId": POOL_ID,
                "Username": "nonexistent-user",
                "Password": "NewPass123!",
                "Permanent": True,
            },
        )

        # Assert
        actual_error_type = resp.json()["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"
