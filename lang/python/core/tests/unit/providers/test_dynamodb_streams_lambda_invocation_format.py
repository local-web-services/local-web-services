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

from ._helpers import FakeLambdaHandler


class TestLambdaInvocationFormat:
    """Test the Lambda invocation event format matches DynamoDB Streams spec."""

    async def test_event_format(self) -> None:
        # Arrange
        handler = FakeLambdaHandler()
        dispatcher = StreamDispatcher(batch_window_ms=50)
        dispatcher.configure_stream(
            StreamConfiguration(
                table_name="orders",
                view_type=StreamViewType.NEW_AND_OLD_IMAGES,
                key_attributes=["orderId"],
            )
        )
        dispatcher.register_handler("orders", handler)
        expected_event_name = "INSERT"
        expected_event_version = "1.1"
        expected_event_source = "aws:dynamodb"
        expected_region = "local"

        await dispatcher.start()
        try:
            # Act
            await dispatcher.emit(
                event_name=EventName.INSERT,
                table_name="orders",
                keys={"orderId": "o1"},
                new_image={"orderId": "o1", "status": "new"},
            )
            await handler.wait_for_invocation(timeout=2.0)

            # Assert
            event = handler.invocations[0]
            assert "Records" in event, f'Expected {"Records"!r} to be in {event!r}'
            record = event["Records"][0]

            actual_event_name = record["eventName"]
            actual_event_version = record["eventVersion"]
            actual_event_source = record["eventSource"]
            actual_region = record["awsRegion"]
            assert "eventID" in record, f'Expected {"eventID"!r} to be in {record!r}'
            assert actual_event_name == expected_event_name, f"Expected {expected_event_name!r} but got {actual_event_name!r}"
            assert actual_event_version == expected_event_version, f"Expected {expected_event_version!r} but got {actual_event_version!r}"
            assert actual_event_source == expected_event_source, f"Expected {expected_event_source!r} but got {actual_event_source!r}"
            assert actual_region == expected_region, f"Expected {expected_region!r} but got {actual_region!r}"
            assert "eventSourceARN" in record, f'Expected {"eventSourceARN"!r} to be in {record!r}'
            assert "orders" in record["eventSourceARN"], f'Expected {"orders"!r} to be in {record["eventSourceARN"]!r}'

            # Verify dynamodb sub-object
            dynamodb = record["dynamodb"]
            assert "Keys" in dynamodb, f'Expected {"Keys"!r} to be in {dynamodb!r}'
            assert "SequenceNumber" in dynamodb, f'Expected {"SequenceNumber"!r} to be in {dynamodb!r}'
            assert "StreamViewType" in dynamodb, f'Expected {"StreamViewType"!r} to be in {dynamodb!r}'
            assert "ApproximateCreationDateTime" in dynamodb, f'Expected {"ApproximateCreationDateTime"!r} to be in {dynamodb!r}'
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
            assert dispatcher._running is True, "Expected value to be truthy"
        finally:
            await dispatcher.stop()
