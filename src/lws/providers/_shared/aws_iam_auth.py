"""IAM authorization middleware for AWS service providers.

Intercepts requests, resolves the caller identity, looks up required
IAM actions for the operation, evaluates policies, and either denies
(enforce mode) or logs (audit mode) unauthorized requests.
"""

from __future__ import annotations

import time
from dataclasses import dataclass
from typing import Any

from starlette.middleware.base import BaseHTTPMiddleware, RequestResponseEndpoint
from starlette.requests import Request
from starlette.responses import Response

from lws.config.loader import IamAuthConfig
from lws.logging.logger import LdkLogger, get_logger
from lws.providers._shared.aws_chaos import (
    AwsErrorSpec,
    ErrorFormat,
    format_error,
)
from lws.providers._shared.aws_operation_mock import extract_operation_from_request
from lws.providers._shared.iam_identity_store import IdentityStore
from lws.providers._shared.iam_permissions_map import PermissionsMap
from lws.providers._shared.iam_policy_engine import (
    Decision,
    EvaluationContext,
    evaluate,
)
from lws.providers._shared.iam_resource_policies import ResourcePolicyStore

_logger: LdkLogger = get_logger("ldk.iam_auth")


def _build_iam_eval(
    identity_name: str,
    decision: str,
    reason: str,
    actions: list[str],
    mode: str,
) -> dict[str, Any]:
    """Build a serialisable IAM evaluation result dict."""
    return {
        "identity": identity_name,
        "decision": decision,
        "reason": reason,
        "actions": actions,
        "mode": mode,
    }


async def _read_request_body(request: Request) -> str | None:
    """Safely read up to 10 KB of the request body for logging."""
    try:
        body = await request.body()
        if body and len(body) < 10240:
            return body.decode("utf-8", errors="replace")
    except Exception:  # pylint: disable=broad-except
        pass
    return None


class AwsIamAuthMiddleware(BaseHTTPMiddleware):
    """ASGI middleware that enforces IAM authorization on AWS requests."""

    def __init__(
        self,
        app: Any,
        *,
        iam_auth_config: IamAuthConfig,
        service: str,
        identity_store: IdentityStore,
        permissions_map: PermissionsMap,
        resource_policy_store: ResourcePolicyStore,
        error_format: ErrorFormat,
    ) -> None:
        super().__init__(app)
        self._config = iam_auth_config
        self._service = service
        self._identity_store = identity_store
        self._permissions_map = permissions_map
        self._resource_policy_store = resource_policy_store
        self._error_format = error_format

    async def dispatch(self, request: Request, call_next: RequestResponseEndpoint) -> Response:
        """Evaluate IAM authorization before forwarding the request."""
        mode = self._effective_mode()
        if mode == "disabled":
            return await call_next(request)

        operation = await extract_operation_from_request(request, self._service)
        if operation is None:
            return await call_next(request)

        required_actions = self._permissions_map.get_required_actions(self._service, operation)
        if required_actions is None:
            return await call_next(request)

        t0 = time.monotonic()
        identity_name = self._resolve_identity(request)
        identity = self._identity_store.get_identity(identity_name)

        if identity is None:
            return await self._handle_unknown_identity(
                request, call_next, identity_name, required_actions, mode, operation, t0
            )

        context = EvaluationContext(
            principal=identity_name,
            actions=required_actions,
            resource="*",
            identity_policies=identity.inline_policies,
            boundary_policy=identity.boundary_policy,
            resource_policy=self._resource_policy_store.get_policy(self._service, "*"),
        )

        decision, reason = evaluate(context)
        eval_info = _build_iam_eval(
            identity_name,
            "ALLOW" if decision == Decision.ALLOW else "DENY",
            reason,
            required_actions,
            mode,
        )

        if decision == Decision.DENY:
            return await self._handle_deny(
                request, call_next, eval_info, operation, identity_name, reason, mode, t0
            )

        request.state.iam_eval = eval_info
        return await call_next(request)

    async def _handle_unknown_identity(
        self,
        request: Request,
        call_next: RequestResponseEndpoint,
        identity_name: str,
        required_actions: list[str],
        mode: str,
        operation: str,
        t0: float,
    ) -> Response:
        """Handle a request from an unrecognised identity."""
        eval_info = _build_iam_eval(
            identity_name, "DENY", "Unknown identity", required_actions, mode
        )
        if mode == "enforce":
            duration_ms = (time.monotonic() - t0) * 1000
            body = await _read_request_body(request)
            _logger.log_iam_deny(
                method=request.method,
                path=str(request.url.path),
                operation=operation,
                service=self._service,
                duration_ms=duration_ms,
                iam_eval=eval_info,
                request_body=body,
            )
            return self._deny_response(operation, identity_name)
        _logger.warning(
            "IAM audit: unknown identity %r for %s:%s",
            identity_name,
            self._service,
            operation,
        )
        request.state.iam_eval = eval_info
        return await call_next(request)

    async def _handle_deny(
        self,
        request: Request,
        call_next: RequestResponseEndpoint,
        eval_info: dict[str, Any],
        operation: str,
        identity_name: str,
        reason: str,
        mode: str,
        t0: float,
    ) -> Response:
        """Handle an IAM DENY decision."""
        if mode == "enforce":
            duration_ms = (time.monotonic() - t0) * 1000
            body = await _read_request_body(request)
            _logger.log_iam_deny(
                method=request.method,
                path=str(request.url.path),
                operation=operation,
                service=self._service,
                duration_ms=duration_ms,
                iam_eval=eval_info,
                request_body=body,
            )
            return self._deny_response(operation, identity_name, reason)
        _logger.warning(
            "IAM audit: DENY %s:%s for %s (%s)",
            self._service,
            operation,
            identity_name,
            reason,
        )
        request.state.iam_eval = eval_info
        return await call_next(request)

    def _effective_mode(self) -> str:
        """Return the effective mode for this service."""
        svc_config = self._config.services.get(self._service)
        if svc_config is not None and svc_config.mode is not None:
            return svc_config.mode
        return self._config.mode

    def _resolve_identity(self, request: Request) -> str:
        """Resolve the caller identity from header or default."""
        header = self._config.identity_header
        identity = request.headers.get(header.lower(), "")
        if identity:
            return identity
        return self._config.default_identity

    def _deny_response(
        self,
        operation: str,
        identity: str,
        reason: str = "Access Denied",
    ) -> Response:
        """Build an access-denied error response."""
        if self._error_format == ErrorFormat.XML_S3:
            error = AwsErrorSpec(
                type="AccessDenied",
                message=f"User {identity} is not authorized to perform "
                f"{self._service}:{operation}: {reason}",
                status_code=403,
            )
        else:
            error = AwsErrorSpec(
                type="AccessDeniedException",
                message=f"User {identity} is not authorized to perform "
                f"{self._service}:{operation}: {reason}",
                status_code=403,
            )
        return format_error(error, self._error_format)


@dataclass
class IamAuthBundle:
    """Groups all IAM auth dependencies for passing to route factories."""

    config: IamAuthConfig
    identity_store: IdentityStore
    permissions_map: PermissionsMap
    resource_policy_store: ResourcePolicyStore


def add_iam_auth_middleware(
    app: Any,
    service: str,
    iam_auth: IamAuthBundle | None,
    error_format: ErrorFormat,
) -> None:
    """Add IAM auth middleware to an app if IAM auth is configured."""
    if iam_auth is None:
        return
    app.add_middleware(
        AwsIamAuthMiddleware,
        iam_auth_config=iam_auth.config,
        service=service,
        identity_store=iam_auth.identity_store,
        permissions_map=iam_auth.permissions_map,
        resource_policy_store=iam_auth.resource_policy_store,
        error_format=error_format,
    )
