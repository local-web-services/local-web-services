"""Unit tests for AwsFakeConfig dataclass defaults."""

from __future__ import annotations

from lws.providers._shared.aws_operation_fake import AwsFakeConfig


class TestAwsFakeConfigDefaults:
    def test_defaults(self):
        # Arrange
        expected_service = "dynamodb"
        config = AwsFakeConfig(service=expected_service)

        # Act
        actual_enabled = config.enabled
        actual_rules = config.rules
        actual_service = config.service

        # Assert
        assert actual_enabled is True, "Expected value to be truthy"
        assert actual_rules == [], f"Expected {[]!r} but got {actual_rules!r}"
        assert (
            actual_service == expected_service
        ), f"Expected {expected_service!r} but got {actual_service!r}"
