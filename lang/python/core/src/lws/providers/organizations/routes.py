"""AWS Organizations HTTP routes.

Implements the Organizations wire protocol that AWS SDKs use,
using JSON request/response format with X-Amz-Target header dispatch.
"""

from __future__ import annotations

from fastapi import FastAPI, Request, Response

from lws.interfaces.cloudtrail import ICloudTrail  # noqa: TC001
from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsChaosMiddleware, ErrorFormat
from lws.providers._shared.aws_cloudtrail_middleware import apply_cloudtrail_middleware
from lws.providers._shared.aws_operation_fake import AwsFakeConfig, AwsOperationFakeMiddleware
from lws.providers.organizations._org_handlers import (
    _ACTION_HANDLERS,
    _error_response,
)
from lws.providers.organizations._org_state import _OrganizationsState

_logger = get_logger("ldk.organizations")

_TARGET_PREFIXES = (
    "AmazonOrganizationsV20161128.",
    "AWSOrganizationsV20161128.",
)


def create_organizations_app(
    chaos: AwsChaosConfig | None = None,
    aws_fake: AwsFakeConfig | None = None,
    cloudtrail_provider: ICloudTrail | None = None,
) -> tuple[FastAPI, _OrganizationsState]:
    """Create a FastAPI application that speaks the AWS Organizations wire protocol.

    Returns a tuple of (app, state) so callers can retain a reference to the
    state object for later inspection or reset.
    """
    app = FastAPI(title="LDK Organizations")
    if aws_fake is not None:
        app.add_middleware(
            AwsOperationFakeMiddleware, fake_config=aws_fake, service="organizations"
        )
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.JSON)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="organizations")
    state = _OrganizationsState()

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        """Route a single Organizations request to the appropriate handler."""
        target = request.headers.get("X-Amz-Target", "")
        action = target
        for prefix in _TARGET_PREFIXES:
            if target.startswith(prefix):
                action = target[len(prefix) :]
                break
        body = await request.json()
        handler = _ACTION_HANDLERS.get(action)
        if handler is None:
            _logger.warning("Unknown Organizations action: %s", action)
            return _error_response(
                "InvalidAction",
                f"lws: Organizations operation '{action}' is not yet implemented",
            )
        return await handler(state, body)

    apply_cloudtrail_middleware(app, cloudtrail_provider, "organizations")
    return app, state
