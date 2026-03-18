"""Tests for CognitoProvider - user store, sign-up, sign-in, and triggers."""

from __future__ import annotations

from pathlib import Path
from typing import Any

import pytest

from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.user_store import (
    PasswordPolicy,
    UsernameExistsException,
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


class TestUserStoreSignUp:
    """User sign-up operations."""

    async def test_sign_up_returns_sub(self, store: UserStore) -> None:
        sub = await store.sign_up("alice", "Password1A")
        assert sub is not None
        assert len(sub) > 0

    async def test_sign_up_duplicate_rejected(self, store: UserStore) -> None:
        # Arrange
        username = "alice"
        password = "Password1A"
        await store.sign_up(username, password)

        # Act / Assert
        with pytest.raises(UsernameExistsException):
            await store.sign_up(username, password)

    async def test_sign_up_stores_attributes(self, store: UserStore) -> None:
        # Arrange
        username = "alice"
        expected_email = "alice@example.com"

        # Act
        await store.sign_up(username, "Password1A", {"email": expected_email})
        user = await store.get_user(username)

        # Assert
        assert user is not None
        actual_email = user["attributes"]["email"]
        assert actual_email == expected_email

    async def test_sign_up_auto_confirmed(self, store: UserStore) -> None:
        # Arrange
        username = "alice"

        # Act
        await store.sign_up(username, "Password1A")
        user = await store.get_user(username)

        # Assert
        assert user is not None
        assert user["confirmed"] is True
