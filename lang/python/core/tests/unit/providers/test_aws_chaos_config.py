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
        assert actual_enabled is False, "Expected value to be truthy"
        assert actual_error_rate == 0.0, f"Expected {0.0!r} but got {actual_error_rate!r}"
        assert actual_latency_min == 0, f"Expected {0!r} but got {actual_latency_min!r}"
        assert actual_latency_max == 0, f"Expected {0!r} but got {actual_latency_max!r}"
        assert actual_errors == [], f"Expected {[]!r} but got {actual_errors!r}"
        assert actual_connection_reset == 0.0, (
            f"Expected {0.0!r} but got {actual_connection_reset!r}"
        )
        assert actual_timeout == 0.0, f"Expected {0.0!r} but got {actual_timeout!r}"
