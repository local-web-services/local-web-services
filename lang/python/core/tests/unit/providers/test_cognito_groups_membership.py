"""Tests for Cognito AdminAddUserToGroup and AdminRemoveUserFromGroup operations."""

from __future__ import annotations

import json
from pathlib import Path

import httpx
import pytest

from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.routes import create_cognito_app
from lws.providers.cognito.user_store import UserPoolConfig

_POOL_ID = "us-east-1_testpool"
_POOL_NAME = "test-pool"


@pytest.fixture()
async def client(tmp_path: Path) -> httpx.AsyncClient:
    config = UserPoolConfig(user_pool_id=_POOL_ID, user_pool_name=_POOL_NAME)
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


async def _create_user(client: httpx.AsyncClient, username: str) -> None:
    await _request(
        client,
        "AdminCreateUser",
        {"UserPoolId": _POOL_ID, "Username": username},
    )


class TestAdminGroupMembership:
    async def test_add_user_to_group(self, client: httpx.AsyncClient) -> None:
        # Arrange
        await _create_user(client, "alice")
        await _request(client, "CreateGroup", {"UserPoolId": _POOL_ID, "GroupName": "members"})

        # Act
        resp = await _request(
            client,
            "AdminAddUserToGroup",
            {"UserPoolId": _POOL_ID, "Username": "alice", "GroupName": "members"},
        )

        # Assert
        expected_status = 200
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"

    async def test_remove_user_from_group(self, client: httpx.AsyncClient) -> None:
        # Arrange
        await _create_user(client, "bob")
        await _request(client, "CreateGroup", {"UserPoolId": _POOL_ID, "GroupName": "vips"})
        await _request(
            client,
            "AdminAddUserToGroup",
            {"UserPoolId": _POOL_ID, "Username": "bob", "GroupName": "vips"},
        )

        # Act
        resp = await _request(
            client,
            "AdminRemoveUserFromGroup",
            {"UserPoolId": _POOL_ID, "Username": "bob", "GroupName": "vips"},
        )

        # Assert
        expected_status = 200
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"

    async def test_add_to_nonexistent_group_returns_error(self, client: httpx.AsyncClient) -> None:
        # Arrange
        await _create_user(client, "charlie")

        # Act
        resp = await _request(
            client,
            "AdminAddUserToGroup",
            {"UserPoolId": _POOL_ID, "Username": "charlie", "GroupName": "ghost-group"},
        )

        # Assert
        expected_status = 400
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
