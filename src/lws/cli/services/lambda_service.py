"""``lws lambda`` sub-commands."""

from __future__ import annotations

import asyncio
import json
from pathlib import Path

import httpx
import typer

from lws.cli.services.client import LwsClient, exit_with_error, output_json

app = typer.Typer(help="Lambda commands")

_SERVICE = "lambda"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


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


@app.command("create-function")
def create_function(
    function_name: str = typer.Option(..., "--function-name", help="Function name"),
    runtime: str = typer.Option(..., "--runtime", help="Runtime (e.g. python3.12)"),
    handler: str = typer.Option(..., "--handler", help="Handler (e.g. handler.handler)"),
    code: str = typer.Option(..., "--code", help="JSON code configuration"),
    timeout: int = typer.Option(30, "--timeout", help="Timeout in seconds"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a Lambda function."""
    asyncio.run(_create_function(function_name, runtime, handler, code, timeout, port))


async def _create_function(
    function_name: str, runtime: str, handler: str, code_json: str, timeout: int, port: int
) -> None:
    client = _client(port)
    try:
        parsed_code = json.loads(code_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --code: {exc}")
    json_body = json.dumps(
        {
            "FunctionName": function_name,
            "Runtime": runtime,
            "Handler": handler,
            "Code": parsed_code,
            "Timeout": timeout,
        }
    ).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "POST",
            "/2015-03-31/functions",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("create-event-source-mapping")
def create_event_source_mapping(
    function_name: str = typer.Option(..., "--function-name", help="Function name"),
    event_source_arn: str = typer.Option(..., "--event-source-arn", help="Event source ARN"),
    batch_size: int = typer.Option(10, "--batch-size", help="Batch size"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create an event source mapping."""
    asyncio.run(_create_event_source_mapping(function_name, event_source_arn, batch_size, port))


async def _create_event_source_mapping(
    function_name: str, event_source_arn: str, batch_size: int, port: int
) -> None:
    client = _client(port)
    json_body = json.dumps(
        {
            "EventSourceArn": event_source_arn,
            "FunctionName": function_name,
            "BatchSize": batch_size,
        }
    ).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "POST",
            "/2015-03-31/event-source-mappings",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("list-event-source-mappings")
def list_event_source_mappings(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List event source mappings."""
    asyncio.run(_list_event_source_mappings(port))


async def _list_event_source_mappings(port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "GET",
            "/2015-03-31/event-source-mappings",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("delete-event-source-mapping")
def delete_event_source_mapping(
    uuid: str = typer.Option(..., "--uuid", help="Event source mapping UUID"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete an event source mapping."""
    asyncio.run(_delete_event_source_mapping(uuid, port))


async def _delete_event_source_mapping(uuid: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "DELETE",
            f"/2015-03-31/event-source-mappings/{uuid}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("get-function")
def get_function(
    function_name: str = typer.Option(..., "--function-name", help="Function name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get a Lambda function."""
    asyncio.run(_get_function(function_name, port))


async def _get_function(function_name: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "GET",
            f"/2015-03-31/functions/{function_name}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("delete-function")
def delete_function(
    function_name: str = typer.Option(..., "--function-name", help="Function name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a Lambda function."""
    asyncio.run(_delete_function(function_name, port))


async def _delete_function(function_name: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "DELETE",
            f"/2015-03-31/functions/{function_name}",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json() if resp.content else {})


@app.command("list-functions")
def list_functions(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List Lambda functions."""
    asyncio.run(_list_functions(port))


async def _list_functions(port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "GET",
            "/2015-03-31/functions",
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("update-function-configuration")
def update_function_configuration(
    function_name: str = typer.Option(..., "--function-name", help="Function name"),
    timeout: int = typer.Option(None, "--timeout", help="Timeout in seconds"),
    handler: str = typer.Option(None, "--handler", help="Handler"),
    runtime: str = typer.Option(None, "--runtime", help="Runtime"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Update a Lambda function configuration."""
    asyncio.run(_update_function_configuration(function_name, timeout, handler, runtime, port))


async def _update_function_configuration(
    function_name: str,
    timeout: int | None,
    handler: str | None,
    runtime: str | None,
    port: int,
) -> None:
    client = _client(port)
    body: dict = {"FunctionName": function_name}
    if timeout is not None:
        body["Timeout"] = timeout
    if handler is not None:
        body["Handler"] = handler
    if runtime is not None:
        body["Runtime"] = runtime
    json_body = json.dumps(body).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "PUT",
            f"/2015-03-31/functions/{function_name}/configuration",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())


@app.command("update-function-code")
def update_function_code(
    function_name: str = typer.Option(..., "--function-name", help="Function name"),
    code: str = typer.Option(..., "--code", help="JSON code configuration"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Update a Lambda function code."""
    asyncio.run(_update_function_code(function_name, code, port))


async def _update_function_code(function_name: str, code_json: str, port: int) -> None:
    client = _client(port)
    try:
        parsed_code = json.loads(code_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --code: {exc}")
    json_body = json.dumps(parsed_code).encode()
    try:
        resp = await client.rest_request(
            _SERVICE,
            "PUT",
            f"/2015-03-31/functions/{function_name}/code",
            body=json_body,
            headers={"Content-Type": "application/json"},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(resp.json())
