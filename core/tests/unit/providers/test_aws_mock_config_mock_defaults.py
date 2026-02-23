"""Unit tests for AwsMockConfig dataclass defaults."""

from __future__ import annotations

from lws.providers._shared.aws_operation_mock import AwsMockConfig


class TestAwsMockConfigDefaults:
    def test_defaults(self):
        # Arrange
        expected_service = "dynamodb"
        config = AwsMockConfig(service=expected_service)

        # Act
        actual_enabled = config.enabled
        actual_rules = config.rules
        actual_service = config.service

        # Assert
        assert actual_enabled is True
        assert actual_rules == []
        assert actual_service == expected_service
