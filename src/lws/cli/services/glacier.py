"""``lws glacier`` sub-commands."""

from __future__ import annotations

import asyncio

import typer

from lws.cli.services.client import LwsClient, exit_with_error, output_json

app = typer.Typer(help="Glacier commands")

_SERVICE = "glacier"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


@app.command("create-vault")
def create_vault(
    vault_name: str = typer.Option(..., "--vault-name", help="Vault name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a vault."""
    asyncio.run(_create_vault(vault_name, port))


async def _create_vault(vault_name: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(_SERVICE, "PUT", f"-/vaults/{vault_name}")
        result = resp.json()
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("describe-vault")
def describe_vault(
    vault_name: str = typer.Option(..., "--vault-name", help="Vault name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Describe a vault."""
    asyncio.run(_describe_vault(vault_name, port))


async def _describe_vault(vault_name: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(_SERVICE, "GET", f"-/vaults/{vault_name}")
        result = resp.json()
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("delete-vault")
def delete_vault(
    vault_name: str = typer.Option(..., "--vault-name", help="Vault name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a vault."""
    asyncio.run(_delete_vault(vault_name, port))


async def _delete_vault(vault_name: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(_SERVICE, "DELETE", f"-/vaults/{vault_name}")
        result = resp.json()
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("list-vaults")
def list_vaults(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List all vaults."""
    asyncio.run(_list_vaults(port))


async def _list_vaults(port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(_SERVICE, "GET", "-/vaults")
        result = resp.json()
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)
