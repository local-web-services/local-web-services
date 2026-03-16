"""``lws dynamodb`` sub-commands."""

from __future__ import annotations

import asyncio
import json

import typer

from lws.cli.services.client import LwsClient, exit_with_error, output_json

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
        result = await client.json_target_request(_SERVICE, f"{_TARGET_PREFIX}.Scan", body)
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("create-table")
def create_table(
    table_name: str = typer.Option(..., "--table-name", help="Table name"),
    key_schema: str = typer.Option(..., "--key-schema", help="JSON key schema"),
    attribute_definitions: str = typer.Option(
        ..., "--attribute-definitions", help="JSON attribute definitions"
    ),
    global_secondary_indexes: str = typer.Option(
        None, "--global-secondary-indexes", help="JSON global secondary indexes"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Create a table."""
    asyncio.run(
        _create_table(table_name, key_schema, attribute_definitions, global_secondary_indexes, port)
    )


async def _create_table(
    table_name: str,
    key_schema_json: str,
    attribute_definitions_json: str,
    global_secondary_indexes_json: str | None,
    port: int,
) -> None:
    client = _client(port)
    body: dict = {"TableName": table_name}
    try:
        body["KeySchema"] = json.loads(key_schema_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --key-schema: {exc}")
    try:
        body["AttributeDefinitions"] = json.loads(attribute_definitions_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --attribute-definitions: {exc}")
    if global_secondary_indexes_json:
        try:
            body["GlobalSecondaryIndexes"] = json.loads(global_secondary_indexes_json)
        except json.JSONDecodeError as exc:
            exit_with_error(f"Invalid JSON in --global-secondary-indexes: {exc}")
    try:
        result = await client.json_target_request(_SERVICE, f"{_TARGET_PREFIX}.CreateTable", body)
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("delete-table")
def delete_table(
    table_name: str = typer.Option(..., "--table-name", help="Table name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Delete a table."""
    asyncio.run(_delete_table(table_name, port))


async def _delete_table(table_name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DeleteTable",
            {"TableName": table_name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("describe-table")
def describe_table(
    table_name: str = typer.Option(..., "--table-name", help="Table name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Describe a table."""
    asyncio.run(_describe_table(table_name, port))


async def _describe_table(table_name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DescribeTable",
            {"TableName": table_name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("list-tables")
def list_tables(
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List all tables."""
    asyncio.run(_list_tables(port))


async def _list_tables(port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(_SERVICE, f"{_TARGET_PREFIX}.ListTables", {})
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
    asyncio.run(_query(table_name, key_condition_expression, expression_attribute_values, port))


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


@app.command("transact-write-items")
def transact_write_items(
    transact_items: str = typer.Option(..., "--transact-items", help="JSON transact items"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Execute a transactional write."""
    asyncio.run(_transact_write_items(transact_items, port))


async def _transact_write_items(transact_items_json: str, port: int) -> None:
    client = _client(port)
    try:
        parsed = json.loads(transact_items_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --transact-items: {exc}")
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.TransactWriteItems",
            {"TransactItems": parsed},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("update-item")
def update_item(
    table_name: str = typer.Option(..., "--table-name", help="Table name"),
    key: str = typer.Option(..., "--key", help="JSON key"),
    update_expression: str = typer.Option(..., "--update-expression", help="Update expression"),
    expression_attribute_values: str = typer.Option(
        None, "--expression-attribute-values", help="JSON expression attribute values"
    ),
    expression_attribute_names: str = typer.Option(
        None, "--expression-attribute-names", help="JSON expression attribute names"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Update an item in a table."""
    asyncio.run(
        _update_item(
            table_name,
            key,
            update_expression,
            expression_attribute_values,
            expression_attribute_names,
            port,
        )
    )


async def _update_item(
    table_name: str,
    key_json: str,
    update_expression: str,
    expression_attribute_values: str | None,
    expression_attribute_names: str | None,
    port: int,
) -> None:
    client = _client(port)
    try:
        parsed_key = json.loads(key_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --key: {exc}")
    body: dict = {
        "TableName": table_name,
        "Key": parsed_key,
        "UpdateExpression": update_expression,
    }
    if expression_attribute_values:
        try:
            body["ExpressionAttributeValues"] = json.loads(expression_attribute_values)
        except json.JSONDecodeError as exc:
            exit_with_error(f"Invalid JSON in --expression-attribute-values: {exc}")
    if expression_attribute_names:
        try:
            body["ExpressionAttributeNames"] = json.loads(expression_attribute_names)
        except json.JSONDecodeError as exc:
            exit_with_error(f"Invalid JSON in --expression-attribute-names: {exc}")
    try:
        result = await client.json_target_request(_SERVICE, f"{_TARGET_PREFIX}.UpdateItem", body)
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("batch-write-item")
def batch_write_item(
    request_items: str = typer.Option(..., "--request-items", help="JSON request items"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Execute a batch write."""
    asyncio.run(_batch_write_item(request_items, port))


async def _batch_write_item(request_items_json: str, port: int) -> None:
    client = _client(port)
    try:
        parsed = json.loads(request_items_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --request-items: {exc}")
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.BatchWriteItem",
            {"RequestItems": parsed},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("batch-get-item")
def batch_get_item(
    request_items: str = typer.Option(..., "--request-items", help="JSON request items"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Execute a batch get."""
    asyncio.run(_batch_get_item(request_items, port))


async def _batch_get_item(request_items_json: str, port: int) -> None:
    client = _client(port)
    try:
        parsed = json.loads(request_items_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --request-items: {exc}")
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.BatchGetItem",
            {"RequestItems": parsed},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("transact-get-items")
def transact_get_items(
    transact_items: str = typer.Option(..., "--transact-items", help="JSON transact items"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Execute a transactional read."""
    asyncio.run(_transact_get_items(transact_items, port))


async def _transact_get_items(transact_items_json: str, port: int) -> None:
    client = _client(port)
    try:
        parsed = json.loads(transact_items_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --transact-items: {exc}")
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.TransactGetItems",
            {"TransactItems": parsed},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("update-table")
def update_table(
    table_name: str = typer.Option(..., "--table-name", help="Table name"),
    billing_mode: str = typer.Option(None, "--billing-mode", help="Billing mode"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Update a table."""
    asyncio.run(_update_table(table_name, billing_mode, port))


async def _update_table(table_name: str, billing_mode: str | None, port: int) -> None:
    client = _client(port)
    body: dict = {"TableName": table_name}
    if billing_mode:
        body["BillingMode"] = billing_mode
    try:
        result = await client.json_target_request(_SERVICE, f"{_TARGET_PREFIX}.UpdateTable", body)
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("describe-time-to-live")
def describe_time_to_live(
    table_name: str = typer.Option(..., "--table-name", help="Table name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Describe TTL settings for a table."""
    asyncio.run(_describe_time_to_live(table_name, port))


async def _describe_time_to_live(table_name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DescribeTimeToLive",
            {"TableName": table_name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("update-time-to-live")
def update_time_to_live(
    table_name: str = typer.Option(..., "--table-name", help="Table name"),
    time_to_live_specification: str = typer.Option(
        ..., "--time-to-live-specification", help="JSON TTL specification"
    ),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Update TTL settings for a table."""
    asyncio.run(_update_time_to_live(table_name, time_to_live_specification, port))


async def _update_time_to_live(table_name: str, ttl_spec_json: str, port: int) -> None:
    client = _client(port)
    try:
        parsed = json.loads(ttl_spec_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --time-to-live-specification: {exc}")
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.UpdateTimeToLive",
            {"TableName": table_name, "TimeToLiveSpecification": parsed},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("describe-continuous-backups")
def describe_continuous_backups(
    table_name: str = typer.Option(..., "--table-name", help="Table name"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Describe continuous backups for a table."""
    asyncio.run(_describe_continuous_backups(table_name, port))


async def _describe_continuous_backups(table_name: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.DescribeContinuousBackups",
            {"TableName": table_name},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("tag-resource")
def tag_resource(
    resource_arn: str = typer.Option(..., "--resource-arn", help="Resource ARN"),
    tags: str = typer.Option(..., "--tags", help="JSON tags"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Tag a DynamoDB resource."""
    asyncio.run(_tag_resource(resource_arn, tags, port))


async def _tag_resource(resource_arn: str, tags_json: str, port: int) -> None:
    client = _client(port)
    try:
        parsed = json.loads(tags_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --tags: {exc}")
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.TagResource",
            {"ResourceArn": resource_arn, "Tags": parsed},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("untag-resource")
def untag_resource(
    resource_arn: str = typer.Option(..., "--resource-arn", help="Resource ARN"),
    tag_keys: str = typer.Option(..., "--tag-keys", help="JSON array of tag keys"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """Remove tags from a DynamoDB resource."""
    asyncio.run(_untag_resource(resource_arn, tag_keys, port))


async def _untag_resource(resource_arn: str, tag_keys_json: str, port: int) -> None:
    client = _client(port)
    try:
        parsed = json.loads(tag_keys_json)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in --tag-keys: {exc}")
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.UntagResource",
            {"ResourceArn": resource_arn, "TagKeys": parsed},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


@app.command("list-tags-of-resource")
def list_tags_of_resource(
    resource_arn: str = typer.Option(..., "--resource-arn", help="Resource ARN"),
    port: int = typer.Option(3000, "--port", "-p", help="LDK port"),
) -> None:
    """List tags for a DynamoDB resource."""
    asyncio.run(_list_tags_of_resource(resource_arn, port))


async def _list_tags_of_resource(resource_arn: str, port: int) -> None:
    client = _client(port)
    try:
        result = await client.json_target_request(
            _SERVICE,
            f"{_TARGET_PREFIX}.ListTagsOfResource",
            {"ResourceArn": resource_arn},
        )
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)
