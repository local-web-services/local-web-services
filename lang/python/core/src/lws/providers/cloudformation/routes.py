"""AWS CloudFormation HTTP routes.

Implements the CloudFormation query-string wire protocol that AWS SDKs use,
using form-encoded request bodies with XML responses.
"""

from __future__ import annotations

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsChaosMiddleware, ErrorFormat
from lws.providers._shared.aws_operation_fake import AwsFakeConfig, AwsOperationFakeMiddleware
from lws.providers._shared.per_account_state import (
    DEFAULT_ACCOUNT_ID,
    PerAccountStateRegistry,
    extract_account_id_from_token,
)
from lws.providers._shared.provider_context import ProviderContext
from lws.providers._shared.service_descriptor import ServiceDescriptor
from lws.providers.cloudformation._cfn_handlers import _ACTION_HANDLERS
from lws.providers.cloudformation._cfn_state import _CfnState

_logger = get_logger("ldk.cloudformation")


def create_cloudformation_app(
    registry: PerAccountStateRegistry[_CfnState] | None = None,
    chaos: AwsChaosConfig | None = None,
    aws_fake: AwsFakeConfig | None = None,
) -> FastAPI:
    """Create a FastAPI application that speaks the CloudFormation wire protocol."""
    if registry is None:
        registry = PerAccountStateRegistry(_CfnState)
    app = FastAPI(title="LDK CloudFormation")
    if aws_fake is not None:
        app.add_middleware(
            AwsOperationFakeMiddleware, fake_config=aws_fake, service="cloudformation"
        )
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.XML_IAM)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="cloudformation")

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        """Route a single CloudFormation request to the appropriate handler."""
        form = await request.form()
        params = {k: str(v) for k, v in form.items()}
        token = request.headers.get("X-Amz-Security-Token", "")
        account_id = extract_account_id_from_token(token) if token else DEFAULT_ACCOUNT_ID
        state = registry.get(account_id)
        action = params.get("Action", "")
        handler = _ACTION_HANDLERS.get(action)
        if handler is None:
            _logger.warning("Unknown CloudFormation action: %s", action)
            return Response(
                content=(
                    "<ErrorResponse>"
                    "<Error><Type>Sender</Type><Code>InvalidAction</Code>"
                    f"<Message>lws: CloudFormation operation '{action}' is not yet implemented"
                    "</Message></Error>"
                    "</ErrorResponse>"
                ),
                status_code=400,
                media_type="text/xml",
            )
        return await handler(state, params, account_id)

    return app


def _cloudformation_factory(  # pylint: disable=unused-argument
    chaos: AwsChaosConfig | None = None,
    aws_fake: AwsFakeConfig | None = None,
    context: ProviderContext | None = None,
) -> tuple[FastAPI, None]:
    return create_cloudformation_app(chaos=chaos, aws_fake=aws_fake), None


DESCRIPTOR = ServiceDescriptor(name="cloudformation", factory=_cloudformation_factory)
