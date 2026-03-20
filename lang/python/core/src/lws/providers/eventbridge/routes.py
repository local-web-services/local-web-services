"""EventBridge HTTP routes.

Implements the EventBridge JSON-based API that AWS SDKs use.
Each request posts to ``/`` with an ``X-Amz-Target`` header that
selects the operation.  Responses use JSON format.
"""

from __future__ import annotations

import json
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
from lws.providers.eventbridge._eventbridge_handlers import TARGET_HANDLERS
from lws.providers.eventbridge.provider import EventBridgeProvider

_logger = get_logger("ldk.eventbridge")

# ------------------------------------------------------------------
# App factory helpers
# ------------------------------------------------------------------

_BUS_READ_ACTIONS = {
    "AWSEvents.PutRule",
    "AWSEvents.ListRules",
    "AWSEvents.DescribeEventBus",
    "AWSEvents.PutEvents",
}


def _resolve_bus_name(target: str, body: dict) -> str:
    """Extract the event bus name from the request body."""
    bus_name = body.get("EventBusName") or body.get("Name") or ""
    if not bus_name and target == "AWSEvents.PutEvents":
        entries = body.get("Entries", [])
        if entries:
            bus_name = entries[0].get("EventBusName", "")
    return bus_name


def _check_bus_lifecycle(
    target: str,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response | None:
    """Return an error response if the target bus is in a transient lifecycle state."""
    if not lc.enabled or target not in _BUS_READ_ACTIONS:
        return None
    bus_name = _resolve_bus_name(target, body)
    if bus_name and bus_name != "default":
        bus_state = tracker.get_state(bus_name)
        if bus_state in ("CREATING", "DELETING"):
            return Response(
                content=json.dumps(
                    {"Error": f"Event bus not found: {bus_name} (status: {bus_state})"}
                ),
                status_code=400,
                media_type="application/json",
            )
    return None


def _check_sf_targets(
    body: dict,
    sf_tracker: ResourceStateTracker,
) -> Response | None:
    """Return an error response if any Step Functions target is not ACTIVE."""
    for t in body.get("Targets", []):
        arn = t.get("Arn", "")
        if ":stateMachine:" in arn:
            sm_name = arn.rsplit(":", 1)[-1]
            sm_state = sf_tracker.get_state(sm_name)
            if sm_state in ("CREATING", "DELETING"):
                return Response(
                    content=json.dumps(
                        {"Error": f"State machine is not ACTIVE: {arn} (status: {sm_state})"}
                    ),
                    status_code=400,
                    media_type="application/json",
                )
    return None


async def _lifecycle_create_event_bus(
    handler: Any,
    provider: EventBridgeProvider,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle lifecycle-aware CreateEventBus."""
    resp = await handler(provider, body)
    if resp.status_code == 200:
        bus_name = body.get("Name", "")
        tracker.set_state(bus_name, "CREATING")
        tracker.schedule_transition(bus_name, "ACTIVE", lc.create_dwell_ms)
    return resp


async def _lifecycle_delete_event_bus(
    handler: Any,
    provider: EventBridgeProvider,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response:
    """Handle lifecycle-aware DeleteEventBus."""
    bus_name = body.get("Name", "")
    if tracker.get_state(bus_name) == "CREATING":
        return Response(
            content=json.dumps({"Error": f"Event bus {bus_name} is still being created"}),
            status_code=400,
            media_type="application/json",
        )
    resp = await handler(provider, body)
    if resp.status_code == 200:
        if lc.delete_dwell_ms > 0:
            tracker.set_state(bus_name, "DELETING")
            tracker.schedule_transition(bus_name, None, lc.delete_dwell_ms)
        else:
            tracker.remove(bus_name)
    return resp


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def _build_eventbridge_app(
    chaos: AwsChaosConfig | None,
    aws_fake: AwsFakeConfig | None,
    iam_auth: IamAuthBundle | None,
) -> FastAPI:
    """Create and configure the FastAPI app with middleware."""
    app = FastAPI(title="LDK EventBridge")
    if aws_fake is not None:
        app.add_middleware(AwsOperationFakeMiddleware, fake_config=aws_fake, service="events")
    add_iam_auth_middleware(app, "events", iam_auth, ErrorFormat.JSON)
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.JSON)
    return app


def _parse_eventbridge_body(raw_body: bytes) -> dict:
    try:
        return json.loads(raw_body) if raw_body else {}
    except json.JSONDecodeError:
        return {}


def _check_sf_target_lifecycle(
    target: str, body: dict, sf_tracker: ResourceStateTracker | None
) -> Response | None:
    if target != "AWSEvents.PutTargets" or sf_tracker is None:
        return None
    return _check_sf_targets(body, sf_tracker)


async def _handle_eventbridge_lifecycle(
    target: str,
    handler: Any,
    provider: EventBridgeProvider,
    body: dict,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Response | None:
    if target == "AWSEvents.CreateEventBus" and lc.create_dwell_ms > 0:
        return await _lifecycle_create_event_bus(handler, provider, body, lc, tracker)
    if target == "AWSEvents.DeleteEventBus":
        return await _lifecycle_delete_event_bus(handler, provider, body, lc, tracker)
    return None


async def _eventbridge_dispatch(
    request: Request,
    provider: EventBridgeProvider,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
    sf_tracker: ResourceStateTracker | None,
    sqs_capacity: AwsCapacityConfig | None = None,
) -> Response:
    """Route a single EventBridge request."""
    target = request.headers.get("x-amz-target", "")
    body = _parse_eventbridge_body(await request.body())

    err = _check_bus_lifecycle(target, body, lc, tracker)
    if err is not None:
        return err

    err = _check_sf_target_lifecycle(target, body, sf_tracker)
    if err is not None:
        return err

    if target == "AWSEvents.PutEvents" and sqs_capacity is not None and sqs_capacity.is_exhausted:
        return Response(
            content=json.dumps(
                {
                    "__type": "ServiceUnavailableException",
                    "message": "lws: no message slots available",
                }
            ),
            status_code=503,
            media_type="application/json",
        )

    handler = TARGET_HANDLERS.get(target)
    if handler is None:
        action = target.rsplit(".", 1)[-1] if "." in target else target
        _logger.warning("Unknown EventBridge target: %s", target)
        error_body = {
            "__type": "UnknownOperationException",
            "message": f"lws: EventBridge operation '{action}' is not yet implemented",
        }
        return Response(
            content=json.dumps(error_body),
            status_code=400,
            media_type="application/json",
        )

    if lc.enabled:
        result = await _handle_eventbridge_lifecycle(target, handler, provider, body, lc, tracker)
        if result is not None:
            return result

    return await handler(provider, body)


def create_eventbridge_app(
    provider: EventBridgeProvider,
    chaos: AwsChaosConfig | None = None,
    aws_fake: AwsFakeConfig | None = None,
    iam_auth: IamAuthBundle | None = None,
    lifecycle: ResourceLifecycleConfig | None = None,
    sf_tracker: ResourceStateTracker | None = None,
    sqs_capacity: AwsCapacityConfig | None = None,
) -> FastAPI:
    """Create a FastAPI application that speaks the EventBridge wire protocol.

    Args:
        sf_tracker: Optional Step Functions lifecycle tracker.  When provided,
            ``PutTargets`` calls whose target ARNs point at a Step Functions
            state machine will be rejected if that machine is not yet ACTIVE.
    """
    _lc = lifecycle or ResourceLifecycleConfig()
    _tracker = ResourceStateTracker(_lc)

    app = _build_eventbridge_app(chaos, aws_fake, iam_auth)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="eventbridge")

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        return await _eventbridge_dispatch(
            request, provider, _lc, _tracker, sf_tracker, sqs_capacity
        )

    return app
