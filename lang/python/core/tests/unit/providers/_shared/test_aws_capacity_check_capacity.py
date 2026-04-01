"""Unit tests: check_capacity() helper."""

from __future__ import annotations

from lws.providers._shared.aws_capacity import AwsCapacityConfig, check_capacity


class TestCheckCapacity:
    """check_capacity returns None when available, error response when exhausted."""

    def test_returns_none_when_slots_is_none(self) -> None:
        # Arrange
        config = AwsCapacityConfig(slots=None)
        expected_result = None

        # Act
        actual_result = check_capacity(config)

        # Assert
        assert (
            actual_result is expected_result
        ), f"Expected None when slots=None but got {actual_result!r}"

    def test_returns_none_when_slots_is_positive(self) -> None:
        # Arrange
        config = AwsCapacityConfig(slots=5)
        expected_result = None

        # Act
        actual_result = check_capacity(config)

        # Assert
        assert (
            actual_result is expected_result
        ), f"Expected None when slots=5 but got {actual_result!r}"

    def test_returns_error_response_when_slots_is_zero(self) -> None:
        # Arrange
        config = AwsCapacityConfig(slots=0)
        expected_status_code = 503

        # Act
        actual_result = check_capacity(config)

        # Assert
        assert actual_result is not None, "Expected a response when slots=0 but got None"
        actual_status_code = actual_result.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected status {expected_status_code} but got {actual_status_code}"

    def test_uses_custom_error_code(self) -> None:
        # Arrange
        config = AwsCapacityConfig(slots=0)
        expected_error_code = "TooManyRequestsException"

        # Act
        actual_result = check_capacity(config, error_code=expected_error_code)

        # Assert
        assert actual_result is not None, "Expected a response when slots=0 but got None"
        import json

        actual_body = json.loads(actual_result.body)
        actual_error_code = actual_body.get("__type")
        assert (
            actual_error_code == expected_error_code
        ), f"Expected error code {expected_error_code!r} but got {actual_error_code!r}"

    def test_uses_custom_status_code(self) -> None:
        # Arrange
        config = AwsCapacityConfig(slots=0)
        expected_status_code = 429

        # Act
        actual_result = check_capacity(config, status_code=expected_status_code)

        # Assert
        assert actual_result is not None, "Expected a response when slots=0 but got None"
        actual_status_code = actual_result.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected status {expected_status_code} but got {actual_status_code}"
