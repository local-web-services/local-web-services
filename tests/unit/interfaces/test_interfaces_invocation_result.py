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
        result = InvocationResult(
            payload={"statusCode": 200},
            error=None,
            duration_ms=42.5,
            request_id="req-1",
        )
        assert result.payload == {"statusCode": 200}
        assert result.error is None
        assert result.duration_ms == 42.5
        assert result.request_id == "req-1"

    def test_error_result(self) -> None:
        result = InvocationResult(
            payload=None,
            error="RuntimeError: kaboom",
            duration_ms=1.0,
            request_id="req-2",
        )
        assert result.payload is None
        assert result.error == "RuntimeError: kaboom"
