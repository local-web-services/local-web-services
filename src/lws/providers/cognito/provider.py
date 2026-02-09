"""Cognito User Pool provider for local development."""

from __future__ import annotations

import time
from collections.abc import Callable, Coroutine
from pathlib import Path
from typing import Any

from lws.interfaces.provider import Provider
from lws.providers.cognito.tokens import TokenIssuer
from lws.providers.cognito.user_store import (
    CognitoError,
    NotAuthorizedException,
    UserPoolConfig,
    UserStore,
)

# Type alias for Lambda trigger callables
TriggerFunc = Callable[[dict], Coroutine[Any, Any, dict]]


class CognitoProvider(Provider):
    """Local Cognito User Pool provider.

    Manages user sign-up, sign-in (with JWT tokens), confirmation,
    and optional Lambda triggers (pre-authentication, post-confirmation).

    Parameters
    ----------
    data_dir : Path
        Directory for persistent SQLite storage.
    config : UserPoolConfig
        User pool configuration parsed from CDK cloud assembly.
    trigger_functions : dict[str, TriggerFunc] | None
        Map of trigger names to async callables for Lambda trigger invocation.
    """

    def __init__(
        self,
        data_dir: Path,
        config: UserPoolConfig,
        trigger_functions: dict[str, TriggerFunc] | None = None,
    ) -> None:
        self._data_dir = data_dir
        self._config = config
        self._store = UserStore(data_dir, config)
        self._token_issuer = TokenIssuer(
            user_pool_id=config.user_pool_id,
            client_id=config.client_id or "local-client-id",
        )
        self._triggers = trigger_functions or {}

    # -- Provider lifecycle ---------------------------------------------------

    @property
    def name(self) -> str:
        return "cognito"

    async def start(self) -> None:
        """Start the user store."""
        await self._store.start()

    async def stop(self) -> None:
        """Stop the user store."""
        await self._store.stop()

    async def health_check(self) -> bool:
        """Check if the user store is healthy."""
        return await self._store.is_healthy()

    # -- Public API -----------------------------------------------------------

    @property
    def store(self) -> UserStore:
        """Return the underlying user store."""
        return self._store

    @property
    def token_issuer(self) -> TokenIssuer:
        """Return the token issuer."""
        return self._token_issuer

    @property
    def config(self) -> UserPoolConfig:
        """Return the user pool configuration."""
        return self._config

    async def sign_up(
        self,
        username: str,
        password: str,
        attributes: dict[str, str] | None = None,
    ) -> dict[str, Any]:
        """Register a new user. Returns sign-up result dict."""
        sub = await self._store.sign_up(username, password, attributes)
        result: dict[str, Any] = {
            "UserConfirmed": self._config.auto_confirm,
            "UserSub": sub,
        }
        # Post-confirmation trigger (if auto-confirmed)
        if self._config.auto_confirm:
            await self._invoke_post_confirmation(username, sub, attributes or {})
        return result

    async def confirm_sign_up(self, username: str) -> None:
        """Confirm a user's account and invoke post-confirmation trigger."""
        await self._store.confirm_sign_up(username)
        user = await self._store.get_user(username)
        if user:
            await self._invoke_post_confirmation(username, user["sub"], user["attributes"])

    async def initiate_auth(
        self,
        auth_flow: str,
        username: str,
        password: str,
    ) -> dict[str, Any]:
        """Authenticate a user and return tokens.

        Supports USER_PASSWORD_AUTH flow.
        Raises CognitoError on failure.
        """
        if auth_flow != "USER_PASSWORD_AUTH":
            raise CognitoError(
                "InvalidParameterException",
                f"Unsupported auth flow: {auth_flow}",
            )

        # Pre-authentication trigger
        await self._invoke_pre_authentication(username)

        # Authenticate
        user_info = await self._store.authenticate(username, password)

        # Generate tokens
        return await self._generate_auth_result(user_info)

    async def refresh_tokens(self, refresh_token: str) -> dict[str, Any]:
        """Refresh tokens using a refresh token."""
        username = await self._store.get_refresh_token_username(refresh_token)
        if username is None:
            raise NotAuthorizedException("Invalid refresh token.")

        user = await self._store.get_user(username)
        if user is None:
            raise NotAuthorizedException("User not found.")

        return await self._generate_auth_result(user)

    # -- Lambda Triggers ------------------------------------------------------

    async def _invoke_pre_authentication(self, username: str) -> None:
        """Invoke the pre-authentication Lambda trigger if configured."""
        trigger_name = self._config.pre_authentication_trigger
        if not trigger_name or trigger_name not in self._triggers:
            return

        event = _build_pre_auth_event(
            username=username,
            user_pool_id=self._config.user_pool_id,
            client_id=self._config.client_id or "local-client-id",
        )

        trigger_fn = self._triggers[trigger_name]
        result = await trigger_fn(event)

        response = result.get("response", {})
        if not response:
            return
        # If the trigger explicitly denies, raise NotAuthorizedException
        if response.get("autoConfirmUser") is False:
            raise NotAuthorizedException("Pre-authentication denied by trigger.")

    async def _invoke_post_confirmation(
        self,
        username: str,
        sub: str,
        attributes: dict[str, str],
    ) -> None:
        """Invoke the post-confirmation Lambda trigger if configured."""
        trigger_name = self._config.post_confirmation_trigger
        if not trigger_name or trigger_name not in self._triggers:
            return

        event = _build_post_confirmation_event(
            username=username,
            sub=sub,
            attributes=attributes,
            user_pool_id=self._config.user_pool_id,
            client_id=self._config.client_id or "local-client-id",
        )

        trigger_fn = self._triggers[trigger_name]
        await trigger_fn(event)

    # -- Private helpers -------------------------------------------------------

    async def _generate_auth_result(self, user_info: dict) -> dict[str, Any]:
        """Generate authentication result with tokens."""
        sub = user_info["sub"]
        username = user_info["username"]
        attributes = user_info.get("attributes", {})

        id_token = self._token_issuer.issue_id_token(sub, username, attributes)
        access_token = self._token_issuer.issue_access_token(sub, username)
        refresh_token = self._token_issuer.generate_refresh_token()

        await self._store.store_refresh_token(refresh_token, username, time.time())

        return {
            "AuthenticationResult": {
                "IdToken": id_token,
                "AccessToken": access_token,
                "RefreshToken": refresh_token,
                "ExpiresIn": 3600,
                "TokenType": "Bearer",
            }
        }


# ---------------------------------------------------------------------------
# Trigger event builders
# ---------------------------------------------------------------------------


def _build_pre_auth_event(
    username: str,
    user_pool_id: str,
    client_id: str,
) -> dict[str, Any]:
    """Build a Cognito pre-authentication trigger event."""
    return {
        "version": "1",
        "triggerSource": "PreAuthentication_Authentication",
        "region": "us-east-1",
        "userPoolId": user_pool_id,
        "callerContext": {
            "awsSdkVersion": "ldk-local",
            "clientId": client_id,
        },
        "userName": username,
        "request": {
            "userAttributes": {},
        },
        "response": {},
    }


def _build_post_confirmation_event(
    username: str,
    sub: str,
    attributes: dict[str, str],
    user_pool_id: str,
    client_id: str,
) -> dict[str, Any]:
    """Build a Cognito post-confirmation trigger event."""
    user_attributes = dict(attributes)
    user_attributes["sub"] = sub
    return {
        "version": "1",
        "triggerSource": "PostConfirmation_ConfirmSignUp",
        "region": "us-east-1",
        "userPoolId": user_pool_id,
        "callerContext": {
            "awsSdkVersion": "ldk-local",
            "clientId": client_id,
        },
        "userName": username,
        "request": {
            "userAttributes": user_attributes,
        },
        "response": {},
    }
