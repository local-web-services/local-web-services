"""``lws events`` sub-commands."""

from __future__ import annotations

import asyncio
import json

import typer

from lws.cli.services.client import LwsClient, exit_with_error, output_json

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
