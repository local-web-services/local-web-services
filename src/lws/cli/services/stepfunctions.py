"""``lws stepfunctions`` sub-commands."""

from __future__ import annotations

import asyncio

import typer

from lws.cli.services.client import (
    LwsClient,
    exit_with_error,
    json_request_output,
    output_json,
    parse_json_option,
)

app = typer.Typer(help="Step Functions commands")

_SERVICE = "stepfunctions"
_TARGET_PREFIX = "AWSStepFunctions"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


@app.command("start-execution")
def start_execution(
    name: str = typer.Option(..., "--name", help="State machine name"),
    execution_input: str = typer.Option("{}", "--input", help="JSON input"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Start a state machine execution."""
    asyncio.run(_start_execution(name, execution_input, port))


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


@app.command("start-sync-execution")
def start_sync_execution(
    name: str = typer.Option(..., "--name", help="State machine name"),
    execution_input: str = typer.Option("{}", "--input", help="JSON input"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Start a synchronous state machine execution."""
    asyncio.run(_start_sync_execution(name, execution_input, port))


async def _start_sync_execution(name: str, input_str: str, port: int) -> None:
    client = _client(port)
    try:
        resource = await client.resolve_resource(_SERVICE, name)
        arn = resource.get("arn", f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}")
    except Exception:
        arn = f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
    result = await client.json_target_request(
        _SERVICE,
        f"{_TARGET_PREFIX}.StartSyncExecution",
        {"stateMachineArn": arn, "input": input_str},
    )
    output_json(result)


@app.command("stop-execution")
def stop_execution(
    execution_arn: str = typer.Option(..., "--execution-arn", help="Execution ARN"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Stop a state machine execution."""
    asyncio.run(_stop_execution(execution_arn, port))


async def _stop_execution(execution_arn: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.StopExecution",
            {"executionArn": execution_arn},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("update-state-machine")
def update_state_machine(
    name: str = typer.Option(..., "--name", help="State machine name"),
    definition: str = typer.Option(..., "--definition", help="ASL definition JSON"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Update a state machine."""
    asyncio.run(_update_state_machine(name, definition, port))


async def _update_state_machine(name: str, definition: str, port: int) -> None:
    client = _client(port)
    arn = f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.UpdateStateMachine",
            {"stateMachineArn": arn, "definition": definition},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("get-execution-history")
def get_execution_history(
    execution_arn: str = typer.Option(..., "--execution-arn", help="Execution ARN"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get execution history."""
    asyncio.run(_get_execution_history(execution_arn, port))


async def _get_execution_history(execution_arn: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.GetExecutionHistory",
            {"executionArn": execution_arn},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("validate-state-machine-definition")
def validate_state_machine_definition(
    definition: str = typer.Option(..., "--definition", help="ASL definition JSON"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Validate a state machine definition."""
    asyncio.run(_validate_state_machine_definition(definition, port))


async def _validate_state_machine_definition(definition: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.ValidateStateMachineDefinition",
            {"definition": definition},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("list-state-machine-versions")
def list_state_machine_versions(
    name: str = typer.Option(..., "--name", help="State machine name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List state machine versions."""
    asyncio.run(_list_state_machine_versions(name, port))


async def _list_state_machine_versions(name: str, port: int) -> None:
    arn = f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"
    await json_request_output(
        port,
        _SERVICE,
        f"{_TARGET_PREFIX}.ListStateMachineVersions",
        {"stateMachineArn": arn},
    )


@app.command("tag-resource")
def tag_resource(
    resource_arn: str = typer.Option(..., "--resource-arn", help="State machine or activity ARN"),
    tags: str = typer.Option(..., "--tags", help="JSON array of key/value tag objects"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Tag a Step Functions resource."""
    parsed_tags = parse_json_option(tags, "--tags")
    asyncio.run(
        json_request_output(
            port,
            _SERVICE,
            f"{_TARGET_PREFIX}.TagResource",
            {"resourceArn": resource_arn, "tags": parsed_tags},
        )
    )


@app.command("untag-resource")
def untag_resource(
    resource_arn: str = typer.Option(..., "--resource-arn", help="State machine or activity ARN"),
    tag_keys: str = typer.Option(..., "--tag-keys", help="JSON array of tag key strings to remove"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Untag a Step Functions resource."""
    parsed_keys = parse_json_option(tag_keys, "--tag-keys")
    asyncio.run(
        json_request_output(
            port,
            _SERVICE,
            f"{_TARGET_PREFIX}.UntagResource",
            {"resourceArn": resource_arn, "tagKeys": parsed_keys},
        )
    )


@app.command("list-tags-for-resource")
def list_tags_for_resource(
    resource_arn: str = typer.Option(..., "--resource-arn", help="State machine or activity ARN"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List tags for a Step Functions resource."""
    asyncio.run(
        json_request_output(
            port,
            _SERVICE,
            f"{_TARGET_PREFIX}.ListTagsForResource",
            {"resourceArn": resource_arn},
        )
    )
