"""SNS wire protocol HTTP routes.

Implements the SNS Action-based form-encoded API that AWS SDKs use.
Each request posts to ``/`` with an ``Action`` parameter that selects
the operation.  Responses use the standard AWS SNS XML format.
"""

from __future__ import annotations

import uuid
from typing import Any

from fastapi import FastAPI, Request, Response

from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_capacity import AwsCapacityConfig
from lws.providers._shared.aws_chaos import (
    AwsChaosConfig,
    AwsChaosMiddleware,
    ErrorFormat,
)
from lws.providers._shared.aws_iam_auth import IamAuthBundle, add_iam_auth_middleware
from lws.providers._shared.aws_lifecycle import (
    ResourceLifecycleConfig,
    ResourceStateTracker,
)
from lws.providers._shared.aws_operation_fake import (
    AwsFakeConfig,
    AwsOperationFakeMiddleware,
)
from lws.providers.sns._sns_handlers import _ACTION_HANDLERS
from lws.providers.sns.provider import SnsProvider

_logger = get_logger("ldk.sns")


async def _parse_form(request: Request) -> dict[str, str]:
    """Parse the form-encoded body of an SNS request."""
    form = await request.form()
    return {k: str(v) for k, v in form.items()}


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


_SNS_TOPIC_ACTIONS = {
    "Publish",
    "Subscribe",
    "GetTopicAttributes",
    "SetTopicAttributes",
    "ListSubscriptionsByTopic",
    "ListTagsForResource",
    "TagResource",
    "UntagResource",
}


def _check_sns_topic_lifecycle(
    action: str,
    params: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response | None:
    """Check lifecycle state for topic actions."""
    if not lc.enabled or action not in _SNS_TOPIC_ACTIONS:
        return None
    topic_arn = params.get("TopicArn") or params.get("ResourceArn") or ""
    if not topic_arn:
        return None
    topic_name = topic_arn.rsplit(":", 1)[-1] if ":" in topic_arn else topic_arn
    state = tracker.get_state(topic_name)
    if state in ("CREATING", "DELETING"):
        xml = (
            "<ErrorResponse><Error>"
            "<Code>NotFound</Code>"
            f"<Message>Topic not found: {topic_arn} (status: {state})</Message>"
            "</Error>"
            f"<RequestId>{uuid.uuid4()}</RequestId>"
            "</ErrorResponse>"
        )
        return Response(content=xml, status_code=404, media_type="text/xml")
    return None


async def _handle_sns_lifecycle(
    action: str,
    handler: Any,
    provider: SnsProvider,
    params: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response | None:
    """Handle lifecycle-aware SNS operations. Returns None to fall through."""
    if action == "CreateTopic" and lc.create_dwell_ms > 0:
        return await _lifecycle_create_topic(handler, provider, params, lc, tracker)
    if action == "DeleteTopic":
        return await _lifecycle_delete_topic(handler, provider, params, lc, tracker)
    return None


async def _lifecycle_create_topic(
    handler: Any,
    provider: SnsProvider,
    params: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle lifecycle for CreateTopic."""
    resp = await handler(provider, params)
    if resp.status_code == 200:
        topic_name = params.get("Name", "")
        tracker.set_state(topic_name, "CREATING")
        tracker.schedule_transition(topic_name, "ACTIVE", lc.create_dwell_ms)
    return resp


async def _lifecycle_delete_topic(
    handler: Any,
    provider: SnsProvider,
    params: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle lifecycle for DeleteTopic."""
    topic_arn = params.get("TopicArn", "")
    topic_name = topic_arn.rsplit(":", 1)[-1] if ":" in topic_arn else topic_arn
    if tracker.get_state(topic_name) == "CREATING":
        xml = (
            "<ErrorResponse><Error>"
            "<Code>ResourceInUseException</Code>"
            f"<Message>Topic {topic_arn} is still being created</Message>"
            "</Error>"
            f"<RequestId>{uuid.uuid4()}</RequestId>"
            "</ErrorResponse>"
        )
        return Response(content=xml, status_code=400, media_type="text/xml")
    resp = await handler(provider, params)
    if resp.status_code == 200:
        if lc.delete_dwell_ms > 0:
            tracker.set_state(topic_name, "DELETING")
            tracker.schedule_transition(topic_name, None, lc.delete_dwell_ms)
        else:
            tracker.remove(topic_name)
    return resp


async def _sns_dispatch(
    request: Request,
    provider: SnsProvider,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
    sqs_capacity: AwsCapacityConfig | None = None,
) -> Response:
    """Route a single SNS request."""
    params = await _parse_form(request)
    action = params.get("Action", "")

    err = _check_sns_topic_lifecycle(action, params, lc, tracker)
    if err is not None:
        return err

    if action == "Publish" and sqs_capacity is not None and sqs_capacity.is_exhausted:
        xml = (
            "<ErrorResponse><Error>"
            "<Code>ServiceUnavailableException</Code>"
            "<Message>lws: no message slots available</Message>"
            "</Error>"
            f"<RequestId>{uuid.uuid4()}</RequestId>"
            "</ErrorResponse>"
        )
        return Response(content=xml, status_code=503, media_type="text/xml")

    handler = _ACTION_HANDLERS.get(action)
    if handler is None:
        _logger.warning("Unknown SNS action: %s", action)
        xml = (
            "<ErrorResponse>"
            "<Error>"
            "<Type>Sender</Type>"
            "<Code>InvalidAction</Code>"
            f"<Message>lws: SNS operation '{action}' is not yet implemented</Message>"
            "</Error>"
            f"<RequestId>{uuid.uuid4()}</RequestId>"
            "</ErrorResponse>"
        )
        return Response(content=xml, status_code=400, media_type="text/xml")

    if lc.enabled:
        result = await _handle_sns_lifecycle(
            action, handler, provider, params, lc, tracker
        )
        if result is not None:
            return result

    return await handler(provider, params)


def create_sns_app(
    provider: SnsProvider,
    chaos: AwsChaosConfig | None = None,
    aws_fake: AwsFakeConfig | None = None,
    iam_auth: IamAuthBundle | None = None,
    lifecycle: ResourceLifecycleConfig | None = None,
    sqs_capacity: AwsCapacityConfig | None = None,
) -> FastAPI:
    """Create a FastAPI application that speaks the SNS wire protocol."""
    _lc = lifecycle or ResourceLifecycleConfig()
    _tracker = ResourceStateTracker(_lc)

    app = FastAPI(title="LDK SNS")
    if aws_fake is not None:
        app.add_middleware(
            AwsOperationFakeMiddleware, fake_config=aws_fake, service="sns"
        )
    add_iam_auth_middleware(app, "sns", iam_auth, ErrorFormat.XML_IAM)
    if chaos is not None:
        app.add_middleware(
            AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.XML_IAM
        )
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="sns")

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        return await _sns_dispatch(request, provider, _lc, _tracker, sqs_capacity)

    return app
