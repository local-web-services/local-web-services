from __future__ import annotations

import json

from lws.providers._shared.aws_fake_helpers import expand_helpers


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
        assert actual_response.status == 200, f"Expected {200!r} but got {actual_response.status!r}"
        assert actual_response.content_type == expected_content_type, f"Expected {expected_content_type!r} but got {actual_response.content_type!r}"
        assert actual_body["Item"] == expected_item, f'Expected {expected_item!r} but got {actual_body["Item"]!r}'
