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
    StreamRecord,
)


class TestStreamRecord:
    """Test StreamRecord serialization."""

    def test_to_dynamodb_event_record_insert(self) -> None:
        # Arrange
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
        expected_event_name = "INSERT"
        expected_event_source = "aws:dynamodb"
        expected_keys = {"userId": {"S": "u1"}}

        # Act
        result = record.to_dynamodb_event_record()

        # Assert
        actual_event_name = result["eventName"]
        actual_event_source = result["eventSource"]
        actual_keys = result["dynamodb"]["Keys"]
        assert actual_event_name == expected_event_name
        assert actual_event_source == expected_event_source
        assert actual_keys == expected_keys
        assert "NewImage" in result["dynamodb"]
        assert "OldImage" not in result["dynamodb"]

    def test_to_dynamodb_event_record_modify(self) -> None:
        # Arrange
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
        expected_event_name = "MODIFY"

        # Act
        result = record.to_dynamodb_event_record()

        # Assert
        actual_event_name = result["eventName"]
        assert actual_event_name == expected_event_name
        assert "NewImage" in result["dynamodb"]
        assert "OldImage" in result["dynamodb"]

    def test_to_dynamodb_event_record_remove(self) -> None:
        # Arrange
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
        expected_event_name = "REMOVE"

        # Act
        result = record.to_dynamodb_event_record()

        # Assert
        actual_event_name = result["eventName"]
        assert actual_event_name == expected_event_name
        assert "NewImage" not in result["dynamodb"]
        assert "OldImage" in result["dynamodb"]
