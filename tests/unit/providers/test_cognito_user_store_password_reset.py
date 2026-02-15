"""Tests for UserStore password reset code operations."""

from __future__ import annotations

import time
from pathlib import Path
from typing import Any
from unittest.mock import patch

import pytest

from lws.providers.cognito.user_store import (
    CodeMismatchException,
    ExpiredCodeException,
    PasswordPolicy,
    UserNotFoundException,
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


class TestUserStorePasswordReset:
    """Password reset code create, confirm, expired, and wrong code tests."""

    async def test_create_and_confirm_reset_code(self, store: UserStore) -> None:
        # Arrange
        username = "alice"
        password = "Password1A"
        new_password = "NewPass1B"
        await store.sign_up(username, password)

        # Act
        code = await store.create_password_reset_code(username)
        await store.confirm_password_reset(username, code, new_password)

        # Assert
        user_info = await store.authenticate(username, new_password)
        actual_username = user_info["username"]
        expected_username = username
        assert actual_username == expected_username

    async def test_expired_code_raises(self, store: UserStore) -> None:
        # Arrange
        username = "bob"
        password = "Password1A"
        await store.sign_up(username, password)
        code = await store.create_password_reset_code(username)

        # Act
        # Assert
        with patch("lws.providers.cognito.user_store.time") as mock_time:
            mock_time.time.return_value = time.time() + 600
            with pytest.raises(ExpiredCodeException):
                await store.confirm_password_reset(username, code, "NewPass1B")

    async def test_wrong_code_raises(self, store: UserStore) -> None:
        # Arrange
        username = "carol"
        password = "Password1A"
        await store.sign_up(username, password)
        await store.create_password_reset_code(username)

        # Act
        # Assert
        with pytest.raises(CodeMismatchException):
            await store.confirm_password_reset(username, "000000", "NewPass1B")

    async def test_create_code_for_nonexistent_user_raises(self, store: UserStore) -> None:
        # Act
        # Assert
        with pytest.raises(UserNotFoundException):
            await store.create_password_reset_code("nobody")
