"""Cognito User Pool provider for local development."""

from __future__ import annotations

import time
import uuid
from collections.abc import Callable, Coroutine
from pathlib import Path
from typing import Any

from lws.interfaces.provider import Provider
from lws.logging.logger import get_logger
from lws.providers.cognito.tokens import TokenIssuer
from lws.providers.cognito.user_store import (
    CognitoError,
    NotAuthorizedException,
    UserPoolConfig,
    UserStore,
    validate_password,
)

_logger = get_logger("ldk.cognito")

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
        # In-memory store for user pool clients (client_id -> client_info)
        self._clients: dict[str, dict[str, Any]] = {}

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

    # -- User Pool Client Management ------------------------------------------

    async def create_user_pool_client(
        self,
        user_pool_id: str,
        client_name: str,
        explicit_auth_flows: list[str] | None = None,
    ) -> dict[str, Any]:
        """Create a new user pool client. Returns the client info."""
        self._validate_user_pool_id(user_pool_id)
        client_id = str(uuid.uuid4()).replace("-", "")[:26]
        client_info: dict[str, Any] = {
            "ClientId": client_id,
            "ClientName": client_name,
            "UserPoolId": user_pool_id,
        }
        if explicit_auth_flows:
            client_info["ExplicitAuthFlows"] = explicit_auth_flows
        self._clients[client_id] = client_info
        return {"UserPoolClient": client_info}

    async def delete_user_pool_client(
        self,
        user_pool_id: str,
        client_id: str,
    ) -> None:
        """Delete a user pool client."""
        self._validate_user_pool_id(user_pool_id)
        if client_id not in self._clients:
            raise CognitoError(
                "ResourceNotFoundException",
                f"User pool client {client_id} does not exist.",
            )
        del self._clients[client_id]

    async def describe_user_pool_client(
        self,
        user_pool_id: str,
        client_id: str,
    ) -> dict[str, Any]:
        """Describe a user pool client."""
        self._validate_user_pool_id(user_pool_id)
        if client_id not in self._clients:
            raise CognitoError(
                "ResourceNotFoundException",
                f"User pool client {client_id} does not exist.",
            )
        return {"UserPoolClient": self._clients[client_id]}

    async def list_user_pool_clients(
        self,
        user_pool_id: str,
    ) -> dict[str, Any]:
        """List all user pool clients for a given pool."""
        self._validate_user_pool_id(user_pool_id)
        clients = [c for c in self._clients.values() if c["UserPoolId"] == user_pool_id]
        return {"UserPoolClients": clients}

    # -- Admin User Operations ------------------------------------------------

    async def admin_create_user(
        self,
        user_pool_id: str,
        username: str,
        temporary_password: str | None = None,
        user_attributes: dict[str, str] | None = None,
    ) -> dict[str, Any]:
        """Create a user as an admin."""
        self._validate_user_pool_id(user_pool_id)
        user = await self._store.admin_create_user(username, temporary_password, user_attributes)
        attrs_list = [{"Name": k, "Value": v} for k, v in user["attributes"].items()]
        attrs_list.append({"Name": "sub", "Value": user["sub"]})
        return {
            "User": {
                "Username": user["username"],
                "Attributes": attrs_list,
                "UserStatus": "CONFIRMED" if user["confirmed"] else "UNCONFIRMED",
                "Enabled": True,
            }
        }

    async def admin_delete_user(
        self,
        user_pool_id: str,
        username: str,
    ) -> None:
        """Delete a user as an admin."""
        self._validate_user_pool_id(user_pool_id)
        await self._store.admin_delete_user(username)

    async def admin_get_user(
        self,
        user_pool_id: str,
        username: str,
    ) -> dict[str, Any]:
        """Get user details as an admin."""
        self._validate_user_pool_id(user_pool_id)
        user = await self._store.admin_get_user(username)
        attrs_list = [{"Name": k, "Value": v} for k, v in user["attributes"].items()]
        attrs_list.append({"Name": "sub", "Value": user["sub"]})
        return {
            "Username": user["username"],
            "UserAttributes": attrs_list,
            "UserStatus": "CONFIRMED" if user["confirmed"] else "UNCONFIRMED",
            "Enabled": True,
        }

    async def update_user_pool(
        self,
        user_pool_id: str,
    ) -> dict[str, Any]:
        """Update a user pool. Currently a no-op that validates the pool exists."""
        self._validate_user_pool_id(user_pool_id)
        return {}

    async def list_users(
        self,
        user_pool_id: str,
    ) -> dict[str, Any]:
        """List users in a user pool."""
        self._validate_user_pool_id(user_pool_id)
        users = await self._store.list_users()
        result = []
        for user in users:
            attrs_list = [{"Name": k, "Value": v} for k, v in user["attributes"].items()]
            attrs_list.append({"Name": "sub", "Value": user["sub"]})
            result.append(
                {
                    "Username": user["username"],
                    "Attributes": attrs_list,
                    "UserStatus": "CONFIRMED" if user["confirmed"] else "UNCONFIRMED",
                    "Enabled": True,
                }
            )
        return {"Users": result}

    # -- Password recovery and sign-out ---------------------------------------

    async def forgot_password(
        self,
        _client_id: str,
        username: str,
    ) -> dict[str, Any]:
        """Initiate a password reset. Returns CodeDeliveryDetails."""
        code = await self._store.create_password_reset_code(username)
        # In a local environment, we log the code so the developer can use it.
        _logger.info("Password reset code for %s: %s", username, code)
        return {
            "CodeDeliveryDetails": {
                "Destination": "***",
                "DeliveryMedium": "EMAIL",
                "AttributeName": "email",
            }
        }

    async def confirm_forgot_password(
        self,
        _client_id: str,
        username: str,
        confirmation_code: str,
        password: str,
    ) -> None:
        """Confirm a password reset with the code and new password."""
        validate_password(password, self._config.password_policy)
        await self._store.confirm_password_reset(username, confirmation_code, password)

    async def change_password(
        self,
        access_token: str,
        previous_password: str,
        proposed_password: str,
    ) -> None:
        """Change a user's password using an access token."""
        claims = self._token_issuer.decode_token(access_token, token_use="access")
        username = claims.get("cognito:username", "")
        if not username:
            raise NotAuthorizedException("Invalid access token.")
        validate_password(proposed_password, self._config.password_policy)
        await self._store.change_password(username, previous_password, proposed_password)

    async def global_sign_out(self, access_token: str) -> None:
        """Sign out a user by revoking all refresh tokens."""
        claims = self._token_issuer.decode_token(access_token, token_use="access")
        username = claims.get("cognito:username", "")
        if not username:
            raise NotAuthorizedException("Invalid access token.")
        await self._store.revoke_refresh_tokens(username)

    # -- Validation helpers ---------------------------------------------------

    def _validate_user_pool_id(self, user_pool_id: str) -> None:
        """Validate that the user pool ID matches the configured pool."""
        if user_pool_id != self._config.user_pool_id:
            raise CognitoError(
                "ResourceNotFoundException",
                f"User pool {user_pool_id} does not exist.",
            )

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
