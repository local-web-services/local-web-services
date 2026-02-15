"""Tests for CognitoProvider global sign out."""

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


class TestCognitoProviderGlobalSignOut:
    """Global sign out revokes refresh tokens."""

    async def test_global_sign_out_revokes_refresh_tokens(self, provider: CognitoProvider) -> None:
        # Arrange
        username = "alice"
        password = "Password1A"
        await provider.sign_up(username, password)
        auth_result = await provider.initiate_auth("USER_PASSWORD_AUTH", username, password)
        access_token = auth_result["AuthenticationResult"]["AccessToken"]
        refresh_token = auth_result["AuthenticationResult"]["RefreshToken"]

        # Act
        await provider.global_sign_out(access_token)

        # Assert
        with pytest.raises(NotAuthorizedException):
            await provider.refresh_tokens(refresh_token)
