"""Unit tests for parse_aws_fake_config."""

from __future__ import annotations

from lws.providers._shared.aws_operation_fake import parse_aws_fake_config


class TestParseAwsFakeConfig:
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
        config = parse_aws_fake_config(raw)

        # Assert
        expected_service = "dynamodb"
        assert (
            config.service == expected_service
        ), f"Expected {expected_service!r} but got {config.service!r}"
        assert config.enabled is True, "Expected value to be truthy"
        expected_rule_count = 2
        assert (
            len(config.rules) == expected_rule_count
        ), f"Expected {expected_rule_count!r} but got {len(config.rules)!r}"
        expected_first_operation = "get-item"
        assert (
            config.rules[0].operation == expected_first_operation
        ), f"Expected {expected_first_operation!r} but got {config.rules[0].operation!r}"
        expected_second_operation = "put-item"
        assert (
            config.rules[1].operation == expected_second_operation
        ), f"Expected {expected_second_operation!r} but got {config.rules[1].operation!r}"

    def test_parses_empty_dict(self):
        # Arrange
        raw = {}

        # Act
        config = parse_aws_fake_config(raw)

        # Assert
        expected_service = ""
        assert (
            config.service == expected_service
        ), f"Expected {expected_service!r} but got {config.service!r}"
        assert config.enabled is True, "Expected value to be truthy"
        assert config.rules == [], f"Expected {[]!r} but got {config.rules!r}"
