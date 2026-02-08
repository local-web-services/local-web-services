"""Tests for LDK interface definitions (P0-07 through P0-10)."""

import time

from ldk.interfaces import (
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
        ctx = self._make_context()
        assert ctx.function_name == "my-func"
        assert ctx.memory_limit_in_mb == 128
        assert ctx.timeout_seconds == 30
        assert ctx.aws_request_id == "abc-123"
        assert ctx.invoked_function_arn.startswith("arn:aws:lambda")

    def test_remaining_time_starts_near_timeout(self) -> None:
        ctx = self._make_context(timeout=10)
        remaining = ctx.get_remaining_time_in_millis()
        # Should be close to 10000 ms (allow 500ms tolerance for test overhead)
        assert 9500 <= remaining <= 10000

    def test_remaining_time_decreases(self) -> None:
        ctx = self._make_context(timeout=10)
        first = ctx.get_remaining_time_in_millis()
        time.sleep(0.05)
        second = ctx.get_remaining_time_in_millis()
        assert second < first

    def test_remaining_time_never_negative(self) -> None:
        ctx = LambdaContext(
            function_name="f",
            memory_limit_in_mb=128,
            timeout_seconds=0,
            aws_request_id="x",
            invoked_function_arn="arn",
            _start_time=time.monotonic() - 100,
        )
        assert ctx.get_remaining_time_in_millis() == 0
