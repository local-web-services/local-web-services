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


class TestMapState:
    """Map state iteration."""

    async def test_map_basic(self) -> None:
        history = await run_engine(
            {
                "StartAt": "M",
                "States": {
                    "M": {
                        "Type": "Map",
                        "Iterator": {
                            "StartAt": "Process",
                            "States": {"Process": {"Type": "Pass", "End": True}},
                        },
                        "End": True,
                    }
                },
            },
            input_data=[1, 2, 3],
        )
        assert history.status == ExecutionStatus.SUCCEEDED
        assert history.output_data == [1, 2, 3]

    async def test_map_with_items_path(self) -> None:
        history = await run_engine(
            {
                "StartAt": "M",
                "States": {
                    "M": {
                        "Type": "Map",
                        "ItemsPath": "$.items",
                        "Iterator": {
                            "StartAt": "Process",
                            "States": {"Process": {"Type": "Pass", "End": True}},
                        },
                        "End": True,
                    }
                },
            },
            input_data={"items": [10, 20, 30]},
        )
        assert history.output_data == [10, 20, 30]

    async def test_map_with_max_concurrency(self) -> None:
        history = await run_engine(
            {
                "StartAt": "M",
                "States": {
                    "M": {
                        "Type": "Map",
                        "MaxConcurrency": 2,
                        "Iterator": {
                            "StartAt": "Process",
                            "States": {"Process": {"Type": "Pass", "End": True}},
                        },
                        "End": True,
                    }
                },
            },
            input_data=[1, 2, 3, 4],
        )
        assert history.output_data == [1, 2, 3, 4]

    async def test_map_preserves_order(self) -> None:
        history = await run_engine(
            {
                "StartAt": "M",
                "States": {
                    "M": {
                        "Type": "Map",
                        "Iterator": {
                            "StartAt": "P",
                            "States": {"P": {"Type": "Pass", "End": True}},
                        },
                        "End": True,
                    }
                },
            },
            input_data=["a", "b", "c", "d", "e"],
        )
        assert history.output_data == ["a", "b", "c", "d", "e"]

    async def test_map_with_parameters_context(self) -> None:
        history = await run_engine(
            {
                "StartAt": "M",
                "States": {
                    "M": {
                        "Type": "Map",
                        "ItemsPath": "$.items",
                        "Parameters": {
                            "value.$": "$$.Map.Item.Value",
                            "index.$": "$$.Map.Item.Index",
                        },
                        "Iterator": {
                            "StartAt": "P",
                            "States": {"P": {"Type": "Pass", "End": True}},
                        },
                        "End": True,
                    }
                },
            },
            input_data={"items": ["a", "b"]},
        )
        assert history.status == ExecutionStatus.SUCCEEDED
        assert history.output_data[0] == {"value": "a", "index": 0}
        assert history.output_data[1] == {"value": "b", "index": 1}

    async def test_map_with_result_path(self) -> None:
        history = await run_engine(
            {
                "StartAt": "M",
                "States": {
                    "M": {
                        "Type": "Map",
                        "ItemsPath": "$.items",
                        "ResultPath": "$.results",
                        "Iterator": {
                            "StartAt": "P",
                            "States": {"P": {"Type": "Pass", "End": True}},
                        },
                        "End": True,
                    }
                },
            },
            input_data={"items": [1, 2], "keep": "me"},
        )
        assert history.output_data["keep"] == "me"
        assert history.output_data["results"] == [1, 2]

    async def test_map_with_catch(self) -> None:
        history = await run_engine(
            {
                "StartAt": "M",
                "States": {
                    "M": {
                        "Type": "Map",
                        "Iterator": {
                            "StartAt": "F",
                            "States": {
                                "F": {
                                    "Type": "Fail",
                                    "Error": "ItemError",
                                }
                            },
                        },
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
                        "Result": "recovered",
                        "End": True,
                    },
                },
            },
            input_data=[1],
        )
        assert history.status == ExecutionStatus.SUCCEEDED
        assert history.output_data == "recovered"
