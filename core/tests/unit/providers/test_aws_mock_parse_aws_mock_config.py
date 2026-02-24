"""Unit tests for parse_aws_mock_config."""

from __future__ import annotations

from lws.providers._shared.aws_operation_mock import parse_aws_mock_config


class TestParseAwsMockConfig:
    def test_parses_config_with_rules(self):
        # Arrange
        raw = {
            "service": "dynamodb",
            "enabled": True,
            "rules": [
                {
                    "operation": "get-item",
                    "response": {"status": 200, "body": {"Item": {}}},
                },
                {
                    "operation": "put-item",
                    "response": {"status": 200},
                },
            ],
        }

        # Act
        config = parse_aws_mock_config(raw)

        # Assert
        expected_service = "dynamodb"
        assert config.service == expected_service
        assert config.enabled is True
        expected_rule_count = 2
        assert len(config.rules) == expected_rule_count
        expected_first_operation = "get-item"
        assert config.rules[0].operation == expected_first_operation
        expected_second_operation = "put-item"
        assert config.rules[1].operation == expected_second_operation

    def test_parses_empty_dict(self):
        # Arrange
        raw = {}

        # Act
        config = parse_aws_mock_config(raw)

        # Assert
        expected_service = ""
        assert config.service == expected_service
        assert config.enabled is True
        assert config.rules == []
