"""Unit tests for AwsFakeRule dataclass defaults."""

from __future__ import annotations

from lws.providers._shared.aws_operation_fake import (
    AwsFakeResponse,
    AwsFakeRule,
)


class TestAwsFakeRuleDefaults:
    def test_defaults(self):
        # Arrange
        expected_operation = "get-item"
        rule = AwsFakeRule(operation=expected_operation)

        # Act
        actual_operation = rule.operation
        actual_match_headers = rule.match_headers
        actual_response = rule.response

        # Assert
        assert actual_operation == expected_operation, (
            f"Expected {expected_operation!r} but got {actual_operation!r}"
        )
        assert actual_match_headers == {}, f"Expected {({})!r} but got {actual_match_headers!r}"
        assert isinstance(actual_response, AwsFakeResponse), (
            f"Expected instance of {AwsFakeResponse!r} but got {type(actual_response)!r}"
        )
        expected_status = 200
        assert actual_response.status == expected_status, (
            f"Expected {expected_status!r} but got {actual_response.status!r}"
        )
