"""Tests for Cognito routes management operations."""

from __future__ import annotations

import json
from pathlib import Path

import httpx
import pytest

from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.routes import create_cognito_app
from lws.providers.cognito.user_store import UserPoolConfig


@pytest.fixture()
async def client(tmp_path: Path) -> httpx.AsyncClient:
    config = UserPoolConfig(
        user_pool_id="us-east-1_testpool",
        user_pool_name="test-pool",
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


class TestListUserPools:
    async def test_list_returns_pools(self, client: httpx.AsyncClient) -> None:
        resp = await _request(client, "ListUserPools", {"MaxResults": 60})
        assert resp.status_code == 200
        data = resp.json()
        assert "UserPools" in data
        assert len(data["UserPools"]) == 1
        assert data["UserPools"][0]["Name"] == "test-pool"
