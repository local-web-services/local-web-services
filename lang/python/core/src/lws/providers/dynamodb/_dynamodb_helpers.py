"""DynamoDB helper functions for request parsing and response formatting."""

from __future__ import annotations

import asyncio
import json
from collections.abc import Callable

from fastapi import Response

from lws.interfaces.key_value_store import (
    GsiDefinition,
    IKeyValueStore,
    KeyAttribute,
    KeySchema,
    TableConfig,
)
from lws.providers.dynamodb.expressions import evaluate_filter_expression

_DYNAMO_TYPE_KEYS = {"S", "N", "B", "BOOL", "NULL", "L", "M", "SS", "NS", "BS"}


def _json_response(data: dict, status_code: int = 200) -> Response:
    return Response(
        content=json.dumps(data),
        status_code=status_code,
        media_type="application/x-amz-json-1.0",
    )


def _error_response(error_type: str, message: str) -> Response:
    return _json_response(
        {"__type": error_type, "message": message},
        status_code=400,
    )


def _table_not_found_response(table_name: str) -> Response:
    return _error_response(
        "ResourceNotFoundException",
        f"Requested resource not found: Table: {table_name} not found",
    )


def _parse_table_config(body: dict) -> TableConfig:
    """Parse an AWS CreateTable request body into a TableConfig."""
    table_name = body["TableName"]

    # Build attribute type lookup from AttributeDefinitions
    attr_types: dict[str, str] = {}
    for ad in body.get("AttributeDefinitions", []):
        attr_types[ad["AttributeName"]] = ad.get("AttributeType", "S")

    # Parse KeySchema
    pk_attr: KeyAttribute | None = None
    sk_attr: KeyAttribute | None = None
    for ks in body.get("KeySchema", []):
        name = ks["AttributeName"]
        attr = KeyAttribute(name=name, type=attr_types.get(name, "S"))
        if ks["KeyType"] == "HASH":
            pk_attr = attr
        else:
            sk_attr = attr
    if pk_attr is None:
        pk_attr = KeyAttribute(name="pk", type="S")
    key_schema = KeySchema(partition_key=pk_attr, sort_key=sk_attr)

    # Parse GSIs
    gsi_defs: list[GsiDefinition] = []
    for gsi_raw in body.get("GlobalSecondaryIndexes", []):
        gsi_pk: KeyAttribute | None = None
        gsi_sk: KeyAttribute | None = None
        for ks in gsi_raw.get("KeySchema", []):
            name = ks["AttributeName"]
            attr = KeyAttribute(name=name, type=attr_types.get(name, "S"))
            if ks["KeyType"] == "HASH":
                gsi_pk = attr
            else:
                gsi_sk = attr
        if gsi_pk is None:
            continue
        gsi_key_schema = KeySchema(partition_key=gsi_pk, sort_key=gsi_sk)
        projection = gsi_raw.get("Projection", {}).get("ProjectionType", "ALL")
        gsi_defs.append(
            GsiDefinition(
                index_name=gsi_raw["IndexName"],
                key_schema=gsi_key_schema,
                projection_type=projection,
            )
        )

    stream_spec = body.get("StreamSpecification", {})
    stream_enabled = bool(stream_spec.get("StreamEnabled", False))
    stream_view_type = stream_spec.get("StreamViewType", "NEW_AND_OLD_IMAGES")

    return TableConfig(
        table_name=table_name,
        key_schema=key_schema,
        gsi_definitions=gsi_defs,
        stream_enabled=stream_enabled,
        stream_view_type=stream_view_type,
    )


def _unwrap_item(item: dict) -> dict:
    """Convert a DynamoDB JSON item to plain Python values for expression evaluation.

    For example ``{"status": {"S": "active"}}`` becomes ``{"status": "active"}``.
    If the item is already in plain format it is returned unchanged.
    """
    result: dict = {}
    for key, val in item.items():
        if isinstance(val, dict) and len(val) == 1:
            type_key = next(iter(val))
            if type_key in _DYNAMO_TYPE_KEYS:
                result[key] = val[type_key]
                continue
        result[key] = val
    return result


def _extract_condition_params(
    transact_item: dict,
) -> tuple[str | None, dict | None, dict | None, str, dict]:
    """Extract condition expression parameters from a transact item.

    Returns (condition_expression, names, values, table_name, key).
    If the item has no ConditionExpression, condition_expression is None.
    """
    for op_type in ("ConditionCheck", "Put", "Delete", "Update"):
        if op_type not in transact_item:
            continue
        op = transact_item[op_type]
        condition = op.get("ConditionExpression")
        if condition is None and op_type != "ConditionCheck":
            return None, None, None, "", {}
        table = op.get("TableName", "")
        key = op.get("Key", {})
        if op_type == "Put" and "Key" not in op:
            key = {}
        names = op.get("ExpressionAttributeNames")
        values = op.get("ExpressionAttributeValues")
        return condition, names, values, table, key
    return None, None, None, "", {}


async def check_transact_lifecycle(
    get_lifecycle_error: Callable[[str], Response | None],
    transact_items: list,
) -> Response | None:
    """Reject if any referenced table is not ACTIVE."""
    for transact_item in transact_items:
        for op_key in ("Put", "Delete", "Update", "ConditionCheck"):
            if op_key in transact_item:
                table_name = transact_item[op_key]["TableName"]
                err = get_lifecycle_error(table_name)
                if err is not None:
                    return err
    return None


async def check_transact_conditions(
    store: IKeyValueStore,
    transact_items: list,
) -> Response | None:
    """Evaluate ConditionExpressions across all transact items.

    Returns an error Response if any condition fails, or None if all pass.
    """
    reasons: list[dict] = []
    any_failed = False

    for transact_item in transact_items:
        condition_expr, names, values, table_name, key = _extract_condition_params(transact_item)

        if condition_expr is None:
            reasons.append({"Code": "None"})
            continue

        item = await store.get_item(table_name, key)
        target = _unwrap_item(item) if item is not None else {}
        passed = evaluate_filter_expression(target, condition_expr, names, values)
        if passed:
            reasons.append({"Code": "None"})
        else:
            reasons.append(
                {
                    "Code": "ConditionalCheckFailed",
                    "Message": "The conditional request failed",
                }
            )
            any_failed = True

    if any_failed:
        return _json_response(
            {
                "__type": "com.amazonaws.dynamodb.v20120810" "#TransactionCanceledException",
                "Message": "Transaction cancelled, please refer "
                "cancellation reasons for specific reasons "
                "[ConditionalCheckFailed]",
                "CancellationReasons": reasons,
            },
            status_code=400,
        )
    return None


def transact_item_lock_key(table_name: str, key: dict) -> str:
    """Return a string key identifying a DynamoDB item for lock tracking."""
    sorted_key = sorted(key.items())
    return f"{table_name}:{sorted_key}"


def collect_transact_lock_keys(transact_items: list) -> list[str]:
    """Collect lock keys for all write operations in a transaction."""
    lock_keys: list[str] = []
    for transact_item in transact_items:
        if "Put" in transact_item:
            item_key = transact_item["Put"].get("Item", {})
            lock_keys.append(transact_item_lock_key(transact_item["Put"]["TableName"], item_key))
        elif "Delete" in transact_item:
            lock_keys.append(
                transact_item_lock_key(
                    transact_item["Delete"]["TableName"],
                    transact_item["Delete"].get("Key", {}),
                )
            )
        elif "Update" in transact_item:
            lock_keys.append(
                transact_item_lock_key(
                    transact_item["Update"]["TableName"],
                    transact_item["Update"].get("Key", {}),
                )
            )
    return lock_keys


async def try_acquire_transact_locks(
    transaction_locks: dict[str, asyncio.Lock], lock_keys: list[str]
) -> tuple[list[str], Response | None]:
    """Try to acquire item locks; return (acquired, conflict_error) or (keys, None)."""
    acquired: list[str] = []
    for lock_key in lock_keys:
        if lock_key not in transaction_locks:
            transaction_locks[lock_key] = asyncio.Lock()
        lock = transaction_locks[lock_key]
        if not lock.locked():
            await lock.acquire()
            acquired.append(lock_key)
        else:
            for held_key in acquired:
                transaction_locks[held_key].release()
            return [], _error_response(
                "TransactionCanceledException",
                "Transaction cancelled due to conflict with a concurrent transaction",
            )
    return acquired, None


async def execute_transact_writes(store: IKeyValueStore, transact_items: list) -> None:
    """Execute the write operations in a transaction."""
    for transact_item in transact_items:
        if "Put" in transact_item:
            put = transact_item["Put"]
            await store.put_item(put["TableName"], put["Item"])
        elif "Delete" in transact_item:
            delete = transact_item["Delete"]
            await store.delete_item(delete["TableName"], delete["Key"])
        elif "Update" in transact_item:
            update = transact_item["Update"]
            await store.update_item(
                update["TableName"],
                update["Key"],
                update.get("UpdateExpression", ""),
                expression_values=update.get("ExpressionAttributeValues"),
                expression_names=update.get("ExpressionAttributeNames"),
            )
