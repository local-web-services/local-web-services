"""Tests for DynamoDB Streams emulation (P1-26)."""

from __future__ import annotations

import asyncio

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# StreamRecord tests
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# build_stream_record with StreamViewType tests
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# StreamDispatcher tests
# ---------------------------------------------------------------------------
from lws.providers.dynamodb.streams import (
    EventName,
    StreamConfiguration,
    StreamDispatcher,
    StreamViewType,
)

from ._helpers import MockLambdaHandler


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
