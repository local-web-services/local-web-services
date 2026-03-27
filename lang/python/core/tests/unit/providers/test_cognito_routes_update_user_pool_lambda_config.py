"""Tests for UpdateUserPool with LambdaConfig."""

from __future__ import annotations

import json

import pytest
from httpx import ASGITransport, AsyncClient

from lws.providers.cognito._cognito_auth import PasswordPolicy, UserPoolConfig
from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.routes import CognitoRouter


@pytest.fixture
def pool_id() -> str:
    """Return a test user pool ID."""
    return "us-east-1_lambdatest"


@pytest.fixture
def provider(tmp_path, pool_id: str) -> CognitoProvider:
    """Return a Cognito provider with a test user pool."""
    config = UserPoolConfig(
        user_pool_id=pool_id,
        password_policy=PasswordPolicy(minimum_length=6, require_symbols=False),
    )
    return CognitoProvider(data_dir=tmp_path, config=config)


@pytest.fixture
async def client(provider: CognitoProvider):
    """Return an ASGI test client for the CognitoRouter."""
    from fastapi import FastAPI  # pylint: disable=import-outside-toplevel

    app = FastAPI()
    router = CognitoRouter(provider=provider)
    app.include_router(router.router)
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as c:
        yield c


class TestUpdateUserPoolLambdaConfig:
    """Tests for UpdateUserPool LambdaConfig parsing."""

    async def test_update_user_pool_sets_pre_signup_trigger(
        self, client: AsyncClient, provider: CognitoProvider, pool_id: str
    ) -> None:
        # Arrange
        lambda_arn = "arn:aws:lambda:us-east-1:000000000000:function:my-pre-signup-fn"
        expected_trigger = "my-pre-signup-fn"
        body = json.dumps(
            {
                "UserPoolId": pool_id,
                "LambdaConfig": {"PreSignUp": lambda_arn},
            }
        )

        # Act
        resp = await client.post(
            "/",
            content=body,
            headers={"X-Amz-Target": "AWSCognitoIdentityProviderService.UpdateUserPool"},
        )

        # Assert
        expected_status = 200
        actual_status = resp.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"
        actual_trigger = provider.config.pre_signup_trigger
        assert (
            actual_trigger == expected_trigger
        ), f"Expected {expected_trigger!r} but got {actual_trigger!r}"
