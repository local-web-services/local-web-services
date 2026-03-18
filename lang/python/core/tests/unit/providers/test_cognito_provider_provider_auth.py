"""Tests for CognitoProvider - user store, sign-up, sign-in, and triggers."""

from __future__ import annotations

from pathlib import Path
from typing import Any

import pytest

from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.user_store import (
    NotAuthorizedException,
    PasswordPolicy,
    UserPoolConfig,
    UserStore,
)

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


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


# ---------------------------------------------------------------------------
# Fixtures
# ---------------------------------------------------------------------------


@pytest.fixture
async def store(tmp_path: Path):
    """Create, start, yield, and stop a UserStore."""
    config = _default_config()
    s = UserStore(tmp_path, config)
    await s.start()
    yield s
    await s.stop()


@pytest.fixture
async def provider(tmp_path: Path):
    """Create, start, yield, and stop a CognitoProvider."""
    config = _default_config()
    p = CognitoProvider(data_dir=tmp_path, config=config)
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
async def no_confirm_provider(tmp_path: Path):
    """Provider with auto_confirm=False."""
    config = _default_config(auto_confirm=False)
    p = CognitoProvider(data_dir=tmp_path, config=config)
    await p.start()
    yield p
    await p.stop()


# ---------------------------------------------------------------------------
# Password Policy Tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# UserStore Tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# CognitoProvider Tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Lambda Trigger Tests
# ---------------------------------------------------------------------------


class TestProviderAuth:
    """Provider authentication operations."""

    async def test_initiate_auth(self, provider: CognitoProvider) -> None:
        # Arrange
        username = "alice"
        password = "Password1A"
        auth_flow = "USER_PASSWORD_AUTH"
        await provider.sign_up(username, password)

        # Act
        result = await provider.initiate_auth(auth_flow, username, password)

        # Assert
        expected_token_type = "Bearer"
        auth_result = result["AuthenticationResult"]
        assert "IdToken" in auth_result
        assert "AccessToken" in auth_result
        assert "RefreshToken" in auth_result
        actual_token_type = auth_result["TokenType"]
        assert actual_token_type == expected_token_type

    async def test_unsupported_auth_flow(self, provider: CognitoProvider) -> None:
        from lws.providers.cognito.user_store import CognitoError

        # Arrange
        username = "alice"
        password = "Password1A"
        await provider.sign_up(username, password)

        # Act / Assert
        with pytest.raises(CognitoError, match="Unsupported"):
            await provider.initiate_auth("CUSTOM_AUTH", username, password)

    async def test_refresh_tokens(self, provider: CognitoProvider) -> None:
        # Arrange
        username = "alice"
        password = "Password1A"
        auth_flow = "USER_PASSWORD_AUTH"
        await provider.sign_up(username, password)
        result = await provider.initiate_auth(auth_flow, username, password)
        refresh_token = result["AuthenticationResult"]["RefreshToken"]

        # Act
        new_result = await provider.refresh_tokens(refresh_token)

        # Assert
        assert "AuthenticationResult" in new_result
        assert "IdToken" in new_result["AuthenticationResult"]

    async def test_invalid_refresh_token(self, provider: CognitoProvider) -> None:
        with pytest.raises(NotAuthorizedException, match="Invalid refresh token"):
            await provider.refresh_tokens("bad-token")
