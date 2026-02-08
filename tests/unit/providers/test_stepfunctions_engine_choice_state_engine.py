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


class TestChoiceStateEngine:
    """Choice state evaluation through the engine."""

    async def test_choice_numeric_branch(self) -> None:
        history = await run_engine(
            {
                "StartAt": "Check",
                "States": {
                    "Check": {
                        "Type": "Choice",
                        "Choices": [
                            {
                                "Variable": "$.value",
                                "NumericGreaterThan": 10,
                                "Next": "Big",
                            }
                        ],
                        "Default": "Small",
                    },
                    "Big": {
                        "Type": "Pass",
                        "Result": {"size": "big"},
                        "End": True,
                    },
                    "Small": {
                        "Type": "Pass",
                        "Result": {"size": "small"},
                        "End": True,
                    },
                },
            },
            input_data={"value": 20},
        )
        assert history.output_data == {"size": "big"}

    async def test_choice_default_branch(self) -> None:
        history = await run_engine(
            {
                "StartAt": "Check",
                "States": {
                    "Check": {
                        "Type": "Choice",
                        "Choices": [
                            {
                                "Variable": "$.value",
                                "NumericGreaterThan": 10,
                                "Next": "Big",
                            }
                        ],
                        "Default": "Small",
                    },
                    "Big": {
                        "Type": "Pass",
                        "Result": {"size": "big"},
                        "End": True,
                    },
                    "Small": {
                        "Type": "Pass",
                        "Result": {"size": "small"},
                        "End": True,
                    },
                },
            },
            input_data={"value": 5},
        )
        assert history.output_data == {"size": "small"}

    async def test_choice_no_match_no_default_fails(self) -> None:
        history = await run_engine(
            {
                "StartAt": "Check",
                "States": {
                    "Check": {
                        "Type": "Choice",
                        "Choices": [
                            {
                                "Variable": "$.value",
                                "StringEquals": "nope",
                                "Next": "Found",
                            }
                        ],
                    },
                    "Found": {"Type": "Succeed"},
                },
            },
            input_data={"value": "different"},
        )
        assert history.status == ExecutionStatus.FAILED

    async def test_choice_string_equals(self) -> None:
        history = await run_engine(
            {
                "StartAt": "Check",
                "States": {
                    "Check": {
                        "Type": "Choice",
                        "Choices": [
                            {
                                "Variable": "$.status",
                                "StringEquals": "ok",
                                "Next": "Good",
                            }
                        ],
                        "Default": "Bad",
                    },
                    "Good": {
                        "Type": "Pass",
                        "Result": "good",
                        "End": True,
                    },
                    "Bad": {
                        "Type": "Pass",
                        "Result": "bad",
                        "End": True,
                    },
                },
            },
            input_data={"status": "ok"},
        )
        assert history.output_data == "good"

    async def test_choice_boolean_equals(self) -> None:
        history = await run_engine(
            {
                "StartAt": "Check",
                "States": {
                    "Check": {
                        "Type": "Choice",
                        "Choices": [
                            {
                                "Variable": "$.flag",
                                "BooleanEquals": True,
                                "Next": "Yes",
                            }
                        ],
                        "Default": "No",
                    },
                    "Yes": {"Type": "Pass", "Result": "yes", "End": True},
                    "No": {"Type": "Pass", "Result": "no", "End": True},
                },
            },
            input_data={"flag": True},
        )
        assert history.output_data == "yes"

    async def test_choice_and_combinator(self) -> None:
        history = await run_engine(
            {
                "StartAt": "Check",
                "States": {
                    "Check": {
                        "Type": "Choice",
                        "Choices": [
                            {
                                "And": [
                                    {
                                        "Variable": "$.x",
                                        "NumericGreaterThan": 0,
                                    },
                                    {
                                        "Variable": "$.y",
                                        "NumericGreaterThan": 0,
                                    },
                                ],
                                "Next": "BothPositive",
                            }
                        ],
                        "Default": "Other",
                    },
                    "BothPositive": {
                        "Type": "Pass",
                        "Result": "both",
                        "End": True,
                    },
                    "Other": {
                        "Type": "Pass",
                        "Result": "other",
                        "End": True,
                    },
                },
            },
            input_data={"x": 5, "y": 3},
        )
        assert history.output_data == "both"

    async def test_choice_not_combinator(self) -> None:
        history = await run_engine(
            {
                "StartAt": "Check",
                "States": {
                    "Check": {
                        "Type": "Choice",
                        "Choices": [
                            {
                                "Not": {
                                    "Variable": "$.x",
                                    "NumericEquals": 0,
                                },
                                "Next": "NonZero",
                            }
                        ],
                        "Default": "Zero",
                    },
                    "NonZero": {
                        "Type": "Pass",
                        "Result": "nonzero",
                        "End": True,
                    },
                    "Zero": {
                        "Type": "Pass",
                        "Result": "zero",
                        "End": True,
                    },
                },
            },
            input_data={"x": 5},
        )
        assert history.output_data == "nonzero"
