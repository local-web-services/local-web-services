from __future__ import annotations

import json

from lws.providers._shared.aws_mock_helpers import expand_helpers


class TestDynamoDBGetItem:
    def test_get_item_returns_dynamodb_formatted_item(self) -> None:
        # Arrange
        helpers = {"item": {"id": "user-1", "name": "Alice"}}
        expected_item = {
            "id": {"S": "user-1"},
            "name": {"S": "Alice"},
        }
        expected_content_type = "application/x-amz-json-1.0"

        # Act
        actual_response = expand_helpers("dynamodb", "get-item", helpers)

        # Assert
        actual_body = json.loads(actual_response.body)
        assert actual_response.status == 200
        assert actual_response.content_type == expected_content_type
        assert actual_body["Item"] == expected_item
