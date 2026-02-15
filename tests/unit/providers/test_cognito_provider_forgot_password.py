"""Tests for CognitoProvider forgot password flow."""

from __future__ import annotations

from pathlib import Path
from typing import Any

import pytest

from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.user_store import (
    PasswordPolicy,
    UserPoolConfig,
)


def _default_config(**overrides: Any) -> UserPoolConfig:
    """Create a default UserPoolConfig with optional overrides."""
    kwargs: dict[str, Any] = {
        "user_pool_id": "us-east-1_TestPool",
        "user_pool_name": "test-pool",
        "password_policy": PasswordPolicy(
            minimum_length=8,
            require_lowercase=True,
            require_uppercase=True,
            require_digits=True,
            require_symbols=False,
        ),
        "auto_confirm": True,
        "client_id": "test-client-id",
    }
    kwargs.update(overrides)
    return UserPoolConfig(**kwargs)


@pytest.fixture
async def provider(tmp_path: Path):
    """Create, start, yield, and stop a CognitoProvider."""
    config = _default_config()
    p = CognitoProvider(data_dir=tmp_path, config=config)
    await p.start()
    yield p
    await p.stop()


class TestCognitoProviderForgotPassword:
    """Forgot password and confirm forgot password flow."""

    async def test_forgot_password_returns_code_delivery(self, provider: CognitoProvider) -> None:
        # Arrange
        username = "alice"
        password = "Password1A"
        await provider.sign_up(username, password)

        # Act
        result = await provider.forgot_password("test-client-id", username)

        # Assert
        expected_medium = "EMAIL"
        actual_medium = result["CodeDeliveryDetails"]["DeliveryMedium"]
        assert actual_medium == expected_medium

    async def test_forgot_then_confirm_resets_password(self, provider: CognitoProvider) -> None:
        # Arrange
        username = "bob"
        old_password = "Password1A"
        new_password = "NewPass1B"
        await provider.sign_up(username, old_password)
        await provider.forgot_password("test-client-id", username)
        code = await provider.store.create_password_reset_code(username)

        # Act
        await provider.confirm_forgot_password("test-client-id", username, code, new_password)

        # Assert
        result = await provider.initiate_auth("USER_PASSWORD_AUTH", username, new_password)
        assert "AuthenticationResult" in result
