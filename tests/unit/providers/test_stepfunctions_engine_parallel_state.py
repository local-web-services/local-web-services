"""Tests for the Step Functions execution engine.

Covers all state types, path processing, retry/catch, parallel and map
execution, wait states, and error handling.
"""

from __future__ import annotations

from typing import Any

from lws.providers.stepfunctions.asl_parser import parse_definition
from lws.providers.stepfunctions.engine import (
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


class TestParallelState:
    """Parallel state concurrent execution."""

    async def test_parallel_basic(self) -> None:
        history = await run_engine(
            {
                "StartAt": "P",
                "States": {
                    "P": {
                        "Type": "Parallel",
                        "Branches": [
                            {
                                "StartAt": "B1",
                                "States": {
                                    "B1": {
                                        "Type": "Pass",
                                        "Result": "branch1",
                                        "End": True,
                                    }
                                },
                            },
                            {
                                "StartAt": "B2",
                                "States": {
                                    "B2": {
                                        "Type": "Pass",
                                        "Result": "branch2",
                                        "End": True,
                                    }
                                },
                            },
                        ],
                        "End": True,
                    }
                },
            },
        )
        assert history.status == ExecutionStatus.SUCCEEDED
        assert history.output_data == ["branch1", "branch2"]

    async def test_parallel_preserves_order(self) -> None:
        history = await run_engine(
            {
                "StartAt": "P",
                "States": {
                    "P": {
                        "Type": "Parallel",
                        "Branches": [
                            {
                                "StartAt": "B1",
                                "States": {
                                    "B1": {
                                        "Type": "Pass",
                                        "Result": "first",
                                        "End": True,
                                    }
                                },
                            },
                            {
                                "StartAt": "B2",
                                "States": {
                                    "B2": {
                                        "Type": "Pass",
                                        "Result": "second",
                                        "End": True,
                                    }
                                },
                            },
                            {
                                "StartAt": "B3",
                                "States": {
                                    "B3": {
                                        "Type": "Pass",
                                        "Result": "third",
                                        "End": True,
                                    }
                                },
                            },
                        ],
                        "End": True,
                    }
                },
            },
        )
        assert history.output_data == ["first", "second", "third"]

    async def test_parallel_branch_failure_with_catch(self) -> None:
        history = await run_engine(
            {
                "StartAt": "P",
                "States": {
                    "P": {
                        "Type": "Parallel",
                        "Branches": [
                            {
                                "StartAt": "Ok",
                                "States": {
                                    "Ok": {
                                        "Type": "Pass",
                                        "Result": "ok",
                                        "End": True,
                                    }
                                },
                            },
                            {
                                "StartAt": "Fail",
                                "States": {
                                    "Fail": {
                                        "Type": "Fail",
                                        "Error": "BranchError",
                                        "Cause": "branch failed",
                                    }
                                },
                            },
                        ],
                        "Catch": [
                            {
                                "ErrorEquals": ["States.ALL"],
                                "Next": "Recovered",
                            }
                        ],
                        "End": True,
                    },
                    "Recovered": {
                        "Type": "Pass",
                        "Result": {"recovered": True},
                        "End": True,
                    },
                },
            },
        )
        assert history.status == ExecutionStatus.SUCCEEDED
        assert history.output_data == {"recovered": True}

    async def test_parallel_with_result_path(self) -> None:
        history = await run_engine(
            {
                "StartAt": "P",
                "States": {
                    "P": {
                        "Type": "Parallel",
                        "Branches": [
                            {
                                "StartAt": "B1",
                                "States": {
                                    "B1": {
                                        "Type": "Pass",
                                        "Result": "b1",
                                        "End": True,
                                    }
                                },
                            }
                        ],
                        "ResultPath": "$.branches",
                        "End": True,
                    }
                },
            },
            input_data={"original": True},
        )
        assert history.output_data["original"] is True
        assert history.output_data["branches"] == ["b1"]

    async def test_parallel_then_next_state(self) -> None:
        history = await run_engine(
            {
                "StartAt": "P",
                "States": {
                    "P": {
                        "Type": "Parallel",
                        "Branches": [
                            {
                                "StartAt": "B1",
                                "States": {
                                    "B1": {
                                        "Type": "Pass",
                                        "Result": "b1",
                                        "End": True,
                                    }
                                },
                            }
                        ],
                        "Next": "After",
                    },
                    "After": {
                        "Type": "Pass",
                        "Result": "after-parallel",
                        "End": True,
                    },
                },
            },
        )
        assert history.output_data == "after-parallel"
