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


class TestPassState:
    """Pass state and basic execution flow."""

    async def test_pass_with_result(self) -> None:
        history = await run_engine(
            {
                "StartAt": "P",
                "States": {"P": {"Type": "Pass", "Result": {"done": True}, "End": True}},
            },
            input_data={"x": 1},
        )
        assert history.status == ExecutionStatus.SUCCEEDED
        assert history.output_data == {"done": True}

    async def test_pass_without_result(self) -> None:
        history = await run_engine(
            {
                "StartAt": "P",
                "States": {"P": {"Type": "Pass", "End": True}},
            },
            input_data={"forwarded": True},
        )
        assert history.output_data == {"forwarded": True}

    async def test_pass_chain(self) -> None:
        history = await run_engine(
            {
                "StartAt": "A",
                "States": {
                    "A": {"Type": "Pass", "Result": {"step": "a"}, "Next": "B"},
                    "B": {"Type": "Pass", "Result": {"step": "b"}, "End": True},
                },
            },
        )
        assert history.output_data == {"step": "b"}

    async def test_pass_with_result_path(self) -> None:
        history = await run_engine(
            {
                "StartAt": "P",
                "States": {
                    "P": {
                        "Type": "Pass",
                        "Result": "hello",
                        "ResultPath": "$.greeting",
                        "End": True,
                    }
                },
            },
            input_data={"name": "world"},
        )
        assert history.output_data["greeting"] == "hello"
        assert history.output_data["name"] == "world"

    async def test_pass_with_input_path(self) -> None:
        history = await run_engine(
            {
                "StartAt": "P",
                "States": {"P": {"Type": "Pass", "InputPath": "$.nested", "End": True}},
            },
            input_data={"nested": {"val": 42}},
        )
        assert history.output_data == {"val": 42}

    async def test_pass_with_output_path(self) -> None:
        history = await run_engine(
            {
                "StartAt": "P",
                "States": {
                    "P": {
                        "Type": "Pass",
                        "Result": {"a": 1, "b": 2},
                        "OutputPath": "$.a",
                        "End": True,
                    }
                },
            },
        )
        assert history.output_data == 1

    async def test_pass_with_parameters(self) -> None:
        history = await run_engine(
            {
                "StartAt": "P",
                "States": {
                    "P": {
                        "Type": "Pass",
                        "Parameters": {"greeting": "hello", "name.$": "$.user"},
                        "End": True,
                    }
                },
            },
            input_data={"user": "Alice"},
        )
        assert history.output_data == {"greeting": "hello", "name": "Alice"}

    async def test_null_input_path_discards_input(self) -> None:
        history = await run_engine(
            {
                "StartAt": "P",
                "States": {
                    "P": {
                        "Type": "Pass",
                        "InputPath": None,
                        "Result": {"result": "ok"},
                        "End": True,
                    }
                },
            },
            input_data={"ignored": True},
        )
        assert history.output_data == {"result": "ok"}

    async def test_null_result_path_discards_result(self) -> None:
        history = await run_engine(
            {
                "StartAt": "P",
                "States": {
                    "P": {
                        "Type": "Pass",
                        "Result": "discarded",
                        "ResultPath": None,
                        "End": True,
                    }
                },
            },
            input_data={"kept": True},
        )
        assert history.output_data == {"kept": True}
