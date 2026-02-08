"""Tests for DynamoDB Streams emulation (P1-26)."""

from __future__ import annotations

import asyncio
from typing import Any

from ldk.providers.dynamodb.streams import (
    EventName,
    StreamConfiguration,
    StreamDispatcher,
    StreamRecord,
    StreamViewType,
    build_stream_record,
)

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


class MockLambdaHandler:
    """Collects stream events for assertions."""

    def __init__(self) -> None:
        self.invocations: list[dict[str, Any]] = []
        self._event = asyncio.Event()

    async def __call__(self, event: dict[str, Any]) -> None:
        self.invocations.append(event)
        self._event.set()

    async def wait_for_invocation(self, timeout: float = 2.0) -> None:
        """Wait until at least one invocation occurs."""
        await asyncio.wait_for(self._event.wait(), timeout=timeout)

    def reset(self) -> None:
        self.invocations.clear()
        self._event.clear()


# ---------------------------------------------------------------------------
# StreamRecord tests
# ---------------------------------------------------------------------------


class TestStreamRecord:
    """Test StreamRecord serialization."""

    def test_to_dynamodb_event_record_insert(self) -> None:
        record = StreamRecord(
            event_id="evt-1",
            event_name=EventName.INSERT,
            table_name="users",
            keys={"userId": {"S": "u1"}},
            new_image={"userId": {"S": "u1"}, "name": {"S": "Alice"}},
            old_image=None,
            sequence_number="100",
            approximate_creation_datetime=1700000000.0,
        )
        result = record.to_dynamodb_event_record()

        assert result["eventName"] == "INSERT"
        assert result["eventSource"] == "aws:dynamodb"
        assert result["dynamodb"]["Keys"] == {"userId": {"S": "u1"}}
        assert "NewImage" in result["dynamodb"]
        assert "OldImage" not in result["dynamodb"]

    def test_to_dynamodb_event_record_modify(self) -> None:
        record = StreamRecord(
            event_id="evt-2",
            event_name=EventName.MODIFY,
            table_name="users",
            keys={"userId": {"S": "u1"}},
            new_image={"userId": {"S": "u1"}, "name": {"S": "Bob"}},
            old_image={"userId": {"S": "u1"}, "name": {"S": "Alice"}},
            sequence_number="101",
            approximate_creation_datetime=1700000001.0,
        )
        result = record.to_dynamodb_event_record()

        assert result["eventName"] == "MODIFY"
        assert "NewImage" in result["dynamodb"]
        assert "OldImage" in result["dynamodb"]

    def test_to_dynamodb_event_record_remove(self) -> None:
        record = StreamRecord(
            event_id="evt-3",
            event_name=EventName.REMOVE,
            table_name="users",
            keys={"userId": {"S": "u1"}},
            new_image=None,
            old_image={"userId": {"S": "u1"}, "name": {"S": "Alice"}},
            sequence_number="102",
            approximate_creation_datetime=1700000002.0,
        )
        result = record.to_dynamodb_event_record()

        assert result["eventName"] == "REMOVE"
        assert "NewImage" not in result["dynamodb"]
        assert "OldImage" in result["dynamodb"]


# ---------------------------------------------------------------------------
# build_stream_record with StreamViewType tests
# ---------------------------------------------------------------------------


class TestBuildStreamRecord:
    """Test build_stream_record with different StreamViewTypes."""

    def _base_args(self) -> dict:
        return {
            "event_name": EventName.INSERT,
            "table_name": "users",
            "keys": {"userId": "u1"},
            "new_image": {"userId": "u1", "name": "Alice", "email": "a@b.com"},
            "old_image": None,
            "key_attributes": ["userId"],
        }

    def test_new_and_old_images(self) -> None:
        args = self._base_args()
        args["old_image"] = {"userId": "u1", "name": "OldAlice"}
        record = build_stream_record(
            **args,
            view_type=StreamViewType.NEW_AND_OLD_IMAGES,
        )
        assert record.new_image is not None
        assert record.old_image is not None

    def test_new_image_only(self) -> None:
        args = self._base_args()
        args["old_image"] = {"userId": "u1", "name": "OldAlice"}
        record = build_stream_record(
            **args,
            view_type=StreamViewType.NEW_IMAGE,
        )
        assert record.new_image is not None
        assert record.old_image is None

    def test_old_image_only(self) -> None:
        args = self._base_args()
        args["old_image"] = {"userId": "u1", "name": "OldAlice"}
        record = build_stream_record(
            **args,
            view_type=StreamViewType.OLD_IMAGE,
        )
        assert record.new_image is None
        assert record.old_image is not None

    def test_keys_only(self) -> None:
        args = self._base_args()
        args["old_image"] = {"userId": "u1", "name": "OldAlice"}
        record = build_stream_record(
            **args,
            view_type=StreamViewType.KEYS_ONLY,
        )
        assert record.new_image is None
        assert record.old_image is None

    def test_event_id_generated(self) -> None:
        args = self._base_args()
        record = build_stream_record(
            **args,
            view_type=StreamViewType.NEW_AND_OLD_IMAGES,
        )
        assert record.event_id  # non-empty
        assert record.sequence_number  # non-empty


# ---------------------------------------------------------------------------
# StreamDispatcher tests
# ---------------------------------------------------------------------------


class TestStreamDispatcher:
    """Test the stream dispatcher event emission and batching."""

    async def test_emit_invokes_handler(self) -> None:
        handler = MockLambdaHandler()
        dispatcher = StreamDispatcher(batch_window_ms=50)
        dispatcher.configure_stream(
            StreamConfiguration(
                table_name="users",
                view_type=StreamViewType.NEW_AND_OLD_IMAGES,
                key_attributes=["userId"],
            )
        )
        dispatcher.register_handler("users", handler)

        await dispatcher.start()
        try:
            await dispatcher.emit(
                event_name=EventName.INSERT,
                table_name="users",
                keys={"userId": "u1"},
                new_image={"userId": "u1", "name": "Alice"},
            )
            await handler.wait_for_invocation(timeout=2.0)
            assert len(handler.invocations) >= 1
            event = handler.invocations[0]
            assert "Records" in event
            assert len(event["Records"]) >= 1
            assert event["Records"][0]["eventName"] == "INSERT"
        finally:
            await dispatcher.stop()

    async def test_emit_without_config_is_noop(self) -> None:
        handler = MockLambdaHandler()
        dispatcher = StreamDispatcher(batch_window_ms=50)
        # No stream configured for "users"
        dispatcher.register_handler("users", handler)

        await dispatcher.start()
        try:
            await dispatcher.emit(
                event_name=EventName.INSERT,
                table_name="users",
                keys={"userId": "u1"},
            )
            await asyncio.sleep(0.15)
            assert len(handler.invocations) == 0
        finally:
            await dispatcher.stop()

    async def test_emit_without_handlers_is_noop(self) -> None:
        dispatcher = StreamDispatcher(batch_window_ms=50)
        dispatcher.configure_stream(StreamConfiguration(table_name="users"))
        # No handler registered

        await dispatcher.start()
        try:
            # Should not raise
            await dispatcher.emit(
                event_name=EventName.INSERT,
                table_name="users",
                keys={"userId": "u1"},
            )
            await asyncio.sleep(0.15)
        finally:
            await dispatcher.stop()

    async def test_batching_multiple_events(self) -> None:
        handler = MockLambdaHandler()
        dispatcher = StreamDispatcher(batch_window_ms=200)
        dispatcher.configure_stream(
            StreamConfiguration(
                table_name="users",
                view_type=StreamViewType.NEW_AND_OLD_IMAGES,
                key_attributes=["userId"],
            )
        )
        dispatcher.register_handler("users", handler)

        await dispatcher.start()
        try:
            # Emit multiple events quickly
            for i in range(5):
                await dispatcher.emit(
                    event_name=EventName.INSERT,
                    table_name="users",
                    keys={"userId": f"u{i}"},
                    new_image={"userId": f"u{i}", "name": f"User{i}"},
                )

            await handler.wait_for_invocation(timeout=2.0)
            # All events should be in one or few batches
            total_records = sum(len(inv["Records"]) for inv in handler.invocations)
            assert total_records == 5
        finally:
            await dispatcher.stop()

    async def test_stop_flushes_pending_events(self) -> None:
        handler = MockLambdaHandler()
        dispatcher = StreamDispatcher(batch_window_ms=5000)  # Long window
        dispatcher.configure_stream(
            StreamConfiguration(
                table_name="users",
                view_type=StreamViewType.NEW_AND_OLD_IMAGES,
                key_attributes=["userId"],
            )
        )
        dispatcher.register_handler("users", handler)

        await dispatcher.start()
        await dispatcher.emit(
            event_name=EventName.INSERT,
            table_name="users",
            keys={"userId": "u1"},
            new_image={"userId": "u1", "name": "Alice"},
        )
        # Stop should flush
        await dispatcher.stop()

        assert len(handler.invocations) >= 1
        total_records = sum(len(inv["Records"]) for inv in handler.invocations)
        assert total_records >= 1


class TestStreamViewTypeFiltering:
    """Test that different StreamViewTypes produce correct record content."""

    async def test_keys_only_stream(self) -> None:
        handler = MockLambdaHandler()
        dispatcher = StreamDispatcher(batch_window_ms=50)
        dispatcher.configure_stream(
            StreamConfiguration(
                table_name="users",
                view_type=StreamViewType.KEYS_ONLY,
                key_attributes=["userId"],
            )
        )
        dispatcher.register_handler("users", handler)

        await dispatcher.start()
        try:
            await dispatcher.emit(
                event_name=EventName.INSERT,
                table_name="users",
                keys={"userId": "u1"},
                new_image={"userId": "u1", "name": "Alice"},
            )
            await handler.wait_for_invocation(timeout=2.0)
            record = handler.invocations[0]["Records"][0]
            dynamodb = record["dynamodb"]
            assert dynamodb["Keys"] == {"userId": "u1"}
            assert "NewImage" not in dynamodb
            assert "OldImage" not in dynamodb
        finally:
            await dispatcher.stop()

    async def test_new_image_stream(self) -> None:
        handler = MockLambdaHandler()
        dispatcher = StreamDispatcher(batch_window_ms=50)
        dispatcher.configure_stream(
            StreamConfiguration(
                table_name="users",
                view_type=StreamViewType.NEW_IMAGE,
                key_attributes=["userId"],
            )
        )
        dispatcher.register_handler("users", handler)

        await dispatcher.start()
        try:
            await dispatcher.emit(
                event_name=EventName.MODIFY,
                table_name="users",
                keys={"userId": "u1"},
                new_image={"userId": "u1", "name": "Bob"},
                old_image={"userId": "u1", "name": "Alice"},
            )
            await handler.wait_for_invocation(timeout=2.0)
            record = handler.invocations[0]["Records"][0]
            dynamodb = record["dynamodb"]
            assert "NewImage" in dynamodb
            assert "OldImage" not in dynamodb
        finally:
            await dispatcher.stop()


class TestLambdaInvocationFormat:
    """Test the Lambda invocation event format matches DynamoDB Streams spec."""

    async def test_event_format(self) -> None:
        handler = MockLambdaHandler()
        dispatcher = StreamDispatcher(batch_window_ms=50)
        dispatcher.configure_stream(
            StreamConfiguration(
                table_name="orders",
                view_type=StreamViewType.NEW_AND_OLD_IMAGES,
                key_attributes=["orderId"],
            )
        )
        dispatcher.register_handler("orders", handler)

        await dispatcher.start()
        try:
            await dispatcher.emit(
                event_name=EventName.INSERT,
                table_name="orders",
                keys={"orderId": "o1"},
                new_image={"orderId": "o1", "status": "new"},
            )
            await handler.wait_for_invocation(timeout=2.0)

            event = handler.invocations[0]
            assert "Records" in event
            record = event["Records"][0]

            # Verify event structure
            assert "eventID" in record
            assert record["eventName"] == "INSERT"
            assert record["eventVersion"] == "1.1"
            assert record["eventSource"] == "aws:dynamodb"
            assert record["awsRegion"] == "local"
            assert "eventSourceARN" in record
            assert "orders" in record["eventSourceARN"]

            # Verify dynamodb sub-object
            dynamodb = record["dynamodb"]
            assert "Keys" in dynamodb
            assert "SequenceNumber" in dynamodb
            assert "StreamViewType" in dynamodb
            assert "ApproximateCreationDateTime" in dynamodb
        finally:
            await dispatcher.stop()

    async def test_handler_error_does_not_crash_dispatcher(self) -> None:
        """A handler that raises should not crash the dispatcher."""

        async def failing_handler(event: dict) -> None:
            raise RuntimeError("Intentional test failure")

        dispatcher = StreamDispatcher(batch_window_ms=50)
        dispatcher.configure_stream(StreamConfiguration(table_name="users"))
        dispatcher.register_handler("users", failing_handler)

        await dispatcher.start()
        try:
            await dispatcher.emit(
                event_name=EventName.INSERT,
                table_name="users",
                keys={"userId": "u1"},
                new_image={"userId": "u1"},
            )
            # Give time for the flush to process
            await asyncio.sleep(0.3)
            # Dispatcher should still be running
            assert dispatcher._running is True
        finally:
            await dispatcher.stop()
