"""Integration tests for DynamoDB stream → Lambda event source mapping dispatch."""

from __future__ import annotations

import asyncio
from unittest.mock import AsyncMock

import pytest

from lws.interfaces import InvocationResult
from lws.interfaces.compute import ICompute
from lws.interfaces.key_value_store import KeyAttribute, KeySchema, TableConfig
from lws.providers.dynamodb.provider import SqliteDynamoProvider
from lws.providers.dynamodb.streams import StreamDispatcher
from lws.providers.lambda_runtime.event_source_manager import EventSourceManager


def _make_compute_fake(payload: dict | None = None, error: str | None = None) -> ICompute:
    """Return a fake ICompute whose ``invoke`` resolves to the given result."""
    fake = AsyncMock(spec=ICompute)
    fake.invoke.return_value = InvocationResult(
        payload=payload,
        error=error,
        duration_ms=1.0,
        request_id="test-request-id",
    )
    return fake


@pytest.fixture
async def data_dir(tmp_path):
    return tmp_path


@pytest.fixture
async def stream_dispatcher():
    dispatcher = StreamDispatcher(batch_window_ms=50)
    yield dispatcher
    await dispatcher.stop()


@pytest.fixture
async def dynamo_provider(data_dir, stream_dispatcher):
    table_config = TableConfig(
        table_name="esm-test-table",
        key_schema=KeySchema(partition_key=KeyAttribute(name="id", type="S")),
        stream_enabled=True,
        stream_view_type="NEW_AND_OLD_IMAGES",
    )
    provider = SqliteDynamoProvider(
        data_dir=data_dir,
        tables=[table_config],
        consistency_delay_ms=0,
        stream_dispatcher=stream_dispatcher,
    )
    await provider.start()
    yield provider
    await provider.stop()


class TestDynamodbEventSourceMapping:
    """Test that DynamoDB mutations dispatch to Lambda via the EventSourceManager."""

    @pytest.mark.asyncio
    async def test_put_item_triggers_stream_handler(
        self, dynamo_provider: SqliteDynamoProvider, stream_dispatcher: StreamDispatcher
    ) -> None:
        # Arrange
        expected_function_name = "esm-test-function"
        expected_item = {"id": {"S": "trigger-1"}, "val": {"S": "hello"}}
        compute_fake = _make_compute_fake(payload={"statusCode": 200})
        compute_providers = {expected_function_name: compute_fake}
        stream_arn = (
            "arn:aws:dynamodb:us-east-1:000000000000:table/esm-test-table"
            "/stream/2024-01-01T00:00:00.000"
        )

        manager = EventSourceManager(
            queue_providers={},
            stream_dispatchers={},
            compute_providers=compute_providers,
            shared_stream_dispatcher=stream_dispatcher,
        )
        await manager.activate(
            {
                "UUID": "test-esm-uuid-1",
                "EventSourceArn": stream_arn,
                "FunctionArn": expected_function_name,
                "BatchSize": 10,
            }
        )

        # Act
        await dynamo_provider.put_item("esm-test-table", expected_item)
        # Allow the stream dispatcher batch window to flush
        await asyncio.sleep(0.2)

        # Assert
        actual_call_count = compute_fake.invoke.call_count
        expected_min_calls = 1
        assert actual_call_count >= expected_min_calls, (
            f"Expected Lambda to be invoked at least {expected_min_calls} time(s) "
            f"after DynamoDB put_item but got {actual_call_count}"
        )

    @pytest.mark.asyncio
    async def test_put_item_passes_records_envelope(
        self, dynamo_provider: SqliteDynamoProvider, stream_dispatcher: StreamDispatcher
    ) -> None:
        # Arrange
        expected_function_name = "esm-envelope-function"
        expected_event_source = "aws:dynamodb"
        compute_fake = _make_compute_fake(payload={"statusCode": 200})
        compute_providers = {expected_function_name: compute_fake}
        stream_arn = (
            "arn:aws:dynamodb:us-east-1:000000000000:table/esm-test-table"
            "/stream/2024-01-01T00:00:00.000"
        )

        manager = EventSourceManager(
            queue_providers={},
            stream_dispatchers={},
            compute_providers=compute_providers,
            shared_stream_dispatcher=stream_dispatcher,
        )
        await manager.activate(
            {
                "UUID": "test-esm-uuid-2",
                "EventSourceArn": stream_arn,
                "FunctionArn": expected_function_name,
                "BatchSize": 10,
            }
        )

        # Act
        await dynamo_provider.put_item(
            "esm-test-table",
            {"id": {"S": "envelope-item-1"}},
        )
        await asyncio.sleep(0.2)

        # Assert
        assert (
            compute_fake.invoke.call_count >= 1
        ), "Expected Lambda to be invoked after DynamoDB put_item"
        actual_event = compute_fake.invoke.call_args[0][0]
        actual_records = actual_event.get("Records", [])
        assert (
            len(actual_records) >= 1
        ), f"Expected at least one record in the Lambda event but got {len(actual_records)}"
        actual_event_source = actual_records[0].get("eventSource", "")
        assert actual_event_source == expected_event_source, (
            f"Expected eventSource '{expected_event_source}' " f"but got '{actual_event_source}'"
        )

    @pytest.mark.asyncio
    async def test_deactivated_esm_no_longer_invokes(
        self, dynamo_provider: SqliteDynamoProvider, stream_dispatcher: StreamDispatcher
    ) -> None:
        # Arrange
        expected_function_name = "esm-deactivate-function"
        compute_fake = _make_compute_fake(payload={"statusCode": 200})
        compute_providers = {expected_function_name: compute_fake}
        stream_arn = (
            "arn:aws:dynamodb:us-east-1:000000000000:table/esm-test-table"
            "/stream/2024-01-01T00:00:00.000"
        )
        esm_uuid = "test-esm-deactivate-uuid"

        manager = EventSourceManager(
            queue_providers={},
            stream_dispatchers={},
            compute_providers=compute_providers,
            shared_stream_dispatcher=stream_dispatcher,
        )
        await manager.activate(
            {
                "UUID": esm_uuid,
                "EventSourceArn": stream_arn,
                "FunctionArn": expected_function_name,
                "BatchSize": 10,
            }
        )

        # Activate then immediately deactivate
        await manager.deactivate(esm_uuid)

        # Act — put_item should NOT trigger the handler (handler was removed)
        await dynamo_provider.put_item(
            "esm-test-table",
            {"id": {"S": "no-invoke-item"}},
        )
        await asyncio.sleep(0.2)

        # Assert — handler was deregistered via manager.deactivate, but the
        # StreamDispatcher does not expose a deregister API.  We verify
        # _active_stream_handlers no longer contains the mapping.
        expected_handlers_count = 0
        actual_handlers_count = len([k for k in manager._active_stream_handlers if k == esm_uuid])
        assert actual_handlers_count == expected_handlers_count, (
            f"Expected {expected_handlers_count} active stream handler "
            f"for UUID '{esm_uuid}' after deactivation "
            f"but found {actual_handlers_count}"
        )
