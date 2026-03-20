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
        assert config.enabled is True, "Expected value to be truthy"
        expected_error_rate = 0.3
        assert (
            config.error_rate == expected_error_rate
        ), f"Expected {expected_error_rate!r} but got {config.error_rate!r}"
        expected_latency_min = 50
        assert (
            config.latency_min_ms == expected_latency_min
        ), f"Expected {expected_latency_min!r} but got {config.latency_min_ms!r}"
        expected_latency_max = 200
        assert (
            config.latency_max_ms == expected_latency_max
        ), f"Expected {expected_latency_max!r} but got {config.latency_max_ms!r}"
        assert len(config.errors) == 2, f"Expected {2!r} but got {len(config.errors)!r}"
        expected_first_type = "ResourceNotFoundException"
        assert (
            config.errors[0].type == expected_first_type
        ), f"Expected {expected_first_type!r} but got {config.errors[0].type!r}"

    def test_parses_empty_config(self):
        # Arrange
        raw = {}

        # Act
        config = parse_chaos_config(raw)

        # Assert
        assert config.enabled is False, "Expected value to be truthy"
        assert config.error_rate == 0.0, f"Expected {0.0!r} but got {config.error_rate!r}"
        assert config.errors == [], f"Expected {[]!r} but got {config.errors!r}"

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
        assert (
            config.errors[0].status_code == expected_status
        ), f"Expected {expected_status!r} but got {config.errors[0].status_code!r}"
