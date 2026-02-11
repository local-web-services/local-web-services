"""``lws ssm`` sub-commands."""

from __future__ import annotations

import asyncio

import typer

from lws.cli.services.client import LwsClient, exit_with_error, output_json

app = typer.Typer(help="SSM Parameter Store commands")

_SERVICE = "ssm"
_TARGET_PREFIX = "AmazonSSM"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


@app.command("put-parameter")
def put_parameter(
    name: str = typer.Option(..., "--name", help="Parameter name"),
    value: str = typer.Option(..., "--value", help="Parameter value"),
    param_type: str = typer.Option("String", "--type", help="String, StringList, or SecureString"),
    description: str = typer.Option("", "--description", help="Parameter description"),
    overwrite: bool = typer.Option(False, "--overwrite", help="Overwrite existing parameter"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Put a parameter value."""
    asyncio.run(_put_parameter(name, value, param_type, description, overwrite, port))


async def _put_parameter(
    name: str, value: str, param_type: str, description: str, overwrite: bool, port: int
) -> None:
    client = _client(port)
    try:
        body: dict = {"Name": name, "Value": value, "Type": param_type, "Overwrite": overwrite}
        if description:
            body["Description"] = description
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.PutParameter",
            body,
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("get-parameter")
def get_parameter(
    name: str = typer.Option(..., "--name", help="Parameter name"),
    with_decryption: bool = typer.Option(False, "--with-decryption", help="Decrypt SecureString"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get a parameter value."""
    asyncio.run(_get_parameter(name, with_decryption, port))


async def _get_parameter(name: str, with_decryption: bool, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.GetParameter",
            {"Name": name, "WithDecryption": with_decryption},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("get-parameters-by-path")
def get_parameters_by_path(
    path: str = typer.Option(..., "--path", help="Parameter path prefix"),
    recursive: bool = typer.Option(False, "--recursive", help="Recurse into sub-paths"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get parameters by path prefix."""
    asyncio.run(_get_parameters_by_path(path, recursive, port))


async def _get_parameters_by_path(path: str, recursive: bool, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.GetParametersByPath",
            {"Path": path, "Recursive": recursive},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("delete-parameter")
def delete_parameter(
    name: str = typer.Option(..., "--name", help="Parameter name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a parameter."""
    asyncio.run(_delete_parameter(name, port))


async def _delete_parameter(name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DeleteParameter",
            {"Name": name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("describe-parameters")
def describe_parameters(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Describe all parameters."""
    asyncio.run(_describe_parameters(port))


async def _describe_parameters(port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DescribeParameters",
            {},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)
