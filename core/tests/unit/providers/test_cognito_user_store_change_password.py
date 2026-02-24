"""Tests for UserStore change password operation."""

from __future__ import annotations

from pathlib import Path
from typing import Any

import pytest

from lws.providers.cognito.user_store import (
    NotAuthorizedException,
    PasswordPolicy,
    UserPoolConfig,
    UserStore,
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
async def store(tmp_path: Path):
    """Create, start, yield, and stop a UserStore."""
    config = _default_config()
    s = UserStore(tmp_path, config)
    await s.start()
    yield s
    await s.stop()


class TestUserStoreChangePassword:
    """Change password success and wrong old password tests."""

    async def test_change_password_success(self, store: UserStore) -> None:
        # Arrange
        username = "alice"
        old_password = "Password1A"
        new_password = "NewPass1B"
        await store.sign_up(username, old_password)

        # Act
        await store.change_password(username, old_password, new_password)

        # Assert
        user_info = await store.authenticate(username, new_password)
        actual_username = user_info["username"]
        expected_username = username
        assert actual_username == expected_username

    async def test_change_password_wrong_old_password_raises(self, store: UserStore) -> None:
        # Arrange
        username = "bob"
        password = "Password1A"
        await store.sign_up(username, password)

        # Act
        # Assert
        with pytest.raises(NotAuthorizedException):
            await store.change_password(username, "WrongPass1", "NewPass1B")
