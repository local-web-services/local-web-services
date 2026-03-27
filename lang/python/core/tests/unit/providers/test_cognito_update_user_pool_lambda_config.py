"""Tests for Cognito UpdateUserPool with LambdaConfig."""

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


class TestUpdateUserPoolLambdaConfig:
    async def test_update_user_pool_with_lambda_config_succeeds(
        self, client: httpx.AsyncClient
    ) -> None:
        # Arrange
        expected_pre_auth = "my-pre-auth-function"
        expected_post_confirm = "my-post-confirm-function"

        # Act
        resp = await _request(
            client,
            "UpdateUserPool",
            {
                "UserPoolId": _POOL_ID,
                "LambdaConfig": {
                    "PreAuthentication": expected_pre_auth,
                    "PostConfirmation": expected_post_confirm,
                },
            },
        )

        # Assert
        expected_status = 200
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"

    async def test_update_user_pool_without_lambda_config_succeeds(
        self, client: httpx.AsyncClient
    ) -> None:
        # Act
        resp = await _request(
            client,
            "UpdateUserPool",
            {"UserPoolId": _POOL_ID},
        )

        # Assert
        expected_status = 200
        assert (
            resp.status_code == expected_status
        ), f"Expected {expected_status!r} but got {resp.status_code!r}"
