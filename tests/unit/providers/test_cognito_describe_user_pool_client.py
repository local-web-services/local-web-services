"""Tests for Cognito DescribeUserPoolClient operation."""

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


class TestDescribeUserPoolClient:
    async def test_describe_existing_client(self, client: httpx.AsyncClient) -> None:
        # Create first
        create_resp = await _request(
            client,
            "CreateUserPoolClient",
            {"UserPoolId": POOL_ID, "ClientName": "desc-test"},
        )
        client_id = create_resp.json()["UserPoolClient"]["ClientId"]

        # Describe
        resp = await _request(
            client,
            "DescribeUserPoolClient",
            {"UserPoolId": POOL_ID, "ClientId": client_id},
        )
        assert resp.status_code == 200
        data = resp.json()
        assert data["UserPoolClient"]["ClientId"] == client_id
        assert data["UserPoolClient"]["ClientName"] == "desc-test"

    async def test_describe_nonexistent_client_returns_error(
        self, client: httpx.AsyncClient
    ) -> None:
        resp = await _request(
            client,
            "DescribeUserPoolClient",
            {"UserPoolId": POOL_ID, "ClientId": "nonexistent"},
        )
        assert resp.status_code == 400
        assert resp.json()["__type"] == "ResourceNotFoundException"
