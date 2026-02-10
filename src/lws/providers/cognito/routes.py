"""Cognito HTTP routes using the AWS Cognito JSON protocol."""

from __future__ import annotations

import json

from fastapi import APIRouter, FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
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
        return _json_response({})

    async def _list_user_pools(self, body: dict) -> Response:
        """Handle ListUserPools operation."""
        config = self._provider.config
        return _json_response(
            {
                "UserPools": [
                    {
                        "Id": config.user_pool_id,
                        "Name": config.user_pool_name,
                        "Status": "Enabled",
                    }
                ]
            }
        )

    async def _describe_user_pool(self, body: dict) -> Response:
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


def create_cognito_app(provider: CognitoProvider) -> FastAPI:
    """Create a FastAPI application that speaks the Cognito wire protocol."""
    app = FastAPI(title="LDK Cognito")
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="cognito")
    cognito_router = CognitoRouter(provider)
    app.include_router(cognito_router.router)
    return app
