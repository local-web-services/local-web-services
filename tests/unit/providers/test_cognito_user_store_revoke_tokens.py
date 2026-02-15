"""Tests for UserStore revoke refresh tokens operation."""

from __future__ import annotations

from pathlib import Path
from typing import Any

import pytest

from lws.providers.cognito.user_store import (
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


class TestUserStoreRevokeTokens:
    """Revoke refresh tokens clears stored tokens."""

    async def test_revoke_clears_all_tokens(self, store: UserStore) -> None:
        # Arrange
        username = "alice"
        await store.store_refresh_token("token1", username, 1000.0)
        await store.store_refresh_token("token2", username, 1001.0)

        # Act
        await store.revoke_refresh_tokens(username)

        # Assert
        actual_token1 = await store.get_refresh_token_username("token1")
        actual_token2 = await store.get_refresh_token_username("token2")
        assert actual_token1 is None
        assert actual_token2 is None

    async def test_revoke_does_not_affect_other_users(self, store: UserStore) -> None:
        # Arrange
        await store.store_refresh_token("alice-token", "alice", 1000.0)
        await store.store_refresh_token("bob-token", "bob", 1001.0)

        # Act
        await store.revoke_refresh_tokens("alice")

        # Assert
        actual_alice = await store.get_refresh_token_username("alice-token")
        actual_bob = await store.get_refresh_token_username("bob-token")
        assert actual_alice is None
        expected_bob = "bob"
        assert actual_bob == expected_bob
