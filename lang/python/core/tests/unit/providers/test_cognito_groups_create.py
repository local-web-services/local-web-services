"""Tests for Cognito CreateGroup operation."""

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


class TestCreateGroup:
    async def test_create_group_succeeds(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_group_name = "admins"
        expected_description = "Administrator group"

        # Act
        resp = await _request(
            client,
            "CreateGroup",
            {
                "UserPoolId": _POOL_ID,
                "GroupName": expected_group_name,
                "Description": expected_description,
            },
        )

        # Assert
        expected_status = 200
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
        actual_group = resp.json()["Group"]
        actual_group_name = actual_group["GroupName"]
        assert (
            actual_group_name == expected_group_name
        ), f"Expected {expected_group_name!r} but got {actual_group_name!r}"

    async def test_create_duplicate_group_returns_error(self, client: httpx.AsyncClient) -> None:
        # Arrange
        await _request(client, "CreateGroup", {"UserPoolId": _POOL_ID, "GroupName": "my-group"})

        # Act
        resp = await _request(
            client, "CreateGroup", {"UserPoolId": _POOL_ID, "GroupName": "my-group"}
        )

        # Assert
        expected_status = 400
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
