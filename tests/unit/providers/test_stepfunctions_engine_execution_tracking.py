"""Tests for the Step Functions execution engine.

Covers all state types, path processing, retry/catch, parallel and map
execution, wait states, and error handling.
"""

from __future__ import annotations

from typing import Any

from lws.providers.stepfunctions.asl_parser import parse_definition
from lws.providers.stepfunctions.engine import (
    ExecutionEngine,
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


class TestExecutionTracking:
    """Execution history and state transitions."""

    async def test_transitions_recorded(self) -> None:
        history = await run_engine(
            {
                "StartAt": "A",
                "States": {
                    "A": {"Type": "Pass", "Result": 1, "Next": "B"},
                    "B": {"Type": "Pass", "Result": 2, "Next": "C"},
                    "C": {"Type": "Succeed"},
                },
            },
        )
        assert len(history.transitions) == 3
        names = [t.state_name for t in history.transitions]
        assert names == ["A", "B", "C"]

    async def test_transition_has_input_output(self) -> None:
        history = await run_engine(
            {
                "StartAt": "P",
                "States": {"P": {"Type": "Pass", "Result": "hello", "End": True}},
            },
            input_data={"orig": True},
        )
        t = history.transitions[0]
        assert t.input_data == {"orig": True}
        assert t.output_data == "hello"

    async def test_execution_arn_set(self) -> None:
        history = await run_engine(
            {"StartAt": "S", "States": {"S": {"Type": "Succeed"}}},
        )
        assert "arn:aws:states" in history.execution_arn

    async def test_timing_recorded(self) -> None:
        history = await run_engine(
            {"StartAt": "S", "States": {"S": {"Type": "Succeed"}}},
        )
        assert history.start_time > 0
        assert history.end_time is not None
        assert history.end_time >= history.start_time
