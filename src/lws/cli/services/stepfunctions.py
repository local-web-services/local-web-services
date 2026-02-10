"""``lws stepfunctions`` sub-commands."""

from __future__ import annotations

import asyncio

import typer

from lws.cli.services.client import LwsClient, exit_with_error, output_json

app = typer.Typer(help="Step Functions commands")

_SERVICE = "stepfunctions"
_TARGET_PREFIX = "AWSStepFunctions"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


@app.command("start-execution")
def start_execution(
    name: str = typer.Option(..., "--name", help="State machine name"),
    input: str = typer.Option("{}", "--input", help="JSON input"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Start a state machine execution."""
    asyncio.run(_start_execution(name, input, port))


async def _start_execution(name: str, input_str: str, port: int) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, name)
        arn = resource.get("arn", f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}")
    except Exception:
        arn = f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
    result = await client.json_target_request(
        _SERVICE,
        f"{_TARGET_PREFIX}.StartExecution",
        {"stateMachineArn": arn, "input": input_str},
    )
    output_json(result)


@app.command("describe-execution")
def describe_execution(
    execution_arn: str = typer.Option(..., "--execution-arn", help="Execution ARN"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Describe a state machine execution."""
    asyncio.run(_describe_execution(execution_arn, port))


async def _describe_execution(execution_arn: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DescribeExecution",
            {"executionArn": execution_arn},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("list-executions")
def list_executions(
    name: str = typer.Option(..., "--name", help="State machine name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List executions for a state machine."""
    asyncio.run(_list_executions(name, port))


async def _list_executions(name: str, port: int) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, name)
        arn = resource.get("arn", f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}")
    except Exception:
        arn = f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
    result = await client.json_target_request(
        _SERVICE,
        f"{_TARGET_PREFIX}.ListExecutions",
        {"stateMachineArn": arn},
    )
    output_json(result)


@app.command("list-state-machines")
def list_state_machines(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List all state machines."""
    asyncio.run(_list_state_machines(port))


async def _list_state_machines(port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.ListStateMachines",
            {},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("create-state-machine")
def create_state_machine(
    name: str = typer.Option(..., "--name", help="State machine name"),
    definition: str = typer.Option(..., "--definition", help="ASL definition JSON"),
    role_arn: str = typer.Option("", "--role-arn", help="IAM role ARN"),
    sm_type: str = typer.Option("STANDARD", "--type", help="STANDARD or EXPRESS"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a state machine."""
    asyncio.run(_create_state_machine(name, definition, role_arn, sm_type, port))


async def _create_state_machine(
    name: str, definition: str, role_arn: str, sm_type: str, port: int
) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.CreateStateMachine",
            {
                "name": name,
                "definition": definition,
                "roleArn": role_arn,
                "type": sm_type,
            },
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("delete-state-machine")
def delete_state_machine(
    name: str = typer.Option(..., "--name", help="State machine name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a state machine."""
    asyncio.run(_delete_state_machine(name, port))


async def _delete_state_machine(name: str, port: int) -> None:
    client = _client(port)
    arn = f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DeleteStateMachine",
            {"stateMachineArn": arn},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("describe-state-machine")
def describe_state_machine(
    name: str = typer.Option(..., "--name", help="State machine name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Describe a state machine."""
    asyncio.run(_describe_state_machine(name, port))


async def _describe_state_machine(name: str, port: int) -> None:
    client = _client(port)
    arn = f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DescribeStateMachine",
            {"stateMachineArn": arn},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)
