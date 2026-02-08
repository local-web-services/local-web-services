"""Tests for CognitoProvider - user store, sign-up, sign-in, and triggers."""

from __future__ import annotations

from pathlib import Path
from typing import Any

import pytest

from ldk.providers.cognito.provider import CognitoProvider
from ldk.providers.cognito.user_store import (
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


class TestLambdaTriggers:
    """Pre-auth and post-confirmation trigger invocation."""

    async def test_pre_auth_trigger_called(self, tmp_path: Path) -> None:
        called_with: list[dict] = []

        async def pre_auth(event: dict) -> dict:
            called_with.append(event)
            return {"response": {}}

        config = _default_config(pre_authentication_trigger="preAuth")
        p = CognitoProvider(
            data_dir=tmp_path,
            config=config,
            trigger_functions={"preAuth": pre_auth},
        )
        await p.start()
        try:
            await p.sign_up("alice", "Password1A")
            await p.initiate_auth("USER_PASSWORD_AUTH", "alice", "Password1A")
            assert len(called_with) == 1
            assert called_with[0]["triggerSource"] == "PreAuthentication_Authentication"
            assert called_with[0]["userName"] == "alice"
        finally:
            await p.stop()

    async def test_post_confirmation_trigger_called(self, tmp_path: Path) -> None:
        called_with: list[dict] = []

        async def post_confirm(event: dict) -> dict:
            called_with.append(event)
            return {"response": {}}

        config = _default_config(
            auto_confirm=False,
            post_confirmation_trigger="postConfirm",
        )
        p = CognitoProvider(
            data_dir=tmp_path,
            config=config,
            trigger_functions={"postConfirm": post_confirm},
        )
        await p.start()
        try:
            await p.sign_up("alice", "Password1A")
            await p.confirm_sign_up("alice")
            assert len(called_with) == 1
            assert called_with[0]["triggerSource"] == "PostConfirmation_ConfirmSignUp"
            assert called_with[0]["userName"] == "alice"
        finally:
            await p.stop()

    async def test_post_confirmation_on_auto_confirm(self, tmp_path: Path) -> None:
        called_with: list[dict] = []

        async def post_confirm(event: dict) -> dict:
            called_with.append(event)
            return {"response": {}}

        config = _default_config(
            auto_confirm=True,
            post_confirmation_trigger="postConfirm",
        )
        p = CognitoProvider(
            data_dir=tmp_path,
            config=config,
            trigger_functions={"postConfirm": post_confirm},
        )
        await p.start()
        try:
            await p.sign_up("alice", "Password1A")
            # Post-confirmation called during sign-up when auto_confirm=True
            assert len(called_with) == 1
        finally:
            await p.stop()

    async def test_pre_auth_trigger_not_configured(self, provider: CognitoProvider) -> None:
        """No trigger configured - should not raise."""
        await provider.sign_up("alice", "Password1A")
        result = await provider.initiate_auth("USER_PASSWORD_AUTH", "alice", "Password1A")
        assert "AuthenticationResult" in result
