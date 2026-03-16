"""Tests for LDK interface definitions (P0-07 through P0-10)."""

import time

from lws.interfaces import (
    LambdaContext,
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


class TestLambdaContext:
    """LambdaContext dataclass and remaining-time logic."""

    def _make_context(self, timeout: int = 30) -> LambdaContext:
        return LambdaContext(
            function_name="my-func",
            memory_limit_in_mb=128,
            timeout_seconds=timeout,
            aws_request_id="abc-123",
            invoked_function_arn="arn:aws:lambda:us-east-1:123456789012:function:my-func",
        )

    def test_fields_set(self) -> None:
        # Arrange
        expected_function_name = "my-func"
        expected_memory_limit = 128
        expected_timeout = 30
        expected_request_id = "abc-123"
        expected_arn_prefix = "arn:aws:lambda"

        # Act
        ctx = self._make_context()

        # Assert
        assert ctx.function_name == expected_function_name
        assert ctx.memory_limit_in_mb == expected_memory_limit
        assert ctx.timeout_seconds == expected_timeout
        assert ctx.aws_request_id == expected_request_id
        assert ctx.invoked_function_arn.startswith(expected_arn_prefix)

    def test_remaining_time_starts_near_timeout(self) -> None:
        # Arrange
        expected_min_remaining_ms = 9500
        expected_max_remaining_ms = 10000

        # Act
        ctx = self._make_context(timeout=10)
        actual_remaining = ctx.get_remaining_time_in_millis()

        # Assert — should be close to 10000 ms (allow 500ms tolerance for test overhead)
        assert expected_min_remaining_ms <= actual_remaining <= expected_max_remaining_ms

    def test_remaining_time_decreases(self) -> None:
        # Arrange
        ctx = self._make_context(timeout=10)

        # Act
        first = ctx.get_remaining_time_in_millis()
        time.sleep(0.05)
        second = ctx.get_remaining_time_in_millis()

        # Assert
        assert second < first

    def test_remaining_time_never_negative(self) -> None:
        # Arrange
        expected_remaining = 0
        ctx = LambdaContext(
            function_name="f",
            memory_limit_in_mb=128,
            timeout_seconds=0,
            aws_request_id="x",
            invoked_function_arn="arn",
            _start_time=time.monotonic() - 100,
        )

        # Act
        actual_remaining = ctx.get_remaining_time_in_millis()

        # Assert
        assert actual_remaining == expected_remaining
