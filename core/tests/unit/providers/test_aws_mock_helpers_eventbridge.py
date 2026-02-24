from __future__ import annotations

import json

from lws.providers._shared.aws_mock_helpers import expand_helpers


class TestEventBridgePutEvents:
    def test_put_events_returns_entries_and_failed_count(self) -> None:
        # Arrange
        helpers = {"failed_count": 0, "entry_count": 1}
        expected_failed_count = 0
        expected_entry_count = 1
        expected_content_type = "application/x-amz-json-1.1"

        # Act
        actual_response = expand_helpers("events", "put-events", helpers)

        # Assert
        actual_body = json.loads(actual_response.body)
        assert actual_response.status == 200
        assert actual_response.content_type == expected_content_type
        assert actual_body["FailedEntryCount"] == expected_failed_count
        assert len(actual_body["Entries"]) == expected_entry_count
        assert "EventId" in actual_body["Entries"][0]
