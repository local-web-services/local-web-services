"""``lws events`` sub-commands."""

from __future__ import annotations

import asyncio
import json

import typer

from lws.cli.services.client import (
    LwsClient,
    exit_with_error,
    json_request_output,
    output_json,
    parse_json_option,
)

app = typer.Typer(help="EventBridge commands")

_SERVICE = "events"
_TARGET_PREFIX = "AWSEvents"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


@app.command("put-events")
def put_events(
    entries: str = typer.Option(..., "--entries", help="JSON array of event entries"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Put events to an event bus."""
    asyncio.run(_put_events(entries, port))


async def _put_events(entries_json: str, port: int) -> None:
    client = _client(port)
    try:
        parsed = json.loads(entries_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --entries: {exc}")
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.PutEvents",
            {"Entries": parsed},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("list-rules")
def list_rules(
    event_bus_name: str = typer.Option("default", "--event-bus-name", help="Event bus name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List rules for an event bus."""
    asyncio.run(_list_rules(event_bus_name, port))


async def _list_rules(event_bus_name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.ListRules",
            {"EventBusName": event_bus_name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("create-event-bus")
def create_event_bus(
    name: str = typer.Option(..., "--name", help="Event bus name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create an event bus."""
    asyncio.run(_create_event_bus(name, port))


async def _create_event_bus(name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.CreateEventBus",
            {"Name": name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("delete-event-bus")
def delete_event_bus(
    name: str = typer.Option(..., "--name", help="Event bus name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete an event bus."""
    asyncio.run(_delete_event_bus(name, port))


async def _delete_event_bus(name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DeleteEventBus",
            {"Name": name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("list-event-buses")
def list_event_buses(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List all event buses."""
    asyncio.run(_list_event_buses(port))


async def _list_event_buses(port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.ListEventBuses",
            {},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("put-rule")
def put_rule(
    name: str = typer.Option(..., "--name", help="Rule name"),
    event_bus_name: str = typer.Option("default", "--event-bus-name", help="Event bus name"),
    event_pattern: str = typer.Option(None, "--event-pattern", help="Event pattern JSON"),
    schedule_expression: str = typer.Option(
        None, "--schedule-expression", help="Schedule expression"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create or update a rule."""
    asyncio.run(_put_rule(name, event_bus_name, event_pattern, schedule_expression, port))


async def _put_rule(
    name: str,
    event_bus_name: str,
    event_pattern: str | None,
    schedule_expression: str | None,
    port: int,
) -> None:
    client = _client(port)
    body: dict = {"Name": name, "EventBusName": event_bus_name}
    if event_pattern:
        body["EventPattern"] = event_pattern
    if schedule_expression:
        body["ScheduleExpression"] = schedule_expression
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.PutRule",
            body,
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("delete-rule")
def delete_rule(
    name: str = typer.Option(..., "--name", help="Rule name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a rule."""
    asyncio.run(_delete_rule(name, port))


async def _delete_rule(name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DeleteRule",
            {"Name": name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("put-targets")
def put_targets(
    rule: str = typer.Option(..., "--rule", help="Rule name"),
    targets: str = typer.Option(..., "--targets", help="JSON array of targets"),
    event_bus_name: str = typer.Option("default", "--event-bus-name", help="Event bus name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Add targets to a rule."""
    asyncio.run(_put_targets(rule, targets, event_bus_name, port))


async def _put_targets(rule: str, targets_json: str, event_bus_name: str, port: int) -> None:
    client = _client(port)
    try:
        parsed_targets = json.loads(targets_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --targets: {exc}")
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.PutTargets",
            {"Rule": rule, "Targets": parsed_targets, "EventBusName": event_bus_name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("remove-targets")
def remove_targets(
    rule: str = typer.Option(..., "--rule", help="Rule name"),
    ids: str = typer.Option(..., "--ids", help="JSON array of target IDs"),
    event_bus_name: str = typer.Option("default", "--event-bus-name", help="Event bus name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Remove targets from a rule."""
    asyncio.run(_remove_targets(rule, ids, event_bus_name, port))


async def _remove_targets(rule: str, ids_json: str, event_bus_name: str, port: int) -> None:
    client = _client(port)
    try:
        parsed_ids = json.loads(ids_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --ids: {exc}")
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.RemoveTargets",
            {"Rule": rule, "Ids": parsed_ids, "EventBusName": event_bus_name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("describe-event-bus")
def describe_event_bus(
    name: str = typer.Option("default", "--name", help="Event bus name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Describe an event bus."""
    asyncio.run(_describe_event_bus(name, port))


async def _describe_event_bus(name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DescribeEventBus",
            {"Name": name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("describe-rule")
def describe_rule(
    name: str = typer.Option(..., "--name", help="Rule name"),
    event_bus_name: str = typer.Option("default", "--event-bus-name", help="Event bus name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Describe a rule."""
    asyncio.run(_describe_rule(name, event_bus_name, port))


async def _describe_rule(name: str, event_bus_name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DescribeRule",
            {"Name": name, "EventBusName": event_bus_name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("list-targets-by-rule")
def list_targets_by_rule(
    rule: str = typer.Option(..., "--rule", help="Rule name"),
    event_bus_name: str = typer.Option("default", "--event-bus-name", help="Event bus name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List targets for a rule."""
    asyncio.run(_list_targets_by_rule(rule, event_bus_name, port))


async def _list_targets_by_rule(rule: str, event_bus_name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.ListTargetsByRule",
            {"Rule": rule, "EventBusName": event_bus_name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("enable-rule")
def enable_rule(
    name: str = typer.Option(..., "--name", help="Rule name"),
    event_bus_name: str = typer.Option("default", "--event-bus-name", help="Event bus name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Enable a rule."""
    asyncio.run(_enable_rule(name, event_bus_name, port))


async def _enable_rule(name: str, event_bus_name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.EnableRule",
            {"Name": name, "EventBusName": event_bus_name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("disable-rule")
def disable_rule(
    name: str = typer.Option(..., "--name", help="Rule name"),
    event_bus_name: str = typer.Option("default", "--event-bus-name", help="Event bus name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Disable a rule."""
    asyncio.run(_disable_rule(name, event_bus_name, port))


async def _disable_rule(name: str, event_bus_name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DisableRule",
            {"Name": name, "EventBusName": event_bus_name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("tag-resource")
def tag_resource(
    resource_arn: str = typer.Option(..., "--resource-arn", help="Resource ARN"),
    tags: str = typer.Option(..., "--tags", help="JSON array of Key/Value tag objects"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Tag a resource."""
    asyncio.run(_tag_resource(resource_arn, tags, port))


async def _tag_resource(resource_arn: str, tags_json: str, port: int) -> None:
    parsed_tags = parse_json_option(tags_json, "--tags")
    await json_request_output(
        port,
        _SERVICE,
        f"{_TARGET_PREFIX}.TagResource",
        {"ResourceARN": resource_arn, "Tags": parsed_tags},
    )


@app.command("untag-resource")
def untag_resource(
    resource_arn: str = typer.Option(..., "--resource-arn", help="Resource ARN"),
    tag_keys: str = typer.Option(..., "--tag-keys", help="JSON array of tag keys"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Untag a resource."""
    asyncio.run(_untag_resource(resource_arn, tag_keys, port))


async def _untag_resource(resource_arn: str, tag_keys_json: str, port: int) -> None:
    parsed_keys = parse_json_option(tag_keys_json, "--tag-keys")
    await json_request_output(
        port,
        _SERVICE,
        f"{_TARGET_PREFIX}.UntagResource",
        {"ResourceARN": resource_arn, "TagKeys": parsed_keys},
    )


@app.command("list-tags-for-resource")
def list_tags_for_resource(
    resource_arn: str = typer.Option(..., "--resource-arn", help="Resource ARN"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List tags for a resource."""
    asyncio.run(_list_tags_for_resource(resource_arn, port))


async def _list_tags_for_resource(resource_arn: str, port: int) -> None:
    await json_request_output(
        port,
        _SERVICE,
        f"{_TARGET_PREFIX}.ListTagsForResource",
        {"ResourceARN": resource_arn},
    )
