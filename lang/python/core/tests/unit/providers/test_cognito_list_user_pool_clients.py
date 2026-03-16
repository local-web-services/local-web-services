"""Tests for Cognito ListUserPoolClients operation."""

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


class TestListUserPoolClients:
    async def test_list_empty(self, client: httpx.AsyncClient) -> None:
        resp = await _request(
            client,
            "ListUserPoolClients",
            {"UserPoolId": POOL_ID},
        )
        assert resp.status_code == 200
        data = resp.json()
        assert data["UserPoolClients"] == []

    async def test_list_after_creating_clients(self, client: httpx.AsyncClient) -> None:
        # Arrange
        expected_names = {"app-1", "app-2"}
        await _request(
            client,
            "CreateUserPoolClient",
            {"UserPoolId": POOL_ID, "ClientName": "app-1"},
        )
        await _request(
            client,
            "CreateUserPoolClient",
            {"UserPoolId": POOL_ID, "ClientName": "app-2"},
        )

        # Act
        resp = await _request(
            client,
            "ListUserPoolClients",
            {"UserPoolId": POOL_ID},
        )

        # Assert
        expected_status = 200
        expected_count = 2
        assert resp.status_code == expected_status
        data = resp.json()
        actual_count = len(data["UserPoolClients"])
        assert actual_count == expected_count
        actual_names = {c["ClientName"] for c in data["UserPoolClients"]}
        assert actual_names == expected_names

    async def test_list_wrong_pool_returns_error(self, client: httpx.AsyncClient) -> None:
        # Act
        resp = await _request(
            client,
            "ListUserPoolClients",
            {"UserPoolId": "us-east-1_wrong"},
        )

        # Assert
        expected_status = 400
        expected_error_type = "ResourceNotFoundException"
        assert resp.status_code == expected_status
        actual_error_type = resp.json()["__type"]
        assert actual_error_type == expected_error_type
