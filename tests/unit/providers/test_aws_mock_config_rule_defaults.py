"""Unit tests for AwsMockRule dataclass defaults."""

from __future__ import annotations

from lws.providers._shared.aws_operation_mock import (
    AwsMockResponse,
    AwsMockRule,
)


class TestAwsMockRuleDefaults:
    def test_defaults(self):
        # Arrange
        expected_operation = "get-item"
        rule = AwsMockRule(operation=expected_operation)

        # Act
        actual_operation = rule.operation
        actual_match_headers = rule.match_headers
        actual_response = rule.response

        # Assert
        assert actual_operation == expected_operation
        assert actual_match_headers == {}
        assert isinstance(actual_response, AwsMockResponse)
        expected_status = 200
        assert actual_response.status == expected_status
