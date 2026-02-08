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

from ._helpers import MockCompute

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


class TestRetryAndCatch:
    """Retry and Catch error handling."""

    async def test_retry_succeeds_after_failures(self) -> None:
        compute = MockCompute({"fn": {"ok": True}})
        compute.set_error_until("fn", 2)  # fail first 2 attempts

        history = await run_engine(
            {
                "StartAt": "T",
                "States": {
                    "T": {
                        "Type": "Task",
                        "Resource": "fn",
                        "Retry": [
                            {
                                "ErrorEquals": ["States.TaskFailed"],
                                "MaxAttempts": 3,
                                "IntervalSeconds": 0,
                                "BackoffRate": 1.0,
                            }
                        ],
                        "End": True,
                    }
                },
            },
            compute=compute,
        )
        assert history.status == ExecutionStatus.SUCCEEDED
        assert history.output_data == {"ok": True}

    async def test_retry_exhausted_falls_through(self) -> None:
        compute = MockCompute({"fn": {"ok": True}})
        compute.set_error_until("fn", 100)  # always fail

        history = await run_engine(
            {
                "StartAt": "T",
                "States": {
                    "T": {
                        "Type": "Task",
                        "Resource": "fn",
                        "Retry": [
                            {
                                "ErrorEquals": ["States.TaskFailed"],
                                "MaxAttempts": 2,
                                "IntervalSeconds": 0,
                            }
                        ],
                        "End": True,
                    }
                },
            },
            compute=compute,
        )
        assert history.status == ExecutionStatus.FAILED

    async def test_catch_transitions_to_fallback(self) -> None:
        compute = MockCompute({"fn": {"ok": True}})
        compute.set_error_until("fn", 100)

        history = await run_engine(
            {
                "StartAt": "T",
                "States": {
                    "T": {
                        "Type": "Task",
                        "Resource": "fn",
                        "Catch": [
                            {
                                "ErrorEquals": ["States.ALL"],
                                "Next": "Fallback",
                                "ResultPath": "$.error",
                            }
                        ],
                        "End": True,
                    },
                    "Fallback": {
                        "Type": "Pass",
                        "Result": {"recovered": True},
                        "End": True,
                    },
                },
            },
            compute=compute,
        )
        assert history.status == ExecutionStatus.SUCCEEDED
        assert history.output_data == {"recovered": True}

    async def test_catch_error_info_in_result_path(self) -> None:
        compute = MockCompute({"fn": {"ok": True}})
        compute.set_error_until("fn", 100)

        history = await run_engine(
            {
                "StartAt": "T",
                "States": {
                    "T": {
                        "Type": "Task",
                        "Resource": "fn",
                        "Catch": [
                            {
                                "ErrorEquals": ["States.ALL"],
                                "Next": "HandleError",
                                "ResultPath": "$.errorInfo",
                            }
                        ],
                        "End": True,
                    },
                    "HandleError": {"Type": "Succeed"},
                },
            },
            input_data={"original": True},
            compute=compute,
        )
        assert history.status == ExecutionStatus.SUCCEEDED
        assert "errorInfo" in history.output_data
        assert history.output_data["errorInfo"]["Error"] == "States.TaskFailed"

    async def test_retry_then_catch(self) -> None:
        compute = MockCompute({"fn": {"ok": True}})
        compute.set_error_until("fn", 100)

        history = await run_engine(
            {
                "StartAt": "T",
                "States": {
                    "T": {
                        "Type": "Task",
                        "Resource": "fn",
                        "Retry": [
                            {
                                "ErrorEquals": ["States.TaskFailed"],
                                "MaxAttempts": 1,
                                "IntervalSeconds": 0,
                            }
                        ],
                        "Catch": [
                            {
                                "ErrorEquals": ["States.ALL"],
                                "Next": "Caught",
                            }
                        ],
                        "End": True,
                    },
                    "Caught": {
                        "Type": "Pass",
                        "Result": {"caught": True},
                        "End": True,
                    },
                },
            },
            compute=compute,
        )
        assert history.status == ExecutionStatus.SUCCEEDED
        assert history.output_data == {"caught": True}

    async def test_catch_specific_error(self) -> None:
        """Only catch specific error names."""
        compute = MockCompute({"fn": {"ok": True}})
        compute.set_error_until("fn", 100)

        history = await run_engine(
            {
                "StartAt": "T",
                "States": {
                    "T": {
                        "Type": "Task",
                        "Resource": "fn",
                        "Catch": [
                            {
                                "ErrorEquals": ["CustomError"],
                                "Next": "WrongCatch",
                            },
                            {
                                "ErrorEquals": ["States.TaskFailed"],
                                "Next": "RightCatch",
                            },
                        ],
                        "End": True,
                    },
                    "WrongCatch": {
                        "Type": "Pass",
                        "Result": {"wrong": True},
                        "End": True,
                    },
                    "RightCatch": {
                        "Type": "Pass",
                        "Result": {"right": True},
                        "End": True,
                    },
                },
            },
            compute=compute,
        )
        assert history.output_data == {"right": True}
