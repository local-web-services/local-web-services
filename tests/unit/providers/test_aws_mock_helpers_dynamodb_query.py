from __future__ import annotations

import json

from lws.providers._shared.aws_mock_helpers import expand_helpers


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
        assert actual_response.status == 200
        assert actual_response.content_type == expected_content_type
        assert actual_body["Items"] == expected_items
        assert actual_body["Count"] == expected_count
        assert actual_body["ScannedCount"] == expected_count
