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
        resp = await _request(
            client,
            "AdminCreateUser",
            {
                "UserPoolId": POOL_ID,
                "Username": "admin-user",
            },
        )
        assert resp.status_code == 200
        data = resp.json()
        assert "User" in data
        assert data["User"]["Username"] == "admin-user"
        assert data["User"]["UserStatus"] == "CONFIRMED"
        assert data["User"]["Enabled"] is True

    async def test_create_user_with_attributes(self, client: httpx.AsyncClient) -> None:
        resp = await _request(
            client,
            "AdminCreateUser",
            {
                "UserPoolId": POOL_ID,
                "Username": "attr-user",
                "UserAttributes": [
                    {"Name": "email", "Value": "test@example.com"},
                ],
            },
        )
        assert resp.status_code == 200
        data = resp.json()
        attrs = {a["Name"]: a["Value"] for a in data["User"]["Attributes"]}
        assert attrs["email"] == "test@example.com"
        assert "sub" in attrs

    async def test_create_user_with_temporary_password(self, client: httpx.AsyncClient) -> None:
        resp = await _request(
            client,
            "AdminCreateUser",
            {
                "UserPoolId": POOL_ID,
                "Username": "pw-user",
                "TemporaryPassword": "TempPass1!",
            },
        )
        assert resp.status_code == 200
        assert resp.json()["User"]["Username"] == "pw-user"

    async def test_create_duplicate_user_returns_error(self, client: httpx.AsyncClient) -> None:
        await _request(
            client,
            "AdminCreateUser",
            {"UserPoolId": POOL_ID, "Username": "dup-user"},
        )
        resp = await _request(
            client,
            "AdminCreateUser",
            {"UserPoolId": POOL_ID, "Username": "dup-user"},
        )
        assert resp.status_code == 400
        assert resp.json()["__type"] == "UsernameExistsException"

    async def test_create_user_wrong_pool_returns_error(self, client: httpx.AsyncClient) -> None:
        resp = await _request(
            client,
            "AdminCreateUser",
            {"UserPoolId": "us-east-1_wrong", "Username": "test"},
        )
        assert resp.status_code == 400
        assert resp.json()["__type"] == "ResourceNotFoundException"
