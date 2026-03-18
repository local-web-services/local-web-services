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
        assert actual_enabled is True
        assert actual_rules == []
        assert actual_service == expected_service
