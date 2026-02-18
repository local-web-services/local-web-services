"""Unit tests for generate_aws_mock_config_yaml."""

from __future__ import annotations

from lws.providers._shared.aws_mock_dsl import generate_aws_mock_config_yaml


class TestGenerateAwsMockConfigYaml:
    def test_contains_name_and_service(self):
        # Arrange
        expected_name_fragment = "name: my-mock"
        expected_service_fragment = "service: s3"

        # Act
        actual_yaml = generate_aws_mock_config_yaml("my-mock", "s3")

        # Assert
        assert expected_name_fragment in actual_yaml
        assert expected_service_fragment in actual_yaml

    def test_contains_enabled_true(self):
        # Arrange
        expected_enabled_fragment = "enabled: true"

        # Act
        actual_yaml = generate_aws_mock_config_yaml("my-mock", "dynamodb")

        # Assert
        assert expected_enabled_fragment in actual_yaml
