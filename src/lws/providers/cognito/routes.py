"""Cognito HTTP routes using the AWS Cognito JSON protocol."""

from __future__ import annotations

import json

import jwt
from fastapi import APIRouter, FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsChaosMiddleware, ErrorFormat
from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.user_store import CognitoError

_logger = get_logger("ldk.cognito")

# Prefix the AWS SDK uses in the X-Amz-Target header.
_TARGET_PREFIX = "AWSCognitoIdentityProviderService."


class CognitoRouter:
    """Route Cognito wire-protocol requests to the CognitoProvider."""

    def __init__(self, provider: CognitoProvider) -> None:
        self._provider = provider
        self.router = APIRouter()
        self.router.add_api_route("/", self._dispatch, methods=["POST"])
        self.router.add_api_route("/.well-known/jwks.json", self._jwks, methods=["GET"])

    async def _dispatch(self, request: Request) -> Response:
        """Dispatch a Cognito API request based on X-Amz-Target header."""
        target = request.headers.get("X-Amz-Target", "")
        if not target.startswith(_TARGET_PREFIX):
            return _error_response("ValidationException", f"Unknown target: {target}")

        operation = target[len(_TARGET_PREFIX) :]
        body = await request.json()

        handler = self._handlers().get(operation)
        if handler is None:
            _logger.warning("Unknown Cognito operation: %s", operation)
            return _error_response(
                "UnknownOperationException",
                f"lws: Cognito operation '{operation}' is not yet implemented",
            )

        try:
            return await handler(body)
        except CognitoError as exc:
            return _error_response(exc.code, str(exc))

    def _handlers(self) -> dict:
        """Return the operation handler map."""
        return {
            "SignUp": self._sign_up,
            "ConfirmSignUp": self._confirm_sign_up,
            "InitiateAuth": self._initiate_auth,
            "CreateUserPool": self._create_user_pool,
            "DeleteUserPool": self._delete_user_pool,
            "ListUserPools": self._list_user_pools,
            "DescribeUserPool": self._describe_user_pool,
            "CreateUserPoolClient": self._create_user_pool_client,
            "DeleteUserPoolClient": self._delete_user_pool_client,
            "DescribeUserPoolClient": self._describe_user_pool_client,
            "ListUserPoolClients": self._list_user_pool_clients,
            "AdminCreateUser": self._admin_create_user,
            "AdminDeleteUser": self._admin_delete_user,
            "AdminGetUser": self._admin_get_user,
            "UpdateUserPool": self._update_user_pool,
            "ListUsers": self._list_users,
            "ForgotPassword": self._forgot_password,
            "ConfirmForgotPassword": self._confirm_forgot_password,
            "ChangePassword": self._change_password,
            "GlobalSignOut": self._global_sign_out,
        }

    async def _jwks(self) -> Response:
        """Return the JWKS for token verification."""
        jwks = self._provider.token_issuer.get_jwks()
        return _json_response(jwks)

    async def _sign_up(self, body: dict) -> Response:
        """Handle SignUp operation."""
        username = body.get("Username", "")
        password = body.get("Password", "")
        user_attributes = _parse_user_attributes(body.get("UserAttributes", []))

        result = await self._provider.sign_up(username, password, user_attributes)
        return _json_response(result)

    async def _confirm_sign_up(self, body: dict) -> Response:
        """Handle ConfirmSignUp operation."""
        username = body.get("Username", "")
        await self._provider.confirm_sign_up(username)
        return _json_response({})

    async def _initiate_auth(self, body: dict) -> Response:
        """Handle InitiateAuth operation."""
        auth_flow = body.get("AuthFlow", "")
        auth_params = body.get("AuthParameters", {})
        username = auth_params.get("USERNAME", "")
        password = auth_params.get("PASSWORD", "")

        result = await self._provider.initiate_auth(auth_flow, username, password)
        return _json_response(result)

    async def _create_user_pool(self, body: dict) -> Response:
        """Handle CreateUserPool operation."""
        pool_name = body.get("PoolName", "default")
        config = self._provider.config
        config.user_pool_name = pool_name
        pool_id = config.user_pool_id
        arn = f"arn:aws:cognito-idp:us-east-1:000000000000:userpool/{pool_id}"
        return _json_response(
            {
                "UserPool": {
                    "Id": pool_id,
                    "Name": pool_name,
                    "Status": "Enabled",
                    "Arn": arn,
                }
            }
        )

    async def _delete_user_pool(self, body: dict) -> Response:
        """Handle DeleteUserPool operation."""
        pool_id = body.get("UserPoolId", "")
        config = self._provider.config
        if pool_id == config.user_pool_id:
            config.user_pool_name = ""
        return _json_response({})

    async def _list_user_pools(self, _body: dict) -> Response:
        """Handle ListUserPools operation."""
        config = self._provider.config
        pools = []
        if config.user_pool_name:
            pools.append(
                {
                    "Id": config.user_pool_id,
                    "Name": config.user_pool_name,
                    "Status": "Enabled",
                }
            )
        return _json_response({"UserPools": pools})

    async def _describe_user_pool(self, _body: dict) -> Response:
        """Handle DescribeUserPool operation."""
        config = self._provider.config
        pool_id = config.user_pool_id
        arn = f"arn:aws:cognito-idp:us-east-1:000000000000:userpool/{pool_id}"
        return _json_response(
            {
                "UserPool": {
                    "Id": pool_id,
                    "Name": config.user_pool_name,
                    "Status": "Enabled",
                    "Arn": arn,
                }
            }
        )

    async def _create_user_pool_client(self, body: dict) -> Response:
        """Handle CreateUserPoolClient operation."""
        user_pool_id = body.get("UserPoolId", "")
        client_name = body.get("ClientName", "")
        explicit_auth_flows = body.get("ExplicitAuthFlows")
        result = await self._provider.create_user_pool_client(
            user_pool_id, client_name, explicit_auth_flows
        )
        return _json_response(result)

    async def _delete_user_pool_client(self, body: dict) -> Response:
        """Handle DeleteUserPoolClient operation."""
        user_pool_id = body.get("UserPoolId", "")
        client_id = body.get("ClientId", "")
        await self._provider.delete_user_pool_client(user_pool_id, client_id)
        return _json_response({})

    async def _describe_user_pool_client(self, body: dict) -> Response:
        """Handle DescribeUserPoolClient operation."""
        user_pool_id = body.get("UserPoolId", "")
        client_id = body.get("ClientId", "")
        result = await self._provider.describe_user_pool_client(user_pool_id, client_id)
        return _json_response(result)

    async def _list_user_pool_clients(self, body: dict) -> Response:
        """Handle ListUserPoolClients operation."""
        user_pool_id = body.get("UserPoolId", "")
        result = await self._provider.list_user_pool_clients(user_pool_id)
        return _json_response(result)

    async def _admin_create_user(self, body: dict) -> Response:
        """Handle AdminCreateUser operation."""
        user_pool_id = body.get("UserPoolId", "")
        username = body.get("Username", "")
        temporary_password = body.get("TemporaryPassword")
        user_attributes = _parse_user_attributes(body.get("UserAttributes", []))
        result = await self._provider.admin_create_user(
            user_pool_id, username, temporary_password, user_attributes or None
        )
        return _json_response(result)

    async def _admin_delete_user(self, body: dict) -> Response:
        """Handle AdminDeleteUser operation."""
        user_pool_id = body.get("UserPoolId", "")
        username = body.get("Username", "")
        await self._provider.admin_delete_user(user_pool_id, username)
        return _json_response({})

    async def _admin_get_user(self, body: dict) -> Response:
        """Handle AdminGetUser operation."""
        user_pool_id = body.get("UserPoolId", "")
        username = body.get("Username", "")
        result = await self._provider.admin_get_user(user_pool_id, username)
        return _json_response(result)

    async def _update_user_pool(self, body: dict) -> Response:
        """Handle UpdateUserPool operation."""
        user_pool_id = body.get("UserPoolId", "")
        result = await self._provider.update_user_pool(user_pool_id)
        return _json_response(result)

    async def _list_users(self, body: dict) -> Response:
        """Handle ListUsers operation."""
        user_pool_id = body.get("UserPoolId", "")
        result = await self._provider.list_users(user_pool_id)
        return _json_response(result)

    async def _forgot_password(self, body: dict) -> Response:
        """Handle ForgotPassword operation."""
        client_id = body.get("ClientId", "")
        username = body.get("Username", "")
        result = await self._provider.forgot_password(client_id, username)
        return _json_response(result)

    async def _confirm_forgot_password(self, body: dict) -> Response:
        """Handle ConfirmForgotPassword operation."""
        client_id = body.get("ClientId", "")
        username = body.get("Username", "")
        confirmation_code = body.get("ConfirmationCode", "")
        password = body.get("Password", "")
        await self._provider.confirm_forgot_password(
            client_id, username, confirmation_code, password
        )
        return _json_response({})

    async def _change_password(self, body: dict) -> Response:
        """Handle ChangePassword operation."""
        access_token = body.get("AccessToken", "")
        previous_password = body.get("PreviousPassword", "")
        proposed_password = body.get("ProposedPassword", "")
        try:
            await self._provider.change_password(access_token, previous_password, proposed_password)
        except jwt.InvalidTokenError:
            return _error_response("NotAuthorizedException", "Invalid access token.")
        return _json_response({})

    async def _global_sign_out(self, body: dict) -> Response:
        """Handle GlobalSignOut operation."""
        access_token = body.get("AccessToken", "")
        try:
            await self._provider.global_sign_out(access_token)
        except jwt.InvalidTokenError:
            return _error_response("NotAuthorizedException", "Invalid access token.")
        return _json_response({})


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _parse_user_attributes(attrs: list[dict]) -> dict[str, str]:
    """Convert Cognito UserAttributes list format to a flat dict."""
    return {attr["Name"]: attr["Value"] for attr in attrs if "Name" in attr and "Value" in attr}


def _json_response(data: dict, status_code: int = 200) -> Response:
    """Create a JSON response with the Cognito content type."""
    return Response(
        content=json.dumps(data),
        status_code=status_code,
        media_type="application/x-amz-json-1.1",
    )


def _error_response(error_type: str, message: str) -> Response:
    """Create an error response."""
    return _json_response(
        {"__type": error_type, "message": message},
        status_code=400,
    )


# ---------------------------------------------------------------------------
# App factory
# ---------------------------------------------------------------------------


def create_cognito_app(
    provider: CognitoProvider,
    chaos: AwsChaosConfig | None = None,
) -> FastAPI:
    """Create a FastAPI application that speaks the Cognito wire protocol."""
    app = FastAPI(title="LDK Cognito")
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.JSON)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="cognito")
    cognito_router = CognitoRouter(provider)
    app.include_router(cognito_router.router)
    return app
