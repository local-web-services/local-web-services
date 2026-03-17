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
from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsChaosMiddleware, ErrorFormat
from lws.providers._shared.aws_iam_auth import IamAuthBundle, add_iam_auth_middleware
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers._shared.aws_operation_fake import AwsFakeConfig, AwsOperationFakeMiddleware
from lws.providers.eventbridge.provider import EventBridgeProvider, RuleTarget

_logger = get_logger("ldk.eventbridge")

# ------------------------------------------------------------------
# Action handlers
# ------------------------------------------------------------------


async def _handle_put_events(provider: EventBridgeProvider, body: dict) -> Response:
    """Handle the ``PutEvents`` action."""
    entries = body.get("Entries", [])
    results = await provider.put_events(entries)
    response_body = {
        "Entries": results,
        "FailedEntryCount": 0,
    }
    return Response(
        content=json.dumps(response_body),
        media_type="application/json",
    )


async def _handle_put_rule(provider: EventBridgeProvider, body: dict) -> Response:
    """Handle the ``PutRule`` action."""
    rule_name = body.get("Name", "")
    event_bus = body.get("EventBusName", "default")
    event_pattern = body.get("EventPattern")
    schedule_expr = body.get("ScheduleExpression")

    if isinstance(event_pattern, str):
        event_pattern = json.loads(event_pattern)

    try:
        rule_arn = await provider.put_rule(
            rule_name=rule_name,
            event_bus_name=event_bus,
            event_pattern=event_pattern,
            schedule_expression=schedule_expr,
        )
    except (KeyError, ValueError) as exc:
        return Response(
            content=json.dumps({"Error": str(exc)}),
            status_code=400,
            media_type="application/json",
        )

    response_body = {"RuleArn": rule_arn}
    return Response(
        content=json.dumps(response_body),
        media_type="application/json",
    )


async def _handle_put_targets(provider: EventBridgeProvider, body: dict) -> Response:
    """Handle the ``PutTargets`` action."""
    rule_name = body.get("Rule", "")
    raw_targets = body.get("Targets", [])
    targets = [
        RuleTarget(
            target_id=t.get("Id", ""),
            arn=t.get("Arn", ""),
            input_path=t.get("InputPath"),
            input_template=(
                t.get("InputTransformer", {}).get("InputTemplate")
                if isinstance(t.get("InputTransformer"), dict)
                else None
            ),
        )
        for t in raw_targets
    ]

    try:
        await provider.put_targets(rule_name=rule_name, targets=targets)
    except KeyError:
        return Response(
            content=json.dumps({"Error": f"Rule not found: {rule_name}"}),
            status_code=400,
            media_type="application/json",
        )

    response_body = {
        "FailedEntryCount": 0,
        "FailedEntries": [],
    }
    return Response(
        content=json.dumps(response_body),
        media_type="application/json",
    )


async def _handle_list_rules(provider: EventBridgeProvider, body: dict) -> Response:
    """Handle the ``ListRules`` action."""
    bus_name = body.get("EventBusName", "default")
    try:
        rules = provider.list_rules(bus_name)
    except KeyError:
        return Response(
            content=json.dumps({"Error": f"Event bus not found: {bus_name}"}),
            status_code=400,
            media_type="application/json",
        )
    rule_list = []
    for r in rules:
        entry: dict = {
            "Name": r.rule_name,
            "Arn": f"arn:aws:events:us-east-1:000000000000:rule/{r.rule_name}",
            "EventBusName": r.event_bus_name,
            "State": "ENABLED" if r.enabled else "DISABLED",
        }
        if r.event_pattern:
            entry["EventPattern"] = json.dumps(r.event_pattern)
        if r.schedule_expression:
            entry["ScheduleExpression"] = r.schedule_expression
        rule_list.append(entry)

    response_body = {"Rules": rule_list}
    return Response(
        content=json.dumps(response_body),
        media_type="application/json",
    )


async def _handle_list_event_buses(provider: EventBridgeProvider, _body: dict) -> Response:
    """Handle the ``ListEventBuses`` action."""
    buses = provider.list_buses()
    bus_list = [{"Name": b.bus_name, "Arn": b.bus_arn} for b in buses]
    response_body = {"EventBuses": bus_list}
    return Response(
        content=json.dumps(response_body),
        media_type="application/json",
    )


async def _handle_create_event_bus(provider: EventBridgeProvider, body: dict) -> Response:
    """Handle the ``CreateEventBus`` action."""
    bus_name = body.get("Name", "")
    if not bus_name:
        return Response(
            content=json.dumps({"Error": "Name is required"}),
            status_code=400,
            media_type="application/json",
        )
    try:
        arn = await provider.create_event_bus(bus_name)
    except ValueError as exc:
        return Response(
            content=json.dumps({"Error": str(exc)}),
            status_code=400,
            media_type="application/json",
        )
    return Response(
        content=json.dumps({"EventBusArn": arn}),
        media_type="application/json",
    )


async def _handle_delete_event_bus(provider: EventBridgeProvider, body: dict) -> Response:
    """Handle the ``DeleteEventBus`` action."""
    bus_name = body.get("Name", "")
    try:
        await provider.delete_event_bus(bus_name)
    except (KeyError, ValueError) as exc:
        return Response(
            content=json.dumps({"Error": str(exc)}),
            status_code=400,
            media_type="application/json",
        )
    return Response(
        content=json.dumps({}),
        media_type="application/json",
    )


async def _handle_describe_event_bus(provider: EventBridgeProvider, body: dict) -> Response:
    """Handle the ``DescribeEventBus`` action."""
    bus_name = body.get("Name", "default")
    try:
        attrs = provider.describe_event_bus(bus_name)
    except KeyError:
        return Response(
            content=json.dumps({"Error": f"Event bus not found: {bus_name}"}),
            status_code=400,
            media_type="application/json",
        )
    return Response(
        content=json.dumps(attrs),
        media_type="application/json",
    )


async def _handle_delete_rule(provider: EventBridgeProvider, body: dict) -> Response:
    """Handle the ``DeleteRule`` action."""
    rule_name = body.get("Name", "")
    try:
        await provider.delete_rule(rule_name)
    except (KeyError, ValueError) as exc:
        return Response(
            content=json.dumps({"Error": str(exc)}),
            status_code=400,
            media_type="application/json",
        )
    return Response(
        content=json.dumps({}),
        media_type="application/json",
    )


async def _handle_describe_rule(provider: EventBridgeProvider, body: dict) -> Response:
    """Handle the ``DescribeRule`` action."""
    rule_name = body.get("Name", "")
    event_bus = body.get("EventBusName", "default")
    try:
        attrs = provider.describe_rule(rule_name, event_bus)
    except KeyError:
        return Response(
            content=json.dumps({"Error": f"Rule not found: {rule_name}"}),
            status_code=400,
            media_type="application/json",
        )
    return Response(
        content=json.dumps(attrs),
        media_type="application/json",
    )


async def _handle_list_targets_by_rule(provider: EventBridgeProvider, body: dict) -> Response:
    """Handle the ``ListTargetsByRule`` action."""
    rule_name = body.get("Rule", "")
    event_bus = body.get("EventBusName", "default")
    try:
        targets = provider.list_targets_by_rule(rule_name, event_bus)
    except KeyError:
        return Response(
            content=json.dumps({"Error": f"Rule not found: {rule_name}"}),
            status_code=400,
            media_type="application/json",
        )
    return Response(
        content=json.dumps({"Targets": targets}),
        media_type="application/json",
    )


async def _handle_remove_targets(provider: EventBridgeProvider, body: dict) -> Response:
    """Handle the ``RemoveTargets`` action."""
    rule_name = body.get("Rule", "")
    event_bus = body.get("EventBusName", "default")
    ids = body.get("Ids", [])
    try:
        failed = await provider.remove_targets(rule_name, ids, event_bus)
    except (KeyError, ValueError) as exc:
        return Response(
            content=json.dumps({"Error": str(exc)}),
            status_code=400,
            media_type="application/json",
        )
    return Response(
        content=json.dumps({"FailedEntryCount": len(failed), "FailedEntries": failed}),
        media_type="application/json",
    )


async def _handle_enable_rule(provider: EventBridgeProvider, body: dict) -> Response:
    """Handle the ``EnableRule`` action."""
    rule_name = body.get("Name", "")
    event_bus = body.get("EventBusName", "default")
    try:
        await provider.enable_rule(rule_name, event_bus)
    except (KeyError, ValueError) as exc:
        return Response(
            content=json.dumps({"Error": str(exc)}),
            status_code=400,
            media_type="application/json",
        )
    return Response(
        content=json.dumps({}),
        media_type="application/json",
    )


async def _handle_disable_rule(provider: EventBridgeProvider, body: dict) -> Response:
    """Handle the ``DisableRule`` action."""
    rule_name = body.get("Name", "")
    event_bus = body.get("EventBusName", "default")
    try:
        await provider.disable_rule(rule_name, event_bus)
    except (KeyError, ValueError) as exc:
        return Response(
            content=json.dumps({"Error": str(exc)}),
            status_code=400,
            media_type="application/json",
        )
    return Response(
        content=json.dumps({}),
        media_type="application/json",
    )


async def _handle_tag_resource(provider: EventBridgeProvider, body: dict) -> Response:
    """Handle the ``TagResource`` action."""
    resource_arn = body.get("ResourceARN", "")
    tags = body.get("Tags", [])
    provider.tag_resource(resource_arn, tags)
    return Response(
        content=json.dumps({}),
        media_type="application/json",
    )


async def _handle_untag_resource(provider: EventBridgeProvider, body: dict) -> Response:
    """Handle the ``UntagResource`` action."""
    resource_arn = body.get("ResourceARN", "")
    tag_keys = body.get("TagKeys", [])
    provider.untag_resource(resource_arn, tag_keys)
    return Response(
        content=json.dumps({}),
        media_type="application/json",
    )


async def _handle_list_tags_for_resource(provider: EventBridgeProvider, body: dict) -> Response:
    """Handle the ``ListTagsForResource`` action."""
    resource_arn = body.get("ResourceARN", "")
    tags = provider.list_tags_for_resource(resource_arn)
    return Response(
        content=json.dumps({"Tags": tags}),
        media_type="application/json",
    )


# ------------------------------------------------------------------
# Target dispatch table
# ------------------------------------------------------------------

_TARGET_HANDLERS = {
    "AWSEvents.PutEvents": _handle_put_events,
    "AWSEvents.PutRule": _handle_put_rule,
    "AWSEvents.PutTargets": _handle_put_targets,
    "AWSEvents.ListRules": _handle_list_rules,
    "AWSEvents.ListEventBuses": _handle_list_event_buses,
    "AWSEvents.CreateEventBus": _handle_create_event_bus,
    "AWSEvents.DeleteEventBus": _handle_delete_event_bus,
    "AWSEvents.DescribeEventBus": _handle_describe_event_bus,
    "AWSEvents.DeleteRule": _handle_delete_rule,
    "AWSEvents.DescribeRule": _handle_describe_rule,
    "AWSEvents.ListTargetsByRule": _handle_list_targets_by_rule,
    "AWSEvents.RemoveTargets": _handle_remove_targets,
    "AWSEvents.EnableRule": _handle_enable_rule,
    "AWSEvents.DisableRule": _handle_disable_rule,
    "AWSEvents.TagResource": _handle_tag_resource,
    "AWSEvents.UntagResource": _handle_untag_resource,
    "AWSEvents.ListTagsForResource": _handle_list_tags_for_resource,
}


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


async def _eventbridge_dispatch(
    request: Request,
    provider: EventBridgeProvider,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
    sf_tracker: ResourceStateTracker | None,
) -> Response:
    """Route a single EventBridge request."""
    target = request.headers.get("x-amz-target", "")
    raw_body = await request.body()
    try:
        body = json.loads(raw_body) if raw_body else {}
    except json.JSONDecodeError:
        body = {}

    err = _check_bus_lifecycle(target, body, lc, tracker)
    if err is not None:
        return err

    if target == "AWSEvents.PutTargets" and sf_tracker is not None:
        err = _check_sf_targets(body, sf_tracker)
        if err is not None:
            return err

    handler = _TARGET_HANDLERS.get(target)
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

    if target == "AWSEvents.CreateEventBus" and lc.enabled and lc.create_dwell_ms > 0:
        return await _lifecycle_create_event_bus(handler, provider, body, lc, tracker)

    if target == "AWSEvents.DeleteEventBus" and lc.enabled:
        return await _lifecycle_delete_event_bus(handler, provider, body, lc, tracker)

    return await handler(provider, body)


def create_eventbridge_app(
    provider: EventBridgeProvider,
    chaos: AwsChaosConfig | None = None,
    aws_fake: AwsFakeConfig | None = None,
    iam_auth: IamAuthBundle | None = None,
    lifecycle: ResourceLifecycleConfig | None = None,
    sf_tracker: ResourceStateTracker | None = None,
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
        return await _eventbridge_dispatch(request, provider, _lc, _tracker, sf_tracker)

    return app
