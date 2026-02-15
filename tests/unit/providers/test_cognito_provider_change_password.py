"""Tests for CognitoProvider change password via access token."""

from __future__ import annotations

from pathlib import Path
from typing import Any

import pytest

from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.user_store import (
    NotAuthorizedException,
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


class TestCognitoProviderChangePassword:
    """Change password via access token."""

    async def test_change_password_success(self, provider: CognitoProvider) -> None:
        # Arrange
        username = "alice"
        old_password = "Password1A"
        new_password = "NewPass1B"
        await provider.sign_up(username, old_password)
        auth_result = await provider.initiate_auth("USER_PASSWORD_AUTH", username, old_password)
        access_token = auth_result["AuthenticationResult"]["AccessToken"]

        # Act
        await provider.change_password(access_token, old_password, new_password)

        # Assert
        result = await provider.initiate_auth("USER_PASSWORD_AUTH", username, new_password)
        assert "AuthenticationResult" in result

    async def test_change_password_wrong_old_raises(self, provider: CognitoProvider) -> None:
        # Arrange
        username = "bob"
        password = "Password1A"
        await provider.sign_up(username, password)
        auth_result = await provider.initiate_auth("USER_PASSWORD_AUTH", username, password)
        access_token = auth_result["AuthenticationResult"]["AccessToken"]

        # Act
        # Assert
        with pytest.raises(NotAuthorizedException):
            await provider.change_password(access_token, "WrongPass1", "NewPass1B")
