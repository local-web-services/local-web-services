"""Tests for Cognito AdminCreateUser operation."""

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


class TestAdminCreateUser:
    async def test_create_user(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_username = "admin-user"
        expected_status = "CONFIRMED"

        # Act
        resp = await _request(
            client,
            "AdminCreateUser",
            {
                "UserPoolId": POOL_ID,
                "Username": expected_username,
            },
        )

        # Assert
        expected_http_status = 200
        assert resp.status_code == expected_http_status
        data = resp.json()
        assert "User" in data
        actual_username = data["User"]["Username"]
        actual_status = data["User"]["UserStatus"]
        assert actual_username == expected_username
        assert actual_status == expected_status
        assert data["User"]["Enabled"] is True

    async def test_create_user_with_attributes(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_email = "test@example.com"

        # Act
        resp = await _request(
            client,
            "AdminCreateUser",
            {
                "UserPoolId": POOL_ID,
                "Username": "attr-user",
                "UserAttributes": [
                    {"Name": "email", "Value": expected_email},
                ],
            },
        )

        # Assert
        expected_http_status = 200
        assert resp.status_code == expected_http_status
        data = resp.json()
        attrs = {a["Name"]: a["Value"] for a in data["User"]["Attributes"]}
        actual_email = attrs["email"]
        assert actual_email == expected_email
        assert "sub" in attrs

    async def test_create_user_with_temporary_password(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_username = "pw-user"

        # Act
        resp = await _request(
            client,
            "AdminCreateUser",
            {
                "UserPoolId": POOL_ID,
                "Username": expected_username,
                "TemporaryPassword": "TempPass1!",
            },
        )

        # Assert
        expected_http_status = 200
        assert resp.status_code == expected_http_status
        actual_username = resp.json()["User"]["Username"]
        assert actual_username == expected_username

    async def test_create_duplicate_user_returns_error(self, client: httpx.AsyncClient) -> None:
        # Arrange
        username = "dup-user"
        await _request(
            client,
            "AdminCreateUser",
            {"UserPoolId": POOL_ID, "Username": username},
        )

        # Act
        resp = await _request(
            client,
            "AdminCreateUser",
            {"UserPoolId": POOL_ID, "Username": username},
        )

        # Assert
        expected_http_status = 400
        expected_error_type = "UsernameExistsException"
        assert resp.status_code == expected_http_status
        actual_error_type = resp.json()["__type"]
        assert actual_error_type == expected_error_type

    async def test_create_user_wrong_pool_returns_error(self, client: httpx.AsyncClient) -> None:
        # Act
        resp = await _request(
            client,
            "AdminCreateUser",
            {"UserPoolId": "us-east-1_wrong", "Username": "test"},
        )

        # Assert
        expected_http_status = 400
        expected_error_type = "ResourceNotFoundException"
        assert resp.status_code == expected_http_status
        actual_error_type = resp.json()["__type"]
        assert actual_error_type == expected_error_type
