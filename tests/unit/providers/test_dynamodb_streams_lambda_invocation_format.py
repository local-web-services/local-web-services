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
