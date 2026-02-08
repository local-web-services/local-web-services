"""``lws events`` sub-commands."""

from __future__ import annotations

import asyncio
import json

import typer

from ldk.cli.services.client import LwsClient, exit_with_error, output_json

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
