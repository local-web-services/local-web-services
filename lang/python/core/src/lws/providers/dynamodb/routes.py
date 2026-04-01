"""DynamoDB wire protocol HTTP server.

Implements the DynamoDB JSON-over-HTTP protocol that AWS SDKs expect.
Each operation is dispatched based on the ``X-Amz-Target`` header value
(e.g. ``DynamoDB_20120810.PutItem``).
"""

from __future__ import annotations

import asyncio  # needed for Lock type in _transaction_locks

from fastapi import APIRouter, FastAPI, Request, Response

from lws.interfaces.cloudtrail import ICloudTrail  # noqa: TC001
from lws.interfaces.key_value_store import (
    IKeyValueStore,
)
from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_capacity import AwsCapacityConfig, check_capacity
from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsChaosMiddleware, ErrorFormat
from lws.providers._shared.aws_cloudtrail_middleware import apply_cloudtrail_middleware
from lws.providers._shared.aws_iam_auth import IamAuthBundle, add_iam_auth_middleware
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers._shared.aws_operation_fake import AwsFakeConfig, AwsOperationFakeMiddleware
from lws.providers.dynamodb._dynamodb_helpers import (
    _error_response,
    _json_response,
    _parse_table_config,
    _table_not_found_response,
    check_transact_conditions,
    check_transact_lifecycle,
    collect_transact_lock_keys,
    execute_transact_writes,
    transact_item_lock_key,
    try_acquire_transact_locks,
)

_logger = get_logger("ldk.dynamodb")

# Prefix the AWS SDK uses in the X-Amz-Target header.
_TARGET_PREFIX = "DynamoDB_20120810."


class DynamoDbRouter:
    """Route DynamoDB wire-protocol requests to an ``IKeyValueStore`` backend."""

    def __init__(
        self,
        store: IKeyValueStore,
        lifecycle: ResourceLifecycleConfig | None = None,
        capacity: AwsCapacityConfig | None = None,
    ) -> None:
        self.store = store
        self._lifecycle = lifecycle or ResourceLifecycleConfig()
        self._tracker = ResourceStateTracker(self._lifecycle)
        self._capacity = capacity or AwsCapacityConfig()
        self._transaction_locks: dict[str, asyncio.Lock] = {}
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

    def _get_lifecycle_error(self, table_name: str) -> Response | None:
        """Return an error if the table is in a non-operable lifecycle state."""
        status = self._tracker.get_state(table_name)
        if status == "CREATING":
            return _error_response(
                "ResourceInUseException",
                f"Table '{table_name}' is not yet ACTIVE",
            )
        if status == "DELETING":
            return _error_response(
                "ResourceNotFoundException",
                f"Requested resource not found: Table: {table_name} not found",
            )
        return None

    async def _get_item(self, body: dict) -> Response:
        cap_err = check_capacity(self._capacity, "ProvisionedThroughputExceededException", 400)
        if cap_err is not None:
            return cap_err
        table_name = body["TableName"]
        err = self._get_lifecycle_error(table_name)
        if err is not None:
            return err
        key = body["Key"]
        try:
            item = await self.store.get_item(table_name, key)
        except KeyError:
            return _table_not_found_response(table_name)
        result: dict = {}
        if item is not None:
            result["Item"] = item
        return _json_response(result)

    async def _put_item(self, body: dict) -> Response:
        cap_err = check_capacity(self._capacity, "ProvisionedThroughputExceededException", 400)
        if cap_err is not None:
            return cap_err
        table_name = body["TableName"]
        err = self._get_lifecycle_error(table_name)
        if err is not None:
            return err
        item = body["Item"]
        try:
            await self.store.put_item(table_name, item)
        except KeyError:
            return _table_not_found_response(table_name)
        return _json_response({})

    async def _delete_item(self, body: dict) -> Response:
        cap_err = check_capacity(self._capacity, "ProvisionedThroughputExceededException", 400)
        if cap_err is not None:
            return cap_err
        table_name = body["TableName"]
        err = self._get_lifecycle_error(table_name)
        if err is not None:
            return err
        key = body["Key"]
        try:
            await self.store.delete_item(table_name, key)
        except KeyError:
            return _table_not_found_response(table_name)
        return _json_response({})

    async def _update_item(self, body: dict) -> Response:
        cap_err = check_capacity(self._capacity, "ProvisionedThroughputExceededException", 400)
        if cap_err is not None:
            return cap_err
        table_name = body["TableName"]
        err = self._get_lifecycle_error(table_name)
        if err is not None:
            return err
        key = body["Key"]
        update_expression = body.get("UpdateExpression", "")
        expression_values = body.get("ExpressionAttributeValues")
        expression_names = body.get("ExpressionAttributeNames")
        try:
            updated = await self.store.update_item(
                table_name,
                key,
                update_expression,
                expression_values=expression_values,
                expression_names=expression_names,
            )
        except KeyError:
            return _table_not_found_response(table_name)
        return _json_response({"Attributes": updated})

    async def _query(self, body: dict) -> Response:
        cap_err = check_capacity(self._capacity, "ProvisionedThroughputExceededException", 400)
        if cap_err is not None:
            return cap_err
        table_name = body["TableName"]
        err = self._get_lifecycle_error(table_name)
        if err is not None:
            return err
        key_condition = body.get("KeyConditionExpression", "")
        expression_values = body.get("ExpressionAttributeValues")
        expression_names = body.get("ExpressionAttributeNames")
        index_name = body.get("IndexName")
        filter_expression = body.get("FilterExpression")
        try:
            items = await self.store.query(
                table_name,
                key_condition,
                expression_values=expression_values,
                expression_names=expression_names,
                index_name=index_name,
                filter_expression=filter_expression,
            )
        except KeyError:
            return _table_not_found_response(table_name)
        return _json_response({"Items": items, "Count": len(items)})

    async def _scan(self, body: dict) -> Response:
        cap_err = check_capacity(self._capacity, "ProvisionedThroughputExceededException", 400)
        if cap_err is not None:
            return cap_err
        table_name = body["TableName"]
        err = self._get_lifecycle_error(table_name)
        if err is not None:
            return err
        filter_expression = body.get("FilterExpression")
        expression_values = body.get("ExpressionAttributeValues")
        expression_names = body.get("ExpressionAttributeNames")
        try:
            items = await self.store.scan(
                table_name,
                filter_expression=filter_expression,
                expression_values=expression_values,
                expression_names=expression_names,
            )
        except KeyError:
            return _table_not_found_response(table_name)
        return _json_response({"Items": items, "Count": len(items)})

    async def _batch_get_item(self, body: dict) -> Response:
        cap_err = check_capacity(self._capacity, "ProvisionedThroughputExceededException", 400)
        if cap_err is not None:
            return cap_err
        request_items = body.get("RequestItems", {})
        responses: dict[str, list[dict]] = {}
        for table_name, table_req in request_items.items():
            keys = table_req.get("Keys", [])
            items = await self.store.batch_get_items(table_name, keys)
            responses[table_name] = items
        return _json_response({"Responses": responses})

    async def _batch_write_item(self, body: dict) -> Response:
        cap_err = check_capacity(self._capacity, "ProvisionedThroughputExceededException", 400)
        if cap_err is not None:
            return cap_err
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
        try:
            description = await self.store.create_table(config)
        except ValueError:
            return _error_response(
                "ResourceInUseException",
                f"Table already exists: {config.table_name}",
            )
        # Lifecycle: track CREATING state; mutate response only if dwell > 0
        if self._lifecycle.enabled:
            self._tracker.set_state(config.table_name, "CREATING")
            self._tracker.schedule_transition(
                config.table_name,
                "ACTIVE",
                self._lifecycle.create_dwell_ms,
            )
            if self._lifecycle.create_dwell_ms > 0:
                description = dict(description)
                description["TableStatus"] = "CREATING"
        return _json_response({"TableDescription": description})

    async def _delete_table(self, body: dict) -> Response:
        table_name = body.get("TableName", "")
        # If CREATING, block deletion
        status = self._tracker.get_state(table_name)
        if status == "CREATING":
            return _error_response(
                "ResourceInUseException",
                f"Table '{table_name}' is not yet ACTIVE",
            )
        try:
            description = await self.store.delete_table(table_name)
        except KeyError:
            return _error_response(
                "ResourceNotFoundException",
                f"Requested resource not found: Table: {table_name} not found",
            )
        # Lifecycle: track DELETING state; mutate response only if dwell > 0
        if self._lifecycle.enabled:
            self._tracker.set_state(table_name, "DELETING")
            self._tracker.schedule_transition(
                table_name,
                None,  # remove from tracker after dwell (table is already gone from store)
                self._lifecycle.delete_dwell_ms,
            )
            if self._lifecycle.delete_dwell_ms > 0:
                description = dict(description)
                description["TableStatus"] = "DELETING"
        return _json_response({"TableDescription": description})

    async def _describe_table(self, body: dict) -> Response:
        table_name = body.get("TableName", "")
        err = self._get_lifecycle_error(table_name)
        if err is not None:
            return err
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

    def _item_lock_key(self, table_name: str, key: dict) -> str:
        """Return a string key identifying the item for lock tracking."""
        return transact_item_lock_key(table_name, key)

    async def _transact_write_items(self, body: dict) -> Response:
        cap_err = check_capacity(self._capacity, "ProvisionedThroughputExceededException", 400)
        if cap_err is not None:
            return cap_err
        transact_items = body.get("TransactItems", [])

        # Pass 0: lifecycle check — reject if any referenced table is not ACTIVE
        lifecycle_err = await check_transact_lifecycle(self._get_lifecycle_error, transact_items)
        if lifecycle_err is not None:
            return lifecycle_err

        lock_keys = collect_transact_lock_keys(transact_items)
        acquired, conflict_err = await try_acquire_transact_locks(
            self._transaction_locks, lock_keys
        )
        if conflict_err is not None:
            return conflict_err

        try:
            failure = await check_transact_conditions(self.store, transact_items)
            if failure is not None:
                return failure
            await execute_transact_writes(self.store, transact_items)
            return _json_response({})
        finally:
            for held_key in acquired:
                if self._transaction_locks[held_key].locked():
                    self._transaction_locks[held_key].release()

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
# App factory
# ------------------------------------------------------------------


def create_dynamodb_app(
    store: IKeyValueStore,
    chaos: AwsChaosConfig | None = None,
    aws_fake: AwsFakeConfig | None = None,
    iam_auth: IamAuthBundle | None = None,
    lifecycle: ResourceLifecycleConfig | None = None,
    capacity: AwsCapacityConfig | None = None,
    tracker_ref: list | None = None,
    cloudtrail_provider: ICloudTrail | None = None,
) -> FastAPI:
    """Create a FastAPI application that speaks the DynamoDB wire protocol."""
    app = FastAPI()
    if aws_fake is not None:
        app.add_middleware(AwsOperationFakeMiddleware, fake_config=aws_fake, service="dynamodb")
    add_iam_auth_middleware(app, "dynamodb", iam_auth, ErrorFormat.JSON)
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.JSON)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="dynamodb")
    dynamo_router = DynamoDbRouter(store, lifecycle=lifecycle, capacity=capacity)
    if tracker_ref is not None:
        tracker_ref.append(dynamo_router._tracker)  # pylint: disable=protected-access
    app.include_router(dynamo_router.router)
    apply_cloudtrail_middleware(app, cloudtrail_provider, "dynamodb")
    return app
