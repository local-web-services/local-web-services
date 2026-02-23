"""Unit tests for parse_mock_rule."""

from __future__ import annotations

from lws.providers._shared.aws_operation_mock import parse_mock_rule


class TestParseMockRule:
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
        rule = parse_mock_rule(raw)

        # Assert
        expected_operation = "get-item"
        assert rule.operation == expected_operation
        expected_header_value = "DynamoDB_20120810.GetItem"
        assert rule.match_headers["x-amz-target"] == expected_header_value
        expected_status = 200
        assert rule.response.status == expected_status
        expected_body = {"Item": {}}
        assert rule.response.body == expected_body
