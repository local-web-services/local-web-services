"""Tests for DynamoDB Streams emulation (P1-26)."""

from __future__ import annotations

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


class TestStreamViewTypeFiltering:
    """Test that different StreamViewTypes produce correct record content."""

    async def test_keys_only_stream(self) -> None:
        # Arrange
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
        expected_keys = {"userId": "u1"}

        await dispatcher.start()
        try:
            # Act
            await dispatcher.emit(
                event_name=EventName.INSERT,
                table_name="users",
                keys={"userId": "u1"},
                new_image={"userId": "u1", "name": "Alice"},
            )
            await handler.wait_for_invocation(timeout=2.0)

            # Assert
            record = handler.invocations[0]["Records"][0]
            dynamodb = record["dynamodb"]
            actual_keys = dynamodb["Keys"]
            assert actual_keys == expected_keys
            assert "NewImage" not in dynamodb
            assert "OldImage" not in dynamodb
        finally:
            await dispatcher.stop()

    async def test_new_image_stream(self) -> None:
        # Arrange
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
            # Act
            await dispatcher.emit(
                event_name=EventName.MODIFY,
                table_name="users",
                keys={"userId": "u1"},
                new_image={"userId": "u1", "name": "Bob"},
                old_image={"userId": "u1", "name": "Alice"},
            )
            await handler.wait_for_invocation(timeout=2.0)

            # Assert
            record = handler.invocations[0]["Records"][0]
            dynamodb = record["dynamodb"]
            assert "NewImage" in dynamodb
            assert "OldImage" not in dynamodb
        finally:
            await dispatcher.stop()
