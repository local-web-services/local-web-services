"""DynamoDB wire protocol HTTP server.

Implements the DynamoDB JSON-over-HTTP protocol that AWS SDKs expect.
Each operation is dispatched based on the ``X-Amz-Target`` header value
(e.g. ``DynamoDB_20120810.PutItem``).
"""

from __future__ import annotations

import json

from fastapi import APIRouter, FastAPI, Request, Response

from lws.interfaces.key_value_store import IKeyValueStore
from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware

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
            return _error_response(
                "ValidationException",
                f"Unknown operation: {operation}",
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


# ------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------


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


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def create_dynamodb_app(store: IKeyValueStore) -> FastAPI:
    """Create a FastAPI application that speaks the DynamoDB wire protocol."""
    app = FastAPI()
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="dynamodb")
    dynamo_router = DynamoDbRouter(store)
    app.include_router(dynamo_router.router)
    return app
