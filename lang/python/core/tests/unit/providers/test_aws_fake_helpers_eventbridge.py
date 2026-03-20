from __future__ import annotations

import json

from lws.providers._shared.aws_fake_helpers import expand_helpers


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
        assert actual_response.status == 200, f"Expected {200!r} but got {actual_response.status!r}"
        assert (
            actual_response.content_type == expected_content_type
        ), f"Expected {expected_content_type!r} but got {actual_response.content_type!r}"
        assert (
            actual_body["FailedEntryCount"] == expected_failed_count
        ), f'Expected {expected_failed_count!r} but got {actual_body["FailedEntryCount"]!r}'
        assert (
            len(actual_body["Entries"]) == expected_entry_count
        ), f'Expected {expected_entry_count!r} but got {len(actual_body["Entries"])!r}'
        assert (
            "EventId" in actual_body["Entries"][0]
        ), f'Expected {"EventId"!r} to be in {actual_body["Entries"][0]!r}'
