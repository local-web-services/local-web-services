"""Unit tests for parse_config in DSL parser."""

from __future__ import annotations

from lws.providers.mockserver.dsl import parse_config


class TestParseConfig:
    def test_basic_config(self, tmp_path):
        # Arrange
        config_file = tmp_path / "config.yaml"
        config_file.write_text(
            "name: test-api\n" "description: A test API\n" "port: 3100\n" "protocol: rest\n"
        )

        # Act
        config = parse_config(config_file)

        # Assert
        expected_name = "test-api"
        actual_name = config.name
        assert actual_name == expected_name
        expected_port = 3100
        actual_port = config.port
        assert actual_port == expected_port
        expected_protocol = "rest"
        actual_protocol = config.protocol
        assert actual_protocol == expected_protocol

    def test_config_with_chaos(self, tmp_path):
        # Arrange
        config_file = tmp_path / "config.yaml"
        config_file.write_text(
            "name: chaos-api\n"
            "chaos:\n"
            "  enabled: true\n"
            "  error_rate: 0.1\n"
            "  latency:\n"
            "    min_ms: 50\n"
            "    max_ms: 200\n"
        )

        # Act
        config = parse_config(config_file)

        # Assert
        assert config.chaos.enabled is True
        expected_error_rate = 0.1
        actual_error_rate = config.chaos.error_rate
        assert actual_error_rate == expected_error_rate
        expected_latency_min = 50
        actual_latency_min = config.chaos.latency_min_ms
        assert actual_latency_min == expected_latency_min
        expected_latency_max = 200
        actual_latency_max = config.chaos.latency_max_ms
        assert actual_latency_max == expected_latency_max

    def test_config_defaults(self, tmp_path):
        # Arrange
        config_file = tmp_path / "config.yaml"
        config_file.write_text("name: minimal\n")

        # Act
        config = parse_config(config_file)

        # Assert
        expected_content_type = "application/json"
        actual_content_type = config.defaults.content_type
        assert actual_content_type == expected_content_type
        expected_default_status = 200
        actual_default_status = config.defaults.status
        assert actual_default_status == expected_default_status
        assert config.chaos.enabled is False
