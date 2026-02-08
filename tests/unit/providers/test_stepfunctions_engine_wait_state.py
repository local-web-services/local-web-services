"""Tests for the Step Functions execution engine.

Covers all state types, path processing, retry/catch, parallel and map
execution, wait states, and error handling.
"""

from __future__ import annotations

from typing import Any

from ldk.providers.stepfunctions.asl_parser import parse_definition
from ldk.providers.stepfunctions.engine import (
    ExecutionEngine,
    ExecutionStatus,
)

# ---------------------------------------------------------------------------
# Mock compute invoker
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


async def run_engine(
    definition: dict,
    input_data: Any = None,
    compute: Any | None = None,
    max_wait: float = 0.01,
) -> Any:
    """Parse and execute a definition, returning the execution history."""
    defn = parse_definition(definition)
    engine = ExecutionEngine(defn, compute=compute, max_wait_seconds=max_wait)
    return await engine.execute(input_data)


# ---------------------------------------------------------------------------
# P2-08: Pass state and basic execution
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Succeed / Fail states
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P2-09: Task state with Lambda invocation
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P2-11: Wait state
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P2-12: Retry and Catch
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P2-10 + P2-08: Choice state (tested via engine)
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P2-13: Parallel state
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P2-14: Map state
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P2-15: Execution tracking
# ---------------------------------------------------------------------------


class TestWaitState:
    """Wait state with various time specifications."""

    async def test_wait_seconds(self) -> None:
        history = await run_engine(
            {
                "StartAt": "W",
                "States": {
                    "W": {"Type": "Wait", "Seconds": 1, "Next": "Done"},
                    "Done": {"Type": "Succeed"},
                },
            },
            input_data={"x": 1},
        )
        assert history.status == ExecutionStatus.SUCCEEDED

    async def test_wait_seconds_path(self) -> None:
        history = await run_engine(
            {
                "StartAt": "W",
                "States": {
                    "W": {"Type": "Wait", "SecondsPath": "$.delay", "Next": "Done"},
                    "Done": {"Type": "Succeed"},
                },
            },
            input_data={"delay": 1},
        )
        assert history.status == ExecutionStatus.SUCCEEDED

    async def test_wait_preserves_input(self) -> None:
        history = await run_engine(
            {
                "StartAt": "W",
                "States": {
                    "W": {"Type": "Wait", "Seconds": 0, "Next": "Done"},
                    "Done": {"Type": "Succeed"},
                },
            },
            input_data={"preserved": True},
        )
        assert history.output_data == {"preserved": True}
