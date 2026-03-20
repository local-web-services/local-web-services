"""Unit tests for generate_aws_fake_config_yaml."""

from __future__ import annotations

from lws.providers._shared.aws_fake_dsl import generate_aws_fake_config_yaml


class TestGenerateAwsFakeConfigYaml:
    def test_contains_name_and_service(self):
        # Arrange
        expected_name_fragment = "name: my-fake"
        expected_service_fragment = "service: s3"

        # Act
        actual_yaml = generate_aws_fake_config_yaml("my-fake", "s3")

        # Assert
        assert expected_name_fragment in actual_yaml, f"Expected {expected_name_fragment!r} to be in {actual_yaml!r}"
        assert expected_service_fragment in actual_yaml, f"Expected {expected_service_fragment!r} to be in {actual_yaml!r}"

    def test_contains_enabled_true(self):
        # Arrange
        expected_enabled_fragment = "enabled: true"

        # Act
        actual_yaml = generate_aws_fake_config_yaml("my-fake", "dynamodb")

        # Assert
        assert expected_enabled_fragment in actual_yaml, f"Expected {expected_enabled_fragment!r} to be in {actual_yaml!r}"
