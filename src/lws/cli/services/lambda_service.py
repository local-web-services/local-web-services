"""``lws lambda`` sub-commands."""

from __future__ import annotations

import asyncio
import json
from pathlib import Path

import httpx
import typer

from lws.cli.services.client import exit_with_error, output_json

app = typer.Typer(help="Lambda commands")


@app.command("invoke")
def invoke(
    function_name: str = typer.Option(..., "--function-name", "-f", help="Lambda function name"),
    event: str = typer.Option(None, "--event", "-e", help="Inline JSON event payload"),
    event_file: Path = typer.Option(None, "--event-file", help="Path to JSON event file"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK management port"),
) -> None:
    """Invoke a Lambda function directly."""
    asyncio.run(_invoke(function_name, event, event_file, port))


async def _invoke(
    function_name: str,
    event_json: str | None,
    event_file: Path | None,
    port: int,
) -> None:
    event_payload = _resolve_event_payload(event_json, event_file)

    lambda_port = port + 9
    try:
        async with httpx.AsyncClient() as client:
            resp = await client.post(
                f"http://localhost:{lambda_port}/2015-03-31/functions/{function_name}/invocations",
                json=event_payload,
                timeout=30.0,
            )
            result = resp.json()
            output_json(result)
    except (httpx.ConnectError, httpx.ConnectTimeout):
        exit_with_error(f"Cannot reach ldk dev on port {port}. Is it running?")
    except Exception as exc:
        exit_with_error(f"Invocation failed: {exc}")


def _resolve_event_payload(event_json: str | None, event_file: Path | None) -> dict:
    """Parse event payload from CLI args."""
    if event_json is not None:
        try:
            return json.loads(event_json)
        except json.JSONDecodeError as exc:
            exit_with_error(f"Invalid JSON in --event: {exc}")

    if event_file is not None:
        if not event_file.exists():
            exit_with_error(f"Event file not found: {event_file}")
        try:
            return json.loads(event_file.read_text())
        except json.JSONDecodeError as exc:
            exit_with_error(f"Invalid JSON in event file: {exc}")

    return {}
