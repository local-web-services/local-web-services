from __future__ import annotations

import json

from lws.providers._shared.aws_fake_helpers import expand_helpers


class TestDynamoDBQuery:
    def test_query_returns_items_with_count(self) -> None:
        # Arrange
        helpers = {
            "items": [{"id": "1"}, {"id": "2"}],
            "count": 2,
        }
        expected_items = [
            {"id": {"S": "1"}},
            {"id": {"S": "2"}},
        ]
        expected_count = 2
        expected_content_type = "application/x-amz-json-1.0"

        # Act
        actual_response = expand_helpers("dynamodb", "query", helpers)

        # Assert
        actual_body = json.loads(actual_response.body)
        assert actual_response.status == 200, f"Expected {200!r} but got {actual_response.status!r}"
        assert (
            actual_response.content_type == expected_content_type
        ), f"Expected {expected_content_type!r} but got {actual_response.content_type!r}"
        assert (
            actual_body["Items"] == expected_items
        ), f'Expected {expected_items!r} but got {actual_body["Items"]!r}'
        assert (
            actual_body["Count"] == expected_count
        ), f'Expected {expected_count!r} but got {actual_body["Count"]!r}'
        assert (
            actual_body["ScannedCount"] == expected_count
        ), f'Expected {expected_count!r} but got {actual_body["ScannedCount"]!r}'
