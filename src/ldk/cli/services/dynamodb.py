"""``lws dynamodb`` sub-commands."""

from __future__ import annotations

import asyncio
import json

import typer

from ldk.cli.services.client import LwsClient, exit_with_error, output_json

app = typer.Typer(help="DynamoDB commands")

_SERVICE = "dynamodb"
_TARGET_PREFIX = "DynamoDB_20120810"


def _client(port: int) -> LwsClient:
    return LwsClient(port=port)


@app.command("put-item")
def put_item(
    table_name: str = typer.Option(..., "--table-name", help="Table name"),
    item: str = typer.Option(..., "--item", help="JSON item"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Put an item into a table."""
    asyncio.run(_put_item(table_name, item, port))


async def _put_item(table_name: str, item_json: str, port: int) -> None:
    client = _client(port)
    try:
        parsed = json.loads(item_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --item: {exc}")
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.PutItem",
            {"TableName": table_name, "Item": parsed},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("get-item")
def get_item(
    table_name: str = typer.Option(..., "--table-name", help="Table name"),
    key: str = typer.Option(..., "--key", help="JSON key"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Get an item from a table."""
    asyncio.run(_get_item(table_name, key, port))


async def _get_item(table_name: str, key_json: str, port: int) -> None:
    client = _client(port)
    try:
        parsed = json.loads(key_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --key: {exc}")
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.GetItem",
            {"TableName": table_name, "Key": parsed},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("delete-item")
def delete_item(
    table_name: str = typer.Option(..., "--table-name", help="Table name"),
    key: str = typer.Option(..., "--key", help="JSON key"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete an item from a table."""
    asyncio.run(_delete_item(table_name, key, port))


async def _delete_item(table_name: str, key_json: str, port: int) -> None:
    client = _client(port)
    try:
        parsed = json.loads(key_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --key: {exc}")
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DeleteItem",
            {"TableName": table_name, "Key": parsed},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("scan")
def scan(
    table_name: str = typer.Option(..., "--table-name", help="Table name"),
    filter_expression: str = typer.Option(None, "--filter-expression", help="Filter expression"),
    expression_attribute_values: str = typer.Option(
        None, "--expression-attribute-values", help="JSON expression attribute values"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Scan a table."""
    asyncio.run(_scan(table_name, filter_expression, expression_attribute_values, port))


async def _scan(
    table_name: str,
    filter_expression: str | None,
    expression_attribute_values: str | None,
    port: int,
) -> None:
    client = _client(port)
    body: dict = {"TableName": table_name}
    if filter_expression:
        body["FilterExpression"] = filter_expression
    if expression_attribute_values:
        try:
            body["ExpressionAttributeValues"] = json.loads(expression_attribute_values)
        except json.JSONDecodeError as exc:
            exit_with_error(f"Invalid JSON in --expression-attribute-values: {exc}")
    try:
        result = await client.json_target_request(
            _SERVICE, f"{_TARGET_PREFIX}.Scan", body
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("query")
def query(
    table_name: str = typer.Option(..., "--table-name", help="Table name"),
    key_condition_expression: str = typer.Option(
        ..., "--key-condition-expression", help="Key condition expression"
    ),
    expression_attribute_values: str = typer.Option(
        ..., "--expression-attribute-values", help="JSON expression attribute values"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Query a table."""
    asyncio.run(
        _query(table_name, key_condition_expression, expression_attribute_values, port)
    )


async def _query(
    table_name: str,
    key_condition_expression: str,
    expression_attribute_values: str,
    port: int,
) -> None:
    client = _client(port)
    try:
        expr_values = json.loads(expression_attribute_values)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --expression-attribute-values: {exc}")
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.Query",
            {
                "TableName": table_name,
                "KeyConditionExpression": key_condition_expression,
                "ExpressionAttributeValues": expr_values,
            },
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)
