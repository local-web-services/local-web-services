"""AWS CloudTrail HTTP routes.

Implements the CloudTrail wire protocol that AWS SDKs use,
using JSON request/response format with X-Amz-Target header dispatch.
"""

from __future__ import annotations

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsChaosMiddleware, ErrorFormat
from lws.providers._shared.aws_operation_fake import AwsFakeConfig, AwsOperationFakeMiddleware
from lws.providers.cloudtrail._cloudtrail_handlers import (
    _ACTION_HANDLERS,
    _error_response,
)
from lws.providers.cloudtrail._cloudtrail_state import _CloudTrailState

_logger = get_logger("ldk.cloudtrail")

_TARGET_PREFIX = "CloudTrail_20131101."


def create_cloudtrail_app(
    chaos: AwsChaosConfig | None = None,
    aws_fake: AwsFakeConfig | None = None,
) -> tuple[FastAPI, _CloudTrailState]:
    """Create a FastAPI application that speaks the AWS CloudTrail wire protocol.

    Returns a tuple of (app, state) so callers can retain a reference to the
    state object for later inspection or reset.
    """
    app = FastAPI(title="LDK CloudTrail")
    if aws_fake is not None:
        app.add_middleware(AwsOperationFakeMiddleware, fake_config=aws_fake, service="cloudtrail")
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.JSON)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="cloudtrail")
    state = _CloudTrailState()

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        """Route a single CloudTrail request to the appropriate handler."""
        target = request.headers.get("X-Amz-Target", "")
        action = target
        if target.startswith(_TARGET_PREFIX):
            action = target[len(_TARGET_PREFIX) :]
        body = await request.json()
        handler = _ACTION_HANDLERS.get(action)
        if handler is None:
            _logger.warning("Unknown CloudTrail action: %s", action)
            return _error_response(
                "InvalidAction",
                f"lws: CloudTrail operation '{action}' is not yet implemented",
            )
        return await handler(state, body)

    return app, state
