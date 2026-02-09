"""Tests for CognitoProvider - user store, sign-up, sign-in, and triggers."""

from __future__ import annotations

from pathlib import Path
from typing import Any

import pytest

from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.user_store import (
    NotAuthorizedException,
    PasswordPolicy,
    UserNotConfirmedException,
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


class TestUserStoreAuthentication:
    """User authentication operations."""

    async def test_successful_auth(self, store: UserStore) -> None:
        await store.sign_up("alice", "Password1A")
        user_info = await store.authenticate("alice", "Password1A")
        assert user_info["username"] == "alice"
        assert "sub" in user_info

    async def test_wrong_password(self, store: UserStore) -> None:
        await store.sign_up("alice", "Password1A")
        with pytest.raises(NotAuthorizedException):
            await store.authenticate("alice", "WrongPass1")

    async def test_nonexistent_user(self, store: UserStore) -> None:
        with pytest.raises(NotAuthorizedException):
            await store.authenticate("nobody", "Password1A")

    async def test_unconfirmed_user(self, tmp_path: Path) -> None:
        config = _default_config(auto_confirm=False)
        s = UserStore(tmp_path, config)
        await s.start()
        try:
            await s.sign_up("bob", "Password1A")
            with pytest.raises(UserNotConfirmedException):
                await s.authenticate("bob", "Password1A")
        finally:
            await s.stop()
