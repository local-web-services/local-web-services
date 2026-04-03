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
from lws.providers._shared.aws_cloudtrail_middleware import apply_cloudtrail_middleware
from lws.providers._shared.aws_iam_auth import IamAuthBundle, add_iam_auth_middleware
from lws.providers._shared.aws_lifecycle import (
    ResourceLifecycleConfig,
    ResourceStateTracker,
)
from lws.providers._shared.aws_operation_fake import (
    AwsFakeConfig,
    AwsOperationFakeMiddleware,
)
from lws.providers._shared.provider_context import ProviderContext
from lws.providers.sns._sns_handlers import _ACTION_HANDLERS
from lws.providers.sns.provider import SnsProvider
from lws.providers.sqs.provider import SqsProvider

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


def _check_sqs_subscribe_target(
    action: str,
    params: dict,
    sqs_provider: SqsProvider | None,
    sqs_tracker: ResourceStateTracker | None,
) -> Response | None:
    """Return an error response if the SQS endpoint does not exist or is not ACTIVE.

    Only applies to Subscribe actions with protocol=sqs.
    """
    if action != "Subscribe":
        return None
    protocol = params.get("Protocol", "")
    if protocol != "sqs":
        return None
    if sqs_provider is None:
        return None
    endpoint = params.get("Endpoint", "")
    if endpoint.startswith("http"):
        queue_name = endpoint.rsplit("/", 1)[-1]
    elif ":" in endpoint:
        queue_name = endpoint.rsplit(":", 1)[-1]
    else:
        queue_name = endpoint
    queue = sqs_provider.get_queue(queue_name)
    if queue is None:
        xml = (
            "<ErrorResponse><Error>"
            "<Code>InvalidParameter</Code>"
            f"<Message>SQS queue does not exist: {endpoint}</Message>"
            "</Error>"
            f"<RequestId>{uuid.uuid4()}</RequestId>"
            "</ErrorResponse>"
        )
        return Response(content=xml, status_code=400, media_type="text/xml")
    if sqs_tracker is not None:
        state = sqs_tracker.get_state(queue_name)
        if state in ("CREATING", "DELETING"):
            xml = (
                "<ErrorResponse><Error>"
                "<Code>InvalidParameter</Code>"
                f"<Message>SQS queue is not ACTIVE: {endpoint} (status: {state})</Message>"
                "</Error>"
                f"<RequestId>{uuid.uuid4()}</RequestId>"
                "</ErrorResponse>"
            )
            return Response(content=xml, status_code=400, media_type="text/xml")
    return None


def _check_publish_subscription(
    action: str,
    params: dict,
    provider: SnsProvider,
) -> Response | None:
    """Reject Publish when no confirmed subscriptions exist for the topic."""
    if action != "Publish":
        return None
    topic_arn = params.get("TopicArn", "")
    if not topic_arn:
        return None
    topic_name = topic_arn.rsplit(":", 1)[-1] if ":" in topic_arn else topic_arn
    try:
        topic = provider.get_topic(topic_name)
    except (KeyError, Exception):  # noqa: BLE001
        return None
    if not topic.subscribers:
        return _sns_xml_error(
            "InvalidParameter", f"No confirmed subscriptions for topic: {topic_arn}", 400
        )
    return None


def _queue_name_from_endpoint(endpoint: str) -> str:
    """Extract queue name from a URL, ARN, or bare queue name."""
    if endpoint.startswith("http"):
        return endpoint.rsplit("/", 1)[-1]
    if ":" in endpoint:
        return endpoint.rsplit(":", 1)[-1]
    return endpoint


def _check_publish_sqs_target_state(
    action: str,
    params: dict,
    provider: SnsProvider,
    sqs_tracker: ResourceStateTracker | None,
) -> Response | None:
    """Reject Publish if any SQS subscription target is not ACTIVE."""
    if action != "Publish" or sqs_tracker is None:
        return None
    topic_arn = params.get("TopicArn", "")
    if not topic_arn:
        return None
    topic_name = topic_arn.rsplit(":", 1)[-1] if ":" in topic_arn else topic_arn
    try:
        topic = provider.get_topic(topic_name)
    except (KeyError, Exception):  # noqa: BLE001
        return None
    for sub in topic.subscribers:
        if sub.protocol != "sqs":
            continue
        queue_name = _queue_name_from_endpoint(sub.endpoint)
        state = sqs_tracker.get_state(queue_name)
        if state in ("CREATING", "DELETING"):
            return _sns_xml_error(
                "InvalidParameter",
                f"SQS queue is not ACTIVE: {sub.endpoint} (status: {state})",
                400,
            )
    return None


def _check_sns_capacity(
    action: str,
    sqs_capacity: AwsCapacityConfig | None,
    sns_capacity: AwsCapacityConfig | None,
) -> Response | None:
    """Return an error response if any capacity limit is exhausted."""
    if (
        action in ("Publish", "Subscribe")
        and sns_capacity is not None
        and sns_capacity.is_exhausted
    ):
        return _sns_xml_error("KMSThrottlingException", "lws: SNS capacity exhausted", 400)
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
    return None


def _sns_xml_error(code: str, message: str, status_code: int = 400) -> Response:
    xml = (
        "<ErrorResponse><Error>"
        f"<Code>{code}</Code>"
        f"<Message>{message}</Message>"
        "</Error>"
        f"<RequestId>{uuid.uuid4()}</RequestId>"
        "</ErrorResponse>"
    )
    return Response(content=xml, status_code=status_code, media_type="text/xml")


async def _sns_dispatch(
    request: Request,
    provider: SnsProvider,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
    sqs_capacity: AwsCapacityConfig | None = None,
    sqs_provider: SqsProvider | None = None,
    sqs_tracker: ResourceStateTracker | None = None,
    sns_capacity: AwsCapacityConfig | None = None,
) -> Response:
    """Route a single SNS request."""
    params = await _parse_form(request)
    action = params.get("Action", "")

    err = _check_sns_topic_lifecycle(action, params, lc, tracker)
    if err is not None:
        return err

    err = _check_sqs_subscribe_target(action, params, sqs_provider, sqs_tracker)
    if err is not None:
        return err

    err = _check_publish_subscription(action, params, provider)
    if err is not None:
        return err

    err = _check_publish_sqs_target_state(action, params, provider, sqs_tracker)
    if err is not None:
        return err

    cap_err = _check_sns_capacity(action, sqs_capacity, sns_capacity)
    if cap_err is not None:
        return cap_err

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
        result = await _handle_sns_lifecycle(action, handler, provider, params, lc, tracker)
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
    sqs_provider: SqsProvider | None = None,
    sqs_tracker: ResourceStateTracker | None = None,
    tracker_ref: list[ResourceStateTracker] | None = None,
    sns_capacity: AwsCapacityConfig | None = None,
    context: ProviderContext | None = None,
) -> FastAPI:
    """Create a FastAPI application that speaks the SNS wire protocol.

    Args:
        sqs_provider: Optional SQS provider used to validate SQS queue existence
            on Subscribe calls.
        sqs_tracker: Optional SQS lifecycle tracker used to validate that the
            target SQS queue is ACTIVE on Subscribe calls.
        tracker_ref: Optional single-element list; if provided, the lifecycle
            ``ResourceStateTracker`` used by this app is deposited at index 0
            so callers can share it with other services (e.g. EventBridge).
    """
    _lc = lifecycle or ResourceLifecycleConfig()
    _tracker = ResourceStateTracker(_lc)
    if tracker_ref is not None:
        tracker_ref.append(_tracker)

    app = FastAPI(title="LDK SNS")
    if aws_fake is not None:
        app.add_middleware(AwsOperationFakeMiddleware, fake_config=aws_fake, service="sns")
    add_iam_auth_middleware(app, "sns", iam_auth, ErrorFormat.XML_IAM)
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.XML_IAM)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="sns")

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        return await _sns_dispatch(
            request, provider, _lc, _tracker, sqs_capacity, sqs_provider, sqs_tracker, sns_capacity
        )

    apply_cloudtrail_middleware(app, context.cloudtrail if context else None, "sns")
    return app
