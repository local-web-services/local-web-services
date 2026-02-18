"""DynamoDB wire protocol HTTP server.

Implements the DynamoDB JSON-over-HTTP protocol that AWS SDKs expect.
Each operation is dispatched based on the ``X-Amz-Target`` header value
(e.g. ``DynamoDB_20120810.PutItem``).
"""

from __future__ import annotations

import json

from fastapi import APIRouter, FastAPI, Request, Response

from lws.interfaces.key_value_store import (
    GsiDefinition,
    IKeyValueStore,
    KeyAttribute,
    KeySchema,
    TableConfig,
)
from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsChaosMiddleware, ErrorFormat
from lws.providers.dynamodb.expressions import evaluate_filter_expression

_logger = get_logger("ldk.dynamodb")

# Prefix the AWS SDK uses in the X-Amz-Target header.
_TARGET_PREFIX = "DynamoDB_20120810."


class DynamoDbRouter:
    """Route DynamoDB wire-protocol requests to an ``IKeyValueStore`` backend."""

    def __init__(self, store: IKeyValueStore) -> None:
        self.store = store
        self.router = APIRouter()
        self.router.add_api_route("/", self._dispatch, methods=["POST"])

    # ------------------------------------------------------------------
    # Dispatch
    # ------------------------------------------------------------------

    async def _dispatch(self, request: Request) -> Response:
        target = request.headers.get("X-Amz-Target", "")
        if not target.startswith(_TARGET_PREFIX):
            return _error_response(
                "ValidationException",
                f"Unknown target: {target}",
            )

        operation = target[len(_TARGET_PREFIX) :]
        body = await request.json()

        handler = self._handlers().get(operation)
        if handler is None:
            _logger.warning("Unknown DynamoDB operation: %s", operation)
            return _error_response(
                "UnknownOperationException",
                f"lws: DynamoDB operation '{operation}' is not yet implemented",
            )

        return await handler(body)

    def _handlers(self) -> dict:
        return {
            "GetItem": self._get_item,
            "PutItem": self._put_item,
            "DeleteItem": self._delete_item,
            "UpdateItem": self._update_item,
            "Query": self._query,
            "Scan": self._scan,
            "BatchGetItem": self._batch_get_item,
            "BatchWriteItem": self._batch_write_item,
            "CreateTable": self._create_table,
            "DeleteTable": self._delete_table,
            "DescribeTable": self._describe_table,
            "ListTables": self._list_tables,
            "DescribeTimeToLive": self._describe_time_to_live,
            "UpdateTimeToLive": self._update_time_to_live,
            "UpdateTable": self._update_table,
            "TransactWriteItems": self._transact_write_items,
            "TransactGetItems": self._transact_get_items,
            "DescribeContinuousBackups": self._describe_continuous_backups,
            "ListTagsOfResource": self._list_tags_of_resource,
            "TagResource": self._tag_resource,
            "UntagResource": self._untag_resource,
        }

    # ------------------------------------------------------------------
    # Individual operation handlers
    # ------------------------------------------------------------------

    async def _get_item(self, body: dict) -> Response:
        table_name = body["TableName"]
        key = body["Key"]
        item = await self.store.get_item(table_name, key)
        result: dict = {}
        if item is not None:
            result["Item"] = item
        return _json_response(result)

    async def _put_item(self, body: dict) -> Response:
        table_name = body["TableName"]
        item = body["Item"]
        await self.store.put_item(table_name, item)
        return _json_response({})

    async def _delete_item(self, body: dict) -> Response:
        table_name = body["TableName"]
        key = body["Key"]
        await self.store.delete_item(table_name, key)
        return _json_response({})

    async def _update_item(self, body: dict) -> Response:
        table_name = body["TableName"]
        key = body["Key"]
        update_expression = body.get("UpdateExpression", "")
        expression_values = body.get("ExpressionAttributeValues")
        expression_names = body.get("ExpressionAttributeNames")
        updated = await self.store.update_item(
            table_name,
            key,
            update_expression,
            expression_values=expression_values,
            expression_names=expression_names,
        )
        return _json_response({"Attributes": updated})

    async def _query(self, body: dict) -> Response:
        table_name = body["TableName"]
        key_condition = body.get("KeyConditionExpression", "")
        expression_values = body.get("ExpressionAttributeValues")
        expression_names = body.get("ExpressionAttributeNames")
        index_name = body.get("IndexName")
        filter_expression = body.get("FilterExpression")
        items = await self.store.query(
            table_name,
            key_condition,
            expression_values=expression_values,
            expression_names=expression_names,
            index_name=index_name,
            filter_expression=filter_expression,
        )
        return _json_response({"Items": items, "Count": len(items)})

    async def _scan(self, body: dict) -> Response:
        table_name = body["TableName"]
        filter_expression = body.get("FilterExpression")
        expression_values = body.get("ExpressionAttributeValues")
        expression_names = body.get("ExpressionAttributeNames")
        items = await self.store.scan(
            table_name,
            filter_expression=filter_expression,
            expression_values=expression_values,
            expression_names=expression_names,
        )
        return _json_response({"Items": items, "Count": len(items)})

    async def _batch_get_item(self, body: dict) -> Response:
        request_items = body.get("RequestItems", {})
        responses: dict[str, list[dict]] = {}
        for table_name, table_req in request_items.items():
            keys = table_req.get("Keys", [])
            items = await self.store.batch_get_items(table_name, keys)
            responses[table_name] = items
        return _json_response({"Responses": responses})

    async def _batch_write_item(self, body: dict) -> Response:
        request_items = body.get("RequestItems", {})
        for table_name, requests in request_items.items():
            put_items: list[dict] = []
            delete_keys: list[dict] = []
            for req in requests:
                if "PutRequest" in req:
                    put_items.append(req["PutRequest"]["Item"])
                elif "DeleteRequest" in req:
                    delete_keys.append(req["DeleteRequest"]["Key"])
            await self.store.batch_write_items(
                table_name,
                put_items=put_items or None,
                delete_keys=delete_keys or None,
            )
        return _json_response({})

    async def _create_table(self, body: dict) -> Response:
        config = _parse_table_config(body)
        description = await self.store.create_table(config)
        return _json_response({"TableDescription": description})

    async def _delete_table(self, body: dict) -> Response:
        table_name = body.get("TableName", "")
        try:
            description = await self.store.delete_table(table_name)
        except KeyError:
            return _error_response(
                "ResourceNotFoundException",
                f"Requested resource not found: Table: {table_name} not found",
            )
        return _json_response({"TableDescription": description})

    async def _describe_table(self, body: dict) -> Response:
        table_name = body.get("TableName", "")
        try:
            description = await self.store.describe_table(table_name)
        except KeyError:
            return _error_response(
                "ResourceNotFoundException",
                f"Requested resource not found: Table: {table_name} not found",
            )
        return _json_response({"Table": description})

    async def _list_tables(self, _body: dict) -> Response:
        table_names = await self.store.list_tables()
        return _json_response({"TableNames": table_names})

    async def _describe_time_to_live(self, body: dict) -> Response:
        table_name = body.get("TableName", "")
        return _json_response(
            {
                "TimeToLiveDescription": {
                    "TimeToLiveStatus": "DISABLED",
                    "TableName": table_name,
                }
            }
        )

    async def _list_tags_of_resource(self, _body: dict) -> Response:
        return _json_response({"Tags": []})

    async def _tag_resource(self, _body: dict) -> Response:
        return _json_response({})

    async def _untag_resource(self, _body: dict) -> Response:
        return _json_response({})

    async def _update_table(self, body: dict) -> Response:
        table_name = body.get("TableName", "")
        try:
            description = await self.store.describe_table(table_name)
        except KeyError:
            return _error_response(
                "ResourceNotFoundException",
                f"Requested resource not found: Table: {table_name} not found",
            )
        return _json_response({"TableDescription": description})

    async def _transact_write_items(self, body: dict) -> Response:
        transact_items = body.get("TransactItems", [])

        # Pass 1: evaluate all condition expressions
        failure = await self._check_transact_conditions(transact_items)
        if failure is not None:
            return failure

        # Pass 2: execute writes
        for transact_item in transact_items:
            if "Put" in transact_item:
                put = transact_item["Put"]
                await self.store.put_item(put["TableName"], put["Item"])
            elif "Delete" in transact_item:
                delete = transact_item["Delete"]
                await self.store.delete_item(delete["TableName"], delete["Key"])
            elif "Update" in transact_item:
                update = transact_item["Update"]
                await self.store.update_item(
                    update["TableName"],
                    update["Key"],
                    update.get("UpdateExpression", ""),
                    expression_values=update.get("ExpressionAttributeValues"),
                    expression_names=update.get("ExpressionAttributeNames"),
                )
        return _json_response({})

    async def _check_transact_conditions(self, transact_items: list) -> Response | None:
        """Evaluate ConditionExpressions across all transact items.

        Returns an error Response if any condition fails, or None if all pass.
        """
        reasons: list[dict] = []
        any_failed = False

        for transact_item in transact_items:
            condition_expr, names, values, table_name, key = _extract_condition_params(
                transact_item
            )

            if condition_expr is None:
                reasons.append({"Code": "None"})
                continue

            item = await self.store.get_item(table_name, key)
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

    async def _transact_get_items(self, body: dict) -> Response:
        transact_items = body.get("TransactItems", [])
        responses: list[dict] = []
        for transact_item in transact_items:
            get = transact_item["Get"]
            item = await self.store.get_item(get["TableName"], get["Key"])
            if item is not None:
                responses.append({"Item": item})
            else:
                responses.append({})
        return _json_response({"Responses": responses})

    async def _describe_continuous_backups(self, body: dict) -> Response:
        body.get("TableName", "")
        return _json_response(
            {
                "ContinuousBackupsDescription": {
                    "ContinuousBackupsStatus": "DISABLED",
                    "PointInTimeRecoveryDescription": {
                        "PointInTimeRecoveryStatus": "DISABLED",
                    },
                }
            }
        )

    async def _update_time_to_live(self, body: dict) -> Response:
        ttl_spec = body.get("TimeToLiveSpecification", {})
        return _json_response(
            {
                "TimeToLiveSpecification": {
                    "AttributeName": ttl_spec.get("AttributeName", ""),
                    "Enabled": ttl_spec.get("Enabled", False),
                }
            }
        )


# ------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------


def _json_response(data: dict, status_code: int = 200) -> Response:
    return Response(
        content=json.dumps(data),
        status_code=status_code,
        media_type="application/x-amz-json-1.0",
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


_DYNAMO_TYPE_KEYS = {"S", "N", "B", "BOOL", "NULL", "L", "M", "SS", "NS", "BS"}


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


def _error_response(error_type: str, message: str) -> Response:
    return _json_response(
        {"__type": error_type, "message": message},
        status_code=400,
    )


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def create_dynamodb_app(
    store: IKeyValueStore,
    chaos: AwsChaosConfig | None = None,
) -> FastAPI:
    """Create a FastAPI application that speaks the DynamoDB wire protocol."""
    app = FastAPI()
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.JSON)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="dynamodb")
    dynamo_router = DynamoDbRouter(store)
    app.include_router(dynamo_router.router)
    return app
