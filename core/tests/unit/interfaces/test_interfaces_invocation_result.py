"""Tests for LDK interface definitions (P0-07 through P0-10)."""

from lws.interfaces import (
    InvocationResult,
)

# ---------------------------------------------------------------------------
# P0-07: Provider lifecycle
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P0-08: ICompute
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P0-09: IKeyValueStore
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P0-10: Remaining provider interfaces
# ---------------------------------------------------------------------------


class TestInvocationResult:
    """InvocationResult dataclass fields."""

    def test_success_result(self) -> None:
        # Arrange
        expected_payload = {"statusCode": 200}
        expected_duration_ms = 42.5
        expected_request_id = "req-1"

        # Act
        result = InvocationResult(
            payload=expected_payload,
            error=None,
            duration_ms=expected_duration_ms,
            request_id=expected_request_id,
        )

        # Assert
        assert result.payload == expected_payload
        assert result.error is None
        assert result.duration_ms == expected_duration_ms
        assert result.request_id == expected_request_id

    def test_error_result(self) -> None:
        # Arrange
        expected_error = "RuntimeError: kaboom"
        expected_duration_ms = 1.0
        expected_request_id = "req-2"

        # Act
        result = InvocationResult(
            payload=None,
            error=expected_error,
            duration_ms=expected_duration_ms,
            request_id=expected_request_id,
        )

        # Assert
        assert result.payload is None
        assert result.error == expected_error
