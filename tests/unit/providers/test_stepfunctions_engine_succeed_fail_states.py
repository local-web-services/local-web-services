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


class TestSucceedFailStates:
    """Succeed and Fail terminal states."""

    async def test_succeed_state(self) -> None:
        history = await run_engine(
            {"StartAt": "S", "States": {"S": {"Type": "Succeed"}}},
            input_data={"ok": True},
        )
        assert history.status == ExecutionStatus.SUCCEEDED
        assert history.output_data == {"ok": True}

    async def test_fail_state(self) -> None:
        history = await run_engine(
            {
                "StartAt": "F",
                "States": {
                    "F": {
                        "Type": "Fail",
                        "Error": "MyError",
                        "Cause": "bad input",
                    }
                },
            },
        )
        assert history.status == ExecutionStatus.FAILED
        assert history.error == "MyError"
        assert history.cause == "bad input"

    async def test_fail_without_error(self) -> None:
        history = await run_engine(
            {"StartAt": "F", "States": {"F": {"Type": "Fail"}}},
        )
        assert history.status == ExecutionStatus.FAILED
        assert history.error == "States.Fail"
