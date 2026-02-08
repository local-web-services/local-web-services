"""EventBridge HTTP routes.

Implements the EventBridge JSON-based API that AWS SDKs use.
Each request posts to ``/`` with an ``X-Amz-Target`` header that
selects the operation.  Responses use JSON format.
"""

from __future__ import annotations

import json
import uuid

from fastapi import FastAPI, Request, Response

from ldk.providers.eventbridge.provider import EventBridgeProvider, RuleTarget

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

    rule_arn = await provider.put_rule(
        rule_name=rule_name,
        event_bus_name=event_bus,
        event_pattern=event_pattern,
        schedule_expression=schedule_expr,
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
    rules = provider.list_rules(bus_name)
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


async def _handle_list_event_buses(provider: EventBridgeProvider, body: dict) -> Response:
    """Handle the ``ListEventBuses`` action."""
    buses = provider.list_buses()
    bus_list = [{"Name": b.bus_name, "Arn": b.bus_arn} for b in buses]
    response_body = {"EventBuses": bus_list}
    return Response(
        content=json.dumps(response_body),
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
}


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def create_eventbridge_app(provider: EventBridgeProvider) -> FastAPI:
    """Create a FastAPI application that speaks the EventBridge wire protocol."""
    app = FastAPI(title="LDK EventBridge")

    @app.post("/")
    async def dispatch(request: Request) -> Response:
        target = request.headers.get("x-amz-target", "")
        raw_body = await request.body()
        try:
            body = json.loads(raw_body) if raw_body else {}
        except json.JSONDecodeError:
            body = {}

        handler = _TARGET_HANDLERS.get(target)
        if handler is None:
            error_body = {
                "Error": "UnknownOperation",
                "Message": f"Unknown target: {target}",
                "RequestId": str(uuid.uuid4()),
            }
            return Response(
                content=json.dumps(error_body),
                status_code=400,
                media_type="application/json",
            )

        return await handler(provider, body)

    return app
