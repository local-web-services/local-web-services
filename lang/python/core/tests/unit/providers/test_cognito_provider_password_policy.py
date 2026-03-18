"""Tests for CognitoProvider - user store, sign-up, sign-in, and triggers."""

from __future__ import annotations

from pathlib import Path
from typing import Any

import pytest

from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.user_store import (
    InvalidPasswordException,
    PasswordPolicy,
    UserPoolConfig,
    UserStore,
    validate_password,
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


class TestPasswordPolicy:
    """Password validation against policy rules."""

    def test_valid_password(self) -> None:
        policy = PasswordPolicy()
        validate_password("StrongPass1", policy)

    def test_too_short(self) -> None:
        policy = PasswordPolicy(minimum_length=8)
        with pytest.raises(InvalidPasswordException, match="at least 8"):
            validate_password("Sh0rt", policy)

    def test_missing_lowercase(self) -> None:
        policy = PasswordPolicy(require_lowercase=True)
        with pytest.raises(InvalidPasswordException, match="lowercase"):
            validate_password("ALLCAPS123", policy)

    def test_missing_uppercase(self) -> None:
        policy = PasswordPolicy(require_uppercase=True)
        with pytest.raises(InvalidPasswordException, match="uppercase"):
            validate_password("alllower123", policy)

    def test_missing_digit(self) -> None:
        policy = PasswordPolicy(require_digits=True)
        with pytest.raises(InvalidPasswordException, match="digit"):
            validate_password("NoDigitsHere", policy)

    def test_missing_symbol(self) -> None:
        policy = PasswordPolicy(require_symbols=True)
        with pytest.raises(InvalidPasswordException, match="symbol"):
            validate_password("NoSymbol1A", policy)

    def test_symbol_accepted(self) -> None:
        policy = PasswordPolicy(require_symbols=True)
        validate_password("HasSymbol1A!", policy)
