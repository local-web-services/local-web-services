"""Unit tests for AwsErrorSpec dataclass."""

from __future__ import annotations

from lws.providers._shared.aws_chaos import AwsErrorSpec


class TestAwsErrorSpec:
    def test_default_weight(self):
        # Arrange
        error = AwsErrorSpec(type="ResourceNotFoundException", message="Not found")

        # Act
        actual_weight = error.weight

        # Assert
        expected_weight = 1.0
        assert actual_weight == expected_weight

    def test_explicit_status_code(self):
        # Arrange
        expected_status = 503
        error = AwsErrorSpec(
            type="ServiceUnavailableException",
            message="Service unavailable",
            status_code=expected_status,
        )

        # Act
        actual_status = error.status_code

        # Assert
        assert actual_status == expected_status
