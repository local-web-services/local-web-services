"""Tests for CognitoProvider - user store, sign-up, sign-in, and triggers."""

from __future__ import annotations

from pathlib import Path
from typing import Any

import pytest

from ldk.providers.cognito.provider import CognitoProvider
from ldk.providers.cognito.user_store import (
    InvalidParameterException,
    InvalidPasswordException,
    NotAuthorizedException,
    PasswordPolicy,
    UsernameExistsException,
    UserNotConfirmedException,
    UserNotFoundException,
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


# ---------------------------------------------------------------------------
# UserStore Tests
# ---------------------------------------------------------------------------


class TestUserStoreSignUp:
    """User sign-up operations."""

    async def test_sign_up_returns_sub(self, store: UserStore) -> None:
        sub = await store.sign_up("alice", "Password1A")
        assert sub is not None
        assert len(sub) > 0

    async def test_sign_up_duplicate_rejected(self, store: UserStore) -> None:
        await store.sign_up("alice", "Password1A")
        with pytest.raises(UsernameExistsException):
            await store.sign_up("alice", "Password1A")

    async def test_sign_up_stores_attributes(self, store: UserStore) -> None:
        await store.sign_up("alice", "Password1A", {"email": "alice@example.com"})
        user = await store.get_user("alice")
        assert user is not None
        assert user["attributes"]["email"] == "alice@example.com"

    async def test_sign_up_auto_confirmed(self, store: UserStore) -> None:
        await store.sign_up("alice", "Password1A")
        user = await store.get_user("alice")
        assert user is not None
        assert user["confirmed"] is True


class TestUserStoreSignUpNoAutoConfirm:
    """Sign-up with auto_confirm=False."""

    async def test_not_auto_confirmed(self, tmp_path: Path) -> None:
        config = _default_config(auto_confirm=False)
        s = UserStore(tmp_path, config)
        await s.start()
        try:
            await s.sign_up("bob", "Password1A")
            user = await s.get_user("bob")
            assert user is not None
            assert user["confirmed"] is False
        finally:
            await s.stop()


class TestUserStoreRequiredAttributes:
    """Required attribute validation."""

    async def test_missing_required_attribute(self, tmp_path: Path) -> None:
        config = _default_config(required_attributes=["email"])
        s = UserStore(tmp_path, config)
        await s.start()
        try:
            with pytest.raises(InvalidParameterException, match="email"):
                await s.sign_up("alice", "Password1A", {})
        finally:
            await s.stop()

    async def test_required_attribute_provided(self, tmp_path: Path) -> None:
        config = _default_config(required_attributes=["email"])
        s = UserStore(tmp_path, config)
        await s.start()
        try:
            sub = await s.sign_up("alice", "Password1A", {"email": "a@b.com"})
            assert sub is not None
        finally:
            await s.stop()


class TestUserStoreConfirmation:
    """User confirmation operations."""

    async def test_confirm_sign_up(self, tmp_path: Path) -> None:
        config = _default_config(auto_confirm=False)
        s = UserStore(tmp_path, config)
        await s.start()
        try:
            await s.sign_up("bob", "Password1A")
            await s.confirm_sign_up("bob")
            user = await s.get_user("bob")
            assert user is not None
            assert user["confirmed"] is True
        finally:
            await s.stop()

    async def test_confirm_nonexistent_user(self, store: UserStore) -> None:
        with pytest.raises(UserNotFoundException):
            await store.confirm_sign_up("nonexistent")


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


class TestUserStoreRefreshTokens:
    """Refresh token storage and lookup."""

    async def test_store_and_retrieve_refresh_token(self, store: UserStore) -> None:
        await store.store_refresh_token("token123", "alice", 1000.0)
        username = await store.get_refresh_token_username("token123")
        assert username == "alice"

    async def test_unknown_refresh_token(self, store: UserStore) -> None:
        username = await store.get_refresh_token_username("unknown")
        assert username is None


# ---------------------------------------------------------------------------
# CognitoProvider Tests
# ---------------------------------------------------------------------------


class TestProviderLifecycle:
    """Provider lifecycle operations."""

    async def test_name(self, provider: CognitoProvider) -> None:
        assert provider.name == "cognito"

    async def test_health_check_running(self, provider: CognitoProvider) -> None:
        assert await provider.health_check() is True

    async def test_health_check_stopped(self, tmp_path: Path) -> None:
        config = _default_config()
        p = CognitoProvider(data_dir=tmp_path, config=config)
        assert await p.health_check() is False


class TestProviderSignUp:
    """Provider sign-up operations."""

    async def test_sign_up_auto_confirmed(self, provider: CognitoProvider) -> None:
        result = await provider.sign_up("alice", "Password1A", {"email": "a@b.com"})
        assert result["UserConfirmed"] is True
        assert "UserSub" in result

    async def test_sign_up_not_auto_confirmed(self, no_confirm_provider: CognitoProvider) -> None:
        result = await no_confirm_provider.sign_up("bob", "Password1A")
        assert result["UserConfirmed"] is False


class TestProviderAuth:
    """Provider authentication operations."""

    async def test_initiate_auth(self, provider: CognitoProvider) -> None:
        await provider.sign_up("alice", "Password1A")
        result = await provider.initiate_auth("USER_PASSWORD_AUTH", "alice", "Password1A")
        auth_result = result["AuthenticationResult"]
        assert "IdToken" in auth_result
        assert "AccessToken" in auth_result
        assert "RefreshToken" in auth_result
        assert auth_result["TokenType"] == "Bearer"

    async def test_unsupported_auth_flow(self, provider: CognitoProvider) -> None:
        from ldk.providers.cognito.user_store import CognitoError

        await provider.sign_up("alice", "Password1A")
        with pytest.raises(CognitoError, match="Unsupported"):
            await provider.initiate_auth("CUSTOM_AUTH", "alice", "Password1A")

    async def test_refresh_tokens(self, provider: CognitoProvider) -> None:
        await provider.sign_up("alice", "Password1A")
        result = await provider.initiate_auth("USER_PASSWORD_AUTH", "alice", "Password1A")
        refresh_token = result["AuthenticationResult"]["RefreshToken"]

        new_result = await provider.refresh_tokens(refresh_token)
        assert "AuthenticationResult" in new_result
        assert "IdToken" in new_result["AuthenticationResult"]

    async def test_invalid_refresh_token(self, provider: CognitoProvider) -> None:
        with pytest.raises(NotAuthorizedException, match="Invalid refresh token"):
            await provider.refresh_tokens("bad-token")


class TestProviderConfirmation:
    """Provider confirmation with triggers."""

    async def test_confirm_sign_up(self, no_confirm_provider: CognitoProvider) -> None:
        await no_confirm_provider.sign_up("bob", "Password1A")
        await no_confirm_provider.confirm_sign_up("bob")
        result = await no_confirm_provider.initiate_auth("USER_PASSWORD_AUTH", "bob", "Password1A")
        assert "AuthenticationResult" in result


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
