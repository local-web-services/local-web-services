"""Tests that Cognito routes return TooManyRequestsException when capacity is exhausted."""

from __future__ import annotations

from pathlib import Path

import httpx
import pytest

from lws.providers._shared.aws_capacity import AwsCapacityConfig
from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.routes import create_cognito_app
from lws.providers.cognito.user_store import PasswordPolicy, UserPoolConfig

_TARGET_PREFIX = "AWSCognitoIdentityProviderService."


def _make_pool_config() -> UserPoolConfig:
    """Return a default UserPoolConfig for testing."""
    return UserPoolConfig(
        user_pool_id="us-east-1_TestPool",
        user_pool_name="test-pool",
        password_policy=PasswordPolicy(
            minimum_length=8,
            require_lowercase=True,
            require_uppercase=True,
            require_digits=True,
            require_symbols=False,
        ),
        auto_confirm=True,
        client_id="test-client-id",
    )


class TestCognitoRoutesCapacityExhausted:
    """Cognito routes return TooManyRequestsException when capacity slots=0."""

    @pytest.fixture()
    async def provider(self, tmp_path: Path) -> CognitoProvider:
        """Start and yield a CognitoProvider, then stop it."""
        config = _make_pool_config()
        p = CognitoProvider(data_dir=tmp_path, config=config)
        await p.start()
        yield p
        await p.stop()

    @pytest.mark.asyncio
    async def test_initiate_auth_capacity_exhausted(self, provider: CognitoProvider) -> None:
        # Arrange
        capacity = AwsCapacityConfig(slots=0)
        app = create_cognito_app(provider, capacity=capacity)
        transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
        expected_status_code = 400
        expected_error_type = "TooManyRequestsException"

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
            resp = await client.post(
                "/",
                json={"AuthFlow": "USER_PASSWORD_AUTH", "AuthParameters": {}},
                headers={"X-Amz-Target": f"{_TARGET_PREFIX}InitiateAuth"},
            )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = resp.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"

    @pytest.mark.asyncio
    async def test_sign_up_capacity_exhausted(self, provider: CognitoProvider) -> None:
        # Arrange
        capacity = AwsCapacityConfig(slots=0)
        app = create_cognito_app(provider, capacity=capacity)
        transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
        expected_status_code = 400
        expected_error_type = "TooManyRequestsException"

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
            resp = await client.post(
                "/",
                json={"Username": "alice", "Password": "Password1A"},
                headers={"X-Amz-Target": f"{_TARGET_PREFIX}SignUp"},
            )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = resp.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"
