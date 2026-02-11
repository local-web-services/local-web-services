"""``lws s3tables`` sub-commands."""

from __future__ import annotations

import asyncio
import json

import typer

from lws.cli.services.client import LwsClient, exit_with_error, output_json

app = typer.Typer(help="S3 Tables commands")

_SERVICE = "s3tables"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


@app.command("create-table-bucket")
def create_table_bucket(
    name: str = typer.Option(..., "--name", help="Table bucket name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a table bucket."""
    asyncio.run(_create_table_bucket(name, port))


async def _create_table_bucket(name: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "PUT",
            "table-buckets",
            body=json.dumps({"name": name}).encode(),
            headers={"Content-Type": "application/json"},
        )
        result = resp.json()
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("list-table-buckets")
def list_table_buckets(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List all table buckets."""
    asyncio.run(_list_table_buckets(port))


async def _list_table_buckets(port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(_SERVICE, "GET", "table-buckets")
        result = resp.json()
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("delete-table-bucket")
def delete_table_bucket(
    name: str = typer.Option(..., "--name", help="Table bucket name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a table bucket."""
    asyncio.run(_delete_table_bucket(name, port))


async def _delete_table_bucket(name: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(_SERVICE, "DELETE", f"table-buckets/{name}")
        result = resp.json()
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("create-namespace")
def create_namespace(
    table_bucket: str = typer.Option(..., "--table-bucket", help="Table bucket name"),
    namespace: str = typer.Option(..., "--namespace", help="Namespace name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a namespace."""
    asyncio.run(_create_namespace(table_bucket, namespace, port))


async def _create_namespace(table_bucket: str, namespace: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "PUT",
            f"table-buckets/{table_bucket}/namespaces",
            body=json.dumps({"namespace": [namespace]}).encode(),
            headers={"Content-Type": "application/json"},
        )
        result = resp.json()
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("create-table")
def create_table(
    table_bucket: str = typer.Option(..., "--table-bucket", help="Table bucket name"),
    namespace: str = typer.Option(..., "--namespace", help="Namespace name"),
    name: str = typer.Option(..., "--name", help="Table name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a table."""
    asyncio.run(_create_table(table_bucket, namespace, name, port))


async def _create_table(table_bucket: str, namespace: str, name: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "PUT",
            f"table-buckets/{table_bucket}/namespaces/{namespace}/tables",
            body=json.dumps({"name": name, "format": "ICEBERG"}).encode(),
            headers={"Content-Type": "application/json"},
        )
        result = resp.json()
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("list-tables")
def list_tables(
    table_bucket: str = typer.Option(..., "--table-bucket", help="Table bucket name"),
    namespace: str = typer.Option(..., "--namespace", help="Namespace name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List tables in a namespace."""
    asyncio.run(_list_tables(table_bucket, namespace, port))


async def _list_tables(table_bucket: str, namespace: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "GET",
            f"table-buckets/{table_bucket}/namespaces/{namespace}/tables",
        )
        result = resp.json()
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("delete-table")
def delete_table(
    table_bucket: str = typer.Option(..., "--table-bucket", help="Table bucket name"),
    namespace: str = typer.Option(..., "--namespace", help="Namespace name"),
    name: str = typer.Option(..., "--name", help="Table name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a table."""
    asyncio.run(_delete_table(table_bucket, namespace, name, port))


async def _delete_table(table_bucket: str, namespace: str, name: str, port: int) -> None:
    client = _client(port)
    try:
        resp = await client.rest_request(
            _SERVICE,
            "DELETE",
            f"table-buckets/{table_bucket}/namespaces/{namespace}/tables/{name}",
        )
        result = resp.json()
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)
