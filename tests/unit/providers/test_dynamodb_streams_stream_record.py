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
