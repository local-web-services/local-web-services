"""Unit tests for _pick_error helper."""

from __future__ import annotations

from lws.providers._shared.aws_chaos import AwsChaosConfig, AwsErrorSpec, _pick_error


class TestPickError:
    def test_returns_default_when_no_errors_configured(self):
        # Arrange
        config = AwsChaosConfig(enabled=True, error_rate=1.0)

        # Act
        error = _pick_error(config)

        # Assert
        expected_type = "InternalServerError"
        assert error.type == expected_type
        expected_status = 500
        assert error.status_code == expected_status

    def test_returns_configured_error(self):
        # Arrange
        expected_type = "ResourceNotFoundException"
        config = AwsChaosConfig(
            enabled=True,
            error_rate=1.0,
            errors=[AwsErrorSpec(type=expected_type, message="Not found", weight=1.0)],
        )

        # Act
        error = _pick_error(config)

        # Assert
        assert error.type == expected_type
