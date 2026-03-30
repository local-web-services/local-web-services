"""Tests for Cognito ListUsersInGroup operation."""

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


class TestListUsersInGroup:
    async def test_list_users_in_group(self, client: httpx.AsyncClient) -> None:
        # Arrange
        await _create_user(client, "user1")
        await _create_user(client, "user2")
        await _request(client, "CreateGroup", {"UserPoolId": _POOL_ID, "GroupName": "team"})
        await _request(
            client,
            "AdminAddUserToGroup",
            {"UserPoolId": _POOL_ID, "Username": "user1", "GroupName": "team"},
        )
        await _request(
            client,
            "AdminAddUserToGroup",
            {"UserPoolId": _POOL_ID, "Username": "user2", "GroupName": "team"},
        )

        # Act
        resp = await _request(
            client, "ListUsersInGroup", {"UserPoolId": _POOL_ID, "GroupName": "team"}
        )

        # Assert
        expected_status = 200
        expected_count = 2
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        actual_count = len(resp.json()["Users"])
        assert (
            actual_count == expected_count
        ), f"Expected {expected_count!r} but got {actual_count!r}"

    async def test_list_users_in_nonexistent_group_returns_error(
        self, client: httpx.AsyncClient
    ) -> None:
        # Act
        resp = await _request(
            client,
            "ListUsersInGroup",
            {"UserPoolId": _POOL_ID, "GroupName": "no-such-group"},
        )

        # Assert
        expected_status = 400
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
