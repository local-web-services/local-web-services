"""Unit tests for parse_chaos_config."""

from __future__ import annotations

from lws.providers._shared.aws_chaos import parse_chaos_config


class TestParseChaosConfig:
    def test_parses_full_config(self):
        # Arrange
        raw = {
            "enabled": True,
            "error_rate": 0.3,
            "latency_min_ms": 50,
            "latency_max_ms": 200,
            "connection_reset_rate": 0.01,
            "timeout_rate": 0.02,
            "errors": [
                {"type": "ResourceNotFoundException", "message": "Not found", "weight": 0.7},
                {"type": "LimitExceededException", "message": "Rate exceeded", "weight": 0.3},
            ],
        }

        # Act
        config = parse_chaos_config(raw)

        # Assert
        assert config.enabled is True
        expected_error_rate = 0.3
        assert config.error_rate == expected_error_rate
        expected_latency_min = 50
        assert config.latency_min_ms == expected_latency_min
        expected_latency_max = 200
        assert config.latency_max_ms == expected_latency_max
        assert len(config.errors) == 2
        expected_first_type = "ResourceNotFoundException"
        assert config.errors[0].type == expected_first_type

    def test_parses_empty_config(self):
        # Arrange
        raw = {}

        # Act
        config = parse_chaos_config(raw)

        # Assert
        assert config.enabled is False
        assert config.error_rate == 0.0
        assert config.errors == []

    def test_parses_errors_with_explicit_status_code(self):
        # Arrange
        expected_status = 503
        raw = {
            "errors": [
                {
                    "type": "CustomError",
                    "message": "Custom",
                    "weight": 1.0,
                    "status_code": expected_status,
                }
            ]
        }

        # Act
        config = parse_chaos_config(raw)

        # Assert
        assert config.errors[0].status_code == expected_status
