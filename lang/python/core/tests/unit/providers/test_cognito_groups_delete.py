"""Tests for Cognito DeleteGroup operation."""

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


class TestDeleteGroup:
    async def test_delete_group_succeeds(self, client: httpx.AsyncClient) -> None:
        # Arrange
        await _request(client, "CreateGroup", {"UserPoolId": _POOL_ID, "GroupName": "to-delete"})

        # Act
        resp = await _request(
            client, "DeleteGroup", {"UserPoolId": _POOL_ID, "GroupName": "to-delete"}
        )

        # Assert
        expected_status = 200
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"

    async def test_deleted_group_not_in_list(self, client: httpx.AsyncClient) -> None:
        # Arrange
        await _request(client, "CreateGroup", {"UserPoolId": _POOL_ID, "GroupName": "gone"})
        await _request(client, "DeleteGroup", {"UserPoolId": _POOL_ID, "GroupName": "gone"})

        # Act
        resp = await _request(client, "ListGroups", {"UserPoolId": _POOL_ID})

        # Assert
        actual_groups = [g["GroupName"] for g in resp.json()["Groups"]]
        assert "gone" not in actual_groups, f"Expected 'gone' to not be in {actual_groups!r}"
