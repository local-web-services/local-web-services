"""Unit tests for parse_fake_rule."""

from __future__ import annotations

from lws.providers._shared.aws_operation_fake import parse_fake_rule


class TestParseFakeRule:
    def test_parses_rule_with_match_headers(self):
        # Arrange
        raw = {
            "operation": "get-item",
            "match": {
                "headers": {"x-amz-target": "DynamoDB_20120810.GetItem"},
            },
            "response": {
                "status": 200,
                "body": {"Item": {}},
            },
        }

        # Act
        rule = parse_fake_rule(raw)

        # Assert
        expected_operation = "get-item"
        assert rule.operation == expected_operation, f"Expected {expected_operation!r} but got {rule.operation!r}"
        expected_header_value = "DynamoDB_20120810.GetItem"
        assert rule.match_headers["x-amz-target"] == expected_header_value, f'Expected {expected_header_value!r} but got {rule.match_headers["x-amz-target"]!r}'
        expected_status = 200
        assert rule.response.status == expected_status, f"Expected {expected_status!r} but got {rule.response.status!r}"
        expected_body = {"Item": {}}
        assert rule.response.body == expected_body, f"Expected {expected_body!r} but got {rule.response.body!r}"
