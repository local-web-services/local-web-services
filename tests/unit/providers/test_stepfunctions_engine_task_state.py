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

from ._helpers import MockCompute, SlowCompute

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


class TestTaskState:
    """Task state invocation and I/O processing."""

    async def test_task_invokes_compute(self) -> None:
        compute = MockCompute({"myFunc": {"result": "done"}})
        history = await run_engine(
            {
                "StartAt": "T",
                "States": {"T": {"Type": "Task", "Resource": "myFunc", "End": True}},
            },
            input_data={"key": "val"},
            compute=compute,
        )
        assert history.status == ExecutionStatus.SUCCEEDED
        assert history.output_data == {"result": "done"}

    async def test_task_passes_input_to_compute(self) -> None:
        received = {}

        def capture(payload: Any) -> dict:
            received.update(payload if isinstance(payload, dict) else {"payload": payload})
            return {"captured": True}

        compute = MockCompute({"fn": capture})
        await run_engine(
            {
                "StartAt": "T",
                "States": {"T": {"Type": "Task", "Resource": "fn", "End": True}},
            },
            input_data={"data": 123},
            compute=compute,
        )
        assert received.get("data") == 123

    async def test_task_with_input_path(self) -> None:
        captured = {}

        def capture(payload: Any) -> dict:
            captured.update(payload if isinstance(payload, dict) else {})
            return {"ok": True}

        compute = MockCompute({"fn": capture})
        await run_engine(
            {
                "StartAt": "T",
                "States": {
                    "T": {
                        "Type": "Task",
                        "Resource": "fn",
                        "InputPath": "$.nested",
                        "End": True,
                    }
                },
            },
            input_data={"nested": {"inner": True}},
            compute=compute,
        )
        assert captured.get("inner") is True

    async def test_task_with_parameters(self) -> None:
        captured = {}

        def capture(payload: Any) -> dict:
            captured.update(payload if isinstance(payload, dict) else {})
            return {}

        compute = MockCompute({"fn": capture})
        await run_engine(
            {
                "StartAt": "T",
                "States": {
                    "T": {
                        "Type": "Task",
                        "Resource": "fn",
                        "Parameters": {"key.$": "$.name", "static": "val"},
                        "End": True,
                    }
                },
            },
            input_data={"name": "Alice"},
            compute=compute,
        )
        assert captured.get("key") == "Alice"
        assert captured.get("static") == "val"

    async def test_task_with_result_path(self) -> None:
        compute = MockCompute({"fn": {"response": "ok"}})
        history = await run_engine(
            {
                "StartAt": "T",
                "States": {
                    "T": {
                        "Type": "Task",
                        "Resource": "fn",
                        "ResultPath": "$.taskResult",
                        "End": True,
                    }
                },
            },
            input_data={"original": True},
            compute=compute,
        )
        assert history.output_data["original"] is True
        assert history.output_data["taskResult"] == {"response": "ok"}

    async def test_task_no_compute_raises(self) -> None:
        history = await run_engine(
            {
                "StartAt": "T",
                "States": {"T": {"Type": "Task", "Resource": "fn", "End": True}},
            },
        )
        assert history.status == ExecutionStatus.FAILED

    async def test_task_timeout(self) -> None:
        compute = SlowCompute()
        history = await run_engine(
            {
                "StartAt": "T",
                "States": {
                    "T": {
                        "Type": "Task",
                        "Resource": "fn",
                        "TimeoutSeconds": 1,
                        "End": True,
                    }
                },
            },
            compute=compute,
        )
        assert history.status == ExecutionStatus.FAILED
        assert history.error == "States.Timeout"
