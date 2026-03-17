"""DynamoDB schema helpers: key extraction, GSI projection, table description, stream helpers."""

from __future__ import annotations

import json
import time
from typing import TYPE_CHECKING, Any

from lws.interfaces import GsiDefinition, KeyAttribute, TableConfig

if TYPE_CHECKING:
    import aiosqlite

    from lws.providers.dynamodb.streams import StreamDispatcher


def _extract_key_value(item: dict, key_attr: KeyAttribute) -> str:
    """Extract and stringify a key value from a DynamoDB-format or plain item.

    Handles both DynamoDB wire format ``{"pk": {"S": "val"}}`` and plain
    ``{"pk": "val"}``.
    """
    raw = item.get(key_attr.name)
    if raw is None:
        return ""
    # DynamoDB-typed value like {"S": "abc"}
    if isinstance(raw, dict) and len(raw) == 1:
        type_key = next(iter(raw))
        if type_key in ("S", "N", "B"):
            return str(raw[type_key])
    return str(raw)


def _extract_key_names(config: TableConfig) -> list[str]:
    """Get all key attribute names for the main table."""
    names = [config.key_schema.partition_key.name]
    if config.key_schema.sort_key:
        names.append(config.key_schema.sort_key.name)
    return names


def _project_item_for_gsi(item: dict, gsi: GsiDefinition, table_config: TableConfig) -> str:
    """Project an item according to the GSI projection type.

    Returns the item_json string to store in the GSI table.
    """
    projection = gsi.projection_type.upper()
    if projection == "ALL":
        return json.dumps(item)

    # Always include table keys and GSI keys
    key_attrs = set(_extract_key_names(table_config))
    key_attrs.add(gsi.key_schema.partition_key.name)
    if gsi.key_schema.sort_key:
        key_attrs.add(gsi.key_schema.sort_key.name)

    if projection == "KEYS_ONLY":
        projected = {k: v for k, v in item.items() if k in key_attrs}
        return json.dumps(projected)

    if projection == "INCLUDE":
        # Include specified non-key attributes plus all keys.
        # For simplicity, we store the full item but filter on read.
        return json.dumps(item)

    # Default to ALL for unknown projection types
    return json.dumps(item)


def _extract_sk(item: dict, config: TableConfig) -> str:
    """Extract the sort key value from an item, or empty string if no SK."""
    if config.key_schema.sort_key:
        return _extract_key_value(item, config.key_schema.sort_key)
    return ""


def _find_gsi(config: TableConfig, index_name: str) -> GsiDefinition | None:
    """Find a GSI definition by name."""
    for gsi in config.gsi_definitions:
        if gsi.index_name == index_name:
            return gsi
    return None


def _build_keys_dict(item: dict, config: TableConfig) -> dict[str, Any]:
    """Build a keys-only dict from an item for stream events."""
    keys: dict[str, Any] = {}
    pk_name = config.key_schema.partition_key.name
    if pk_name in item:
        keys[pk_name] = item[pk_name]
    if config.key_schema.sort_key:
        sk_name = config.key_schema.sort_key.name
        if sk_name in item:
            keys[sk_name] = item[sk_name]
    return keys


def _build_table_description(config: TableConfig) -> dict:
    """Build an AWS-compatible TableDescription dict."""
    key_schema = [
        {
            "AttributeName": config.key_schema.partition_key.name,
            "KeyType": "HASH",
        }
    ]
    attr_defs = [
        {
            "AttributeName": config.key_schema.partition_key.name,
            "AttributeType": config.key_schema.partition_key.type,
        }
    ]
    if config.key_schema.sort_key:
        key_schema.append(
            {
                "AttributeName": config.key_schema.sort_key.name,
                "KeyType": "RANGE",
            }
        )
        attr_defs.append(
            {
                "AttributeName": config.key_schema.sort_key.name,
                "AttributeType": config.key_schema.sort_key.type,
            }
        )

    description: dict = {
        "TableName": config.table_name,
        "TableStatus": "ACTIVE",
        "KeySchema": key_schema,
        "AttributeDefinitions": attr_defs,
        "TableArn": f"arn:aws:dynamodb:us-east-1:000000000000:table/{config.table_name}",
        "ItemCount": 0,
        "TableSizeBytes": 0,
        "CreationDateTime": time.time(),
        "ProvisionedThroughput": {
            "ReadCapacityUnits": 0,
            "WriteCapacityUnits": 0,
        },
    }

    if config.gsi_definitions:
        gsis = []
        for gsi in config.gsi_definitions:
            gsi_key_schema = [
                {
                    "AttributeName": gsi.key_schema.partition_key.name,
                    "KeyType": "HASH",
                }
            ]
            gsi_attr = {
                "AttributeName": gsi.key_schema.partition_key.name,
                "AttributeType": gsi.key_schema.partition_key.type,
            }
            if gsi_attr not in attr_defs:
                attr_defs.append(gsi_attr)
            if gsi.key_schema.sort_key:
                gsi_key_schema.append(
                    {
                        "AttributeName": gsi.key_schema.sort_key.name,
                        "KeyType": "RANGE",
                    }
                )
                gsi_sk_attr = {
                    "AttributeName": gsi.key_schema.sort_key.name,
                    "AttributeType": gsi.key_schema.sort_key.type,
                }
                if gsi_sk_attr not in attr_defs:
                    attr_defs.append(gsi_sk_attr)
            gsis.append(
                {
                    "IndexName": gsi.index_name,
                    "KeySchema": gsi_key_schema,
                    "Projection": {"ProjectionType": gsi.projection_type},
                    "IndexStatus": "ACTIVE",
                    "ProvisionedThroughput": {
                        "ReadCapacityUnits": 0,
                        "WriteCapacityUnits": 0,
                    },
                }
            )
        description["GlobalSecondaryIndexes"] = gsis

    return description


async def fetch_item_json(conn: aiosqlite.Connection, pk: str, sk: str) -> str | None:
    """Fetch raw item JSON from the items table."""
    cursor = await conn.execute(
        "SELECT item_json FROM items WHERE pk = ? AND sk = ?",
        (pk, sk),
    )
    row = await cursor.fetchone()
    return row[0] if row else None


async def update_gsi_entry(
    conn: aiosqlite.Connection,
    gsi: GsiDefinition,
    item: dict,
    table_config: TableConfig,
) -> None:
    """Insert or replace an item in a GSI table with projection support."""
    gsi_pk = _extract_key_value(item, gsi.key_schema.partition_key)
    if not gsi_pk:
        return  # Item doesn't project into this GSI
    gsi_sk = (
        _extract_key_value(item, gsi.key_schema.sort_key) if gsi.key_schema.sort_key else ""
    )
    projected_json = _project_item_for_gsi(item, gsi, table_config)
    await conn.execute(
        f"INSERT OR REPLACE INTO gsi_{gsi.index_name} (pk, sk, item_json) VALUES (?, ?, ?)",
        (gsi_pk, gsi_sk, projected_json),
    )


async def delete_gsi_entry(
    conn: aiosqlite.Connection,
    gsi: GsiDefinition,
    item: dict,
) -> None:
    """Delete an item from a GSI table."""
    gsi_pk = _extract_key_value(item, gsi.key_schema.partition_key)
    gsi_sk = (
        _extract_key_value(item, gsi.key_schema.sort_key) if gsi.key_schema.sort_key else ""
    )
    await conn.execute(
        f"DELETE FROM gsi_{gsi.index_name} WHERE pk = ? AND sk = ?",
        (gsi_pk, gsi_sk),
    )


def apply_gsi_projection(
    config: TableConfig, index_name: str, items: list[dict]
) -> list[dict]:
    """Apply GSI projection filtering to query results."""
    gsi = _find_gsi(config, index_name)
    if gsi is None or gsi.projection_type.upper() == "ALL":
        return items

    key_attrs = set(_extract_key_names(config))
    key_attrs.add(gsi.key_schema.partition_key.name)
    if gsi.key_schema.sort_key:
        key_attrs.add(gsi.key_schema.sort_key.name)

    if gsi.projection_type.upper() == "KEYS_ONLY":
        return [{k: v for k, v in item.items() if k in key_attrs} for item in items]

    return items


async def emit_stream_event(
    stream_dispatcher: StreamDispatcher,
    table_name: str,
    new_item: dict,
    old_item_json: str | None,
    config: TableConfig,
) -> None:
    """Emit a stream event for put/update operations."""
    from lws.providers.dynamodb.streams import EventName  # pylint: disable=import-outside-toplevel

    keys = _build_keys_dict(new_item, config)
    old_item = json.loads(old_item_json) if old_item_json else None
    event_name = EventName.MODIFY if old_item else EventName.INSERT
    await stream_dispatcher.emit(
        event_name=event_name,
        table_name=table_name,
        keys=keys,
        new_image=new_item,
        old_image=old_item,
    )


async def emit_delete_stream_event(
    stream_dispatcher: StreamDispatcher,
    table_name: str,
    old_item: dict,
    config: TableConfig,
) -> None:
    """Emit a REMOVE stream event."""
    from lws.providers.dynamodb.streams import EventName  # pylint: disable=import-outside-toplevel

    keys = _build_keys_dict(old_item, config)
    await stream_dispatcher.emit(
        event_name=EventName.REMOVE,
        table_name=table_name,
        keys=keys,
        new_image=None,
        old_image=old_item,
    )
