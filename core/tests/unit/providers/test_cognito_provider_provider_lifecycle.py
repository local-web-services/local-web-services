"""Tests for CognitoProvider - user store, sign-up, sign-in, and triggers."""

from __future__ import annotations

from pathlib import Path
from typing import Any

import pytest

from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.user_store import (
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


class TestProviderLifecycle:
    """Provider lifecycle operations."""

    async def test_name(self, provider: CognitoProvider) -> None:
        expected_name = "cognito"
        actual_name = provider.name
        assert actual_name == expected_name

    async def test_health_check_running(self, provider: CognitoProvider) -> None:
        assert await provider.health_check() is True

    async def test_health_check_stopped(self, tmp_path: Path) -> None:
        config = _default_config()
        p = CognitoProvider(data_dir=tmp_path, config=config)
        assert await p.health_check() is False
