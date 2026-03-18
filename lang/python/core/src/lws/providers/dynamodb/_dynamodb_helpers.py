"""DynamoDB helper functions for request parsing and response formatting."""

from __future__ import annotations

import json

from fastapi import Response

from lws.interfaces.key_value_store import (
    GsiDefinition,
    KeyAttribute,
    KeySchema,
    TableConfig,
)

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

    return TableConfig(table_name=table_name, key_schema=key_schema, gsi_definitions=gsi_defs)


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
