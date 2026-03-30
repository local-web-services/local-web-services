"""Cognito HTTP routes using the AWS Cognito JSON protocol."""

from __future__ import annotations

import jwt
from fastapi import APIRouter, FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_capacity import AwsCapacityConfig, check_capacity
from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsChaosMiddleware, ErrorFormat
from lws.providers._shared.aws_iam_auth import IamAuthBundle, add_iam_auth_middleware
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers._shared.aws_operation_fake import AwsFakeConfig, AwsOperationFakeMiddleware
from lws.providers.cognito._cognito_routes_groups import _CognitoGroupRoutesMixin
from lws.providers.cognito._cognito_routes_helpers import error_response as _error_response
from lws.providers.cognito._cognito_routes_helpers import json_response as _json_response
from lws.providers.cognito.provider import CognitoProvider
from lws.providers.cognito.user_store import CognitoError

_logger = get_logger("ldk.cognito")

# Prefix the AWS SDK uses in the X-Amz-Target header.
_TARGET_PREFIX = "AWSCognitoIdentityProviderService."


class CognitoRouter(_CognitoGroupRoutesMixin):
    """Route Cognito wire-protocol requests to the CognitoProvider."""

    def __init__(
        self,
        provider: CognitoProvider,
        lifecycle: ResourceLifecycleConfig | None = None,
        capacity: AwsCapacityConfig | None = None,
    ) -> None:
        self._provider = provider
        self._lc = lifecycle or ResourceLifecycleConfig()
        self._tracker = ResourceStateTracker(self._lc)
        self._capacity = capacity or AwsCapacityConfig()
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
            "AdminInitiateAuth": self._admin_initiate_auth,
            "RespondToAuthChallenge": self._respond_to_auth_challenge,
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
            "AdminDisableUser": self._admin_disable_user,
            "AdminEnableUser": self._admin_enable_user,
            "AdminGetUser": self._admin_get_user,
            "AdminConfirmSignUp": self._admin_confirm_sign_up,
            "AdminSetUserPassword": self._admin_set_user_password,
            "AdminResetUserPassword": self._admin_reset_user_password,
            "AdminUpdateUserAttributes": self._admin_update_user_attributes,
            "UpdateUserPool": self._update_user_pool,
            "ListUsers": self._list_users,
            "ForgotPassword": self._forgot_password,
            "ConfirmForgotPassword": self._confirm_forgot_password,
            "ChangePassword": self._change_password,
            "GlobalSignOut": self._global_sign_out,
            "CreateGroup": self._create_group,
            "DeleteGroup": self._delete_group,
            "AdminAddUserToGroup": self._admin_add_user_to_group,
            "AdminRemoveUserFromGroup": self._admin_remove_user_from_group,
            "ListGroups": self._list_groups,
            "ListUsersInGroup": self._list_users_in_group,
        }

    async def _jwks(self) -> Response:
        """Return the JWKS for token verification."""
        jwks = self._provider.token_issuer.get_jwks()
        return _json_response(jwks)

    async def _sign_up(self, body: dict) -> Response:
        """Handle SignUp operation."""
        cap_err = check_capacity(self._capacity, "TooManyRequestsException", 400)
        if cap_err is not None:
            return cap_err
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
        cap_err = check_capacity(self._capacity, "TooManyRequestsException", 400)
        if cap_err is not None:
            return cap_err
        auth_flow = body.get("AuthFlow", "")
        auth_params = body.get("AuthParameters", {})
        username = auth_params.get("USERNAME", "")
        password = auth_params.get("PASSWORD", "")

        result = await self._provider.initiate_auth(auth_flow, username, password)
        return _json_response(result)

    async def _create_user_pool(self, body: dict) -> Response:
        pool_name = body.get("PoolName", "default")
        config = self._provider.config
        if config.user_pool_name == pool_name:
            return _error_response(
                "ResourceInUseException",
                f"User pool with name '{pool_name}' already exists",
            )
        config.user_pool_name = pool_name
        pool_id = config.user_pool_id
        arn = f"arn:aws:cognito-idp:us-east-1:000000000000:userpool/{pool_id}"
        resp = _json_response(
            {
                "UserPool": {
                    "Id": pool_id,
                    "Name": pool_name,
                    "Status": "Enabled",
                    "Arn": arn,
                }
            }
        )
        if self._lc.enabled and self._lc.create_dwell_ms > 0:
            self._tracker.set_state(pool_id, "CREATING")
            self._tracker.schedule_transition(pool_id, "ACTIVE", self._lc.create_dwell_ms)
        return resp

    async def _delete_user_pool(self, body: dict) -> Response:
        """Handle DeleteUserPool operation."""
        pool_id = body.get("UserPoolId", "")
        if self._lc.enabled:
            state = self._tracker.get_state(pool_id)
            if state == "CREATING":
                return _error_response(
                    "InvalidParameterException",
                    f"User pool {pool_id} is still being created",
                )
        config = self._provider.config
        if pool_id == config.user_pool_id:
            config.user_pool_name = ""
        if self._lc.enabled:
            if self._lc.delete_dwell_ms > 0:
                self._tracker.set_state(pool_id, "DELETING")
                self._tracker.schedule_transition(pool_id, None, self._lc.delete_dwell_ms)
            else:
                self._tracker.remove(pool_id)
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

    def _check_pool_state(self, pool_id: str) -> Response | None:
        """Return an error response if *pool_id* is in a non-ACTIVE lifecycle state.

        Returns ``None`` when the operation may proceed.
        """
        if not self._lc.enabled:
            return None
        state = self._tracker.get_state(pool_id)
        if state in ("CREATING", "DELETING"):
            return _error_response(
                "ResourceNotFoundException",
                f"User pool {pool_id} does not exist (status: {state})",
            )
        return None

    async def _describe_user_pool(self, _body: dict) -> Response:
        """Handle DescribeUserPool operation."""
        config = self._provider.config
        pool_id = config.user_pool_id
        err = self._check_pool_state(pool_id)
        if err is not None:
            return err
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
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
        client_name = body.get("ClientName", "")
        explicit_auth_flows = body.get("ExplicitAuthFlows")
        result = await self._provider.create_user_pool_client(
            user_pool_id, client_name, explicit_auth_flows
        )
        return _json_response(result)

    async def _delete_user_pool_client(self, body: dict) -> Response:
        """Handle DeleteUserPoolClient operation."""
        user_pool_id = body.get("UserPoolId", "")
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
        client_id = body.get("ClientId", "")
        await self._provider.delete_user_pool_client(user_pool_id, client_id)
        return _json_response({})

    async def _describe_user_pool_client(self, body: dict) -> Response:
        """Handle DescribeUserPoolClient operation."""
        user_pool_id = body.get("UserPoolId", "")
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
        client_id = body.get("ClientId", "")
        result = await self._provider.describe_user_pool_client(user_pool_id, client_id)
        return _json_response(result)

    async def _list_user_pool_clients(self, body: dict) -> Response:
        """Handle ListUserPoolClients operation."""
        user_pool_id = body.get("UserPoolId", "")
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
        result = await self._provider.list_user_pool_clients(user_pool_id)
        return _json_response(result)

    async def _admin_create_user(self, body: dict) -> Response:
        """Handle AdminCreateUser operation."""
        if self._capacity.is_exhausted:
            return _error_response("ServiceUnavailableException", "lws: no user slots available")
        user_pool_id = body.get("UserPoolId", "")
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
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
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
        username = body.get("Username", "")
        await self._provider.admin_delete_user(user_pool_id, username)
        return _json_response({})

    async def _admin_get_user(self, body: dict) -> Response:
        """Handle AdminGetUser operation."""
        user_pool_id = body.get("UserPoolId", "")
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
        username = body.get("Username", "")
        result = await self._provider.admin_get_user(user_pool_id, username)
        return _json_response(result)

    async def _update_user_pool(self, body: dict) -> Response:
        """Handle UpdateUserPool operation."""
        user_pool_id = body.get("UserPoolId", "")
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
        lambda_config = body.get("LambdaConfig")
        result = await self._provider.update_user_pool(user_pool_id, lambda_config=lambda_config)
        return _json_response(result)

    async def _admin_disable_user(self, body: dict) -> Response:
        """Handle AdminDisableUser operation."""
        user_pool_id = body.get("UserPoolId", "")
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
        username = body.get("Username", "")
        await self._provider.admin_disable_user(user_pool_id, username)
        return _json_response({})

    async def _admin_enable_user(self, body: dict) -> Response:
        """Handle AdminEnableUser operation."""
        user_pool_id = body.get("UserPoolId", "")
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
        username = body.get("Username", "")
        await self._provider.admin_enable_user(user_pool_id, username)
        return _json_response({})

    # Group operation handlers are inherited from _CognitoGroupRoutesMixin.

    async def _list_users(self, body: dict) -> Response:
        """Handle ListUsers operation."""
        user_pool_id = body.get("UserPoolId", "")
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
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

    async def _admin_initiate_auth(self, body: dict) -> Response:
        """Handle AdminInitiateAuth operation."""
        cap_err = check_capacity(self._capacity, "TooManyRequestsException", 400)
        if cap_err is not None:
            return cap_err
        user_pool_id = body.get("UserPoolId", "")
        auth_flow = body.get("AuthFlow", "")
        auth_params = body.get("AuthParameters", {})
        username = auth_params.get("USERNAME", "")
        password = auth_params.get("PASSWORD", "")
        result = await self._provider.admin_initiate_auth(
            user_pool_id, auth_flow, username, password
        )
        return _json_response(result)

    async def _respond_to_auth_challenge(self, body: dict) -> Response:
        """Handle RespondToAuthChallenge operation."""
        client_id = body.get("ClientId", "")
        challenge_name = body.get("ChallengeName", "")
        session = body.get("Session", "")
        challenge_responses = body.get("ChallengeResponses", {})
        result = await self._provider.respond_to_auth_challenge(
            client_id, challenge_name, session, challenge_responses
        )
        return _json_response(result)

    async def _admin_confirm_sign_up(self, body: dict) -> Response:
        """Handle AdminConfirmSignUp operation."""
        user_pool_id = body.get("UserPoolId", "")
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
        username = body.get("Username", "")
        await self._provider.admin_confirm_sign_up(user_pool_id, username)
        return _json_response({})

    async def _admin_set_user_password(self, body: dict) -> Response:
        """Handle AdminSetUserPassword operation."""
        user_pool_id = body.get("UserPoolId", "")
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
        username = body.get("Username", "")
        password = body.get("Password", "")
        permanent = body.get("Permanent", True)
        await self._provider.admin_set_user_password(user_pool_id, username, password, permanent)
        return _json_response({})

    async def _admin_reset_user_password(self, body: dict) -> Response:
        """Handle AdminResetUserPassword operation."""
        user_pool_id = body.get("UserPoolId", "")
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
        username = body.get("Username", "")
        await self._provider.admin_reset_user_password(user_pool_id, username)
        return _json_response({})

    async def _admin_update_user_attributes(self, body: dict) -> Response:
        """Handle AdminUpdateUserAttributes operation."""
        user_pool_id = body.get("UserPoolId", "")
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
        username = body.get("Username", "")
        user_attributes = _parse_user_attributes(body.get("UserAttributes", []))
        await self._provider.admin_update_user_attributes(user_pool_id, username, user_attributes)
        return _json_response({})


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _parse_user_attributes(attrs: list[dict]) -> dict[str, str]:
    """Convert Cognito UserAttributes list format to a flat dict."""
    return {attr["Name"]: attr["Value"] for attr in attrs if "Name" in attr and "Value" in attr}


# ---------------------------------------------------------------------------
# App factory
# ---------------------------------------------------------------------------


def create_cognito_app(
    provider: CognitoProvider,
    chaos: AwsChaosConfig | None = None,
    aws_fake: AwsFakeConfig | None = None,
    iam_auth: IamAuthBundle | None = None,
    lifecycle: ResourceLifecycleConfig | None = None,
    capacity: AwsCapacityConfig | None = None,
) -> FastAPI:
    """Create a FastAPI application that speaks the Cognito wire protocol."""
    app = FastAPI(title="LDK Cognito")
    if aws_fake is not None:
        app.add_middleware(AwsOperationFakeMiddleware, fake_config=aws_fake, service="cognito-idp")
    add_iam_auth_middleware(app, "cognito-idp", iam_auth, ErrorFormat.JSON)
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.JSON)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="cognito")
    cognito_router = CognitoRouter(provider, lifecycle=lifecycle, capacity=capacity)
    app.include_router(cognito_router.router)
    return app
