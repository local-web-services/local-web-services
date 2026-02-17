"""Unit tests for AwsChaosConfig dataclass."""

from __future__ import annotations

from lws.providers._shared.aws_chaos import AwsChaosConfig


class TestAwsChaosConfig:
    def test_defaults(self):
        # Arrange
        config = AwsChaosConfig()

        # Act
        actual_enabled = config.enabled
        actual_error_rate = config.error_rate
        actual_latency_min = config.latency_min_ms
        actual_latency_max = config.latency_max_ms
        actual_errors = config.errors
        actual_connection_reset = config.connection_reset_rate
        actual_timeout = config.timeout_rate

        # Assert
        assert actual_enabled is False
        assert actual_error_rate == 0.0
        assert actual_latency_min == 0
        assert actual_latency_max == 0
        assert actual_errors == []
        assert actual_connection_reset == 0.0
        assert actual_timeout == 0.0
