"""Unit tests for generate_config_yaml in DSL parser."""

from __future__ import annotations

from lws.providers.mockserver.dsl import generate_config_yaml


class TestGenerateConfigYaml:
    def test_basic_generation(self):
        # Arrange
        expected_name_line = "name: my-api"
        expected_protocol_line = "protocol: rest"

        # Act
        actual = generate_config_yaml("my-api")

        # Assert
        assert expected_name_line in actual
        assert expected_protocol_line in actual

    def test_with_port(self):
        # Arrange
        expected_port_line = "port: 4000"

        # Act
        actual = generate_config_yaml("api", port=4000)

        # Assert
        assert expected_port_line in actual
