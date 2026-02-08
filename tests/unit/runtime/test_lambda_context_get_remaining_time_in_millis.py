"""Tests for ldk.runtime.lambda_context (P1-03)."""

from __future__ import annotations

import time
from pathlib import Path
from unittest.mock import patch

from ldk.interfaces import ComputeConfig
from ldk.runtime.lambda_context import build_lambda_context

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _make_config(**overrides) -> ComputeConfig:
    defaults = dict(
        function_name="my-func",
        handler="handler.main",
        runtime="python3.11",
        code_path=Path("/tmp/code"),
        timeout=30,
        memory_size=256,
        environment={},
    )
    defaults.update(overrides)
    return ComputeConfig(**defaults)


# ---------------------------------------------------------------------------
# build_lambda_context tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# get_remaining_time_in_millis tests
# ---------------------------------------------------------------------------


class TestGetRemainingTimeInMillis:
    """Verify the countdown timer works correctly."""

    def test_initial_remaining_time_is_close_to_timeout(self) -> None:
        ctx = build_lambda_context(_make_config(timeout=30))
        remaining = ctx.get_remaining_time_in_millis()
        # Should be very close to 30000ms (within a small tolerance)
        assert 29900 <= remaining <= 30000

    def test_remaining_time_decreases_over_time(self) -> None:
        ctx = build_lambda_context(_make_config(timeout=30))
        first = ctx.get_remaining_time_in_millis()
        # Simulate a small delay
        time.sleep(0.05)
        second = ctx.get_remaining_time_in_millis()
        assert second < first

    def test_remaining_time_never_goes_negative(self) -> None:
        """Even after the timeout has elapsed, remaining should be 0."""
        ctx = build_lambda_context(_make_config(timeout=0))
        # The timeout is 0 seconds, so remaining should already be 0
        remaining = ctx.get_remaining_time_in_millis()
        assert remaining == 0

    @patch("time.monotonic")
    def test_countdown_with_mocked_time(self, mock_monotonic) -> None:
        """Use mocked time to verify exact countdown calculation."""
        # Set start_time to 100.0, then mock monotonic to return 105.0 (5s elapsed)
        mock_monotonic.return_value = 105.0

        ctx = build_lambda_context(_make_config(timeout=30))
        # Override _start_time to a known value since default_factory captures
        # the real time.monotonic function reference at class definition time.
        ctx._start_time = 100.0
        remaining = ctx.get_remaining_time_in_millis()

        # 30s timeout - 5s elapsed = 25s = 25000ms
        assert remaining == 25000
