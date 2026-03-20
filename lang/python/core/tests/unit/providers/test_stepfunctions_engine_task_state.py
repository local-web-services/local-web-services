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

from ._helpers import FakeCompute, SlowCompute

# ---------------------------------------------------------------------------
# Fake compute invoker
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
        # Arrange
        expected_output = {"result": "done"}
        compute = FakeCompute({"myFunc": expected_output})

        # Act
        history = await run_engine(
            {
                "StartAt": "T",
                "States": {"T": {"Type": "Task", "Resource": "myFunc", "End": True}},
            },
            input_data={"key": "val"},
            compute=compute,
        )

        # Assert
        actual_output = history.output_data
        assert history.status == ExecutionStatus.SUCCEEDED, (
            f"Expected {ExecutionStatus.SUCCEEDED!r} but got {history.status!r}"
        )
        assert actual_output == expected_output, (
            f"Expected {expected_output!r} but got {actual_output!r}"
        )

    async def test_task_passes_input_to_compute(self) -> None:
        received = {}

        def capture(payload: Any) -> dict:
            received.update(payload if isinstance(payload, dict) else {"payload": payload})
            return {"captured": True}

        compute = FakeCompute({"fn": capture})
        await run_engine(
            {
                "StartAt": "T",
                "States": {"T": {"Type": "Task", "Resource": "fn", "End": True}},
            },
            input_data={"data": 123},
            compute=compute,
        )
        assert received.get("data") == 123, f'Expected {123!r} but got {received.get("data")!r}'

    async def test_task_with_input_path(self) -> None:
        captured = {}

        def capture(payload: Any) -> dict:
            captured.update(payload if isinstance(payload, dict) else {})
            return {"ok": True}

        compute = FakeCompute({"fn": capture})
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
        assert captured.get("inner") is True, "Expected value to be truthy"

    async def test_task_with_parameters(self) -> None:
        captured = {}

        def capture(payload: Any) -> dict:
            captured.update(payload if isinstance(payload, dict) else {})
            return {}

        compute = FakeCompute({"fn": capture})
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
        assert captured.get("key") == "Alice", (
            f'Expected {"Alice"!r} but got {captured.get("key")!r}'
        )
        assert captured.get("static") == "val", (
            f'Expected {"val"!r} but got {captured.get("static")!r}'
        )

    async def test_task_with_result_path(self) -> None:
        # Arrange
        expected_task_result = {"response": "ok"}
        compute = FakeCompute({"fn": expected_task_result})

        # Act
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

        # Assert
        actual_task_result = history.output_data["taskResult"]
        assert history.output_data["original"] is True, "Expected value to be truthy"
        assert actual_task_result == expected_task_result, (
            f"Expected {expected_task_result!r} but got {actual_task_result!r}"
        )

    async def test_task_no_compute_raises(self) -> None:
        history = await run_engine(
            {
                "StartAt": "T",
                "States": {"T": {"Type": "Task", "Resource": "fn", "End": True}},
            },
        )
        assert history.status == ExecutionStatus.FAILED, (
            f"Expected {ExecutionStatus.FAILED!r} but got {history.status!r}"
        )

    async def test_task_timeout(self) -> None:
        # Arrange
        expected_error = "States.Timeout"
        compute = SlowCompute()

        # Act
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

        # Assert
        actual_error = history.error
        assert history.status == ExecutionStatus.FAILED, (
            f"Expected {ExecutionStatus.FAILED!r} but got {history.status!r}"
        )
        assert actual_error == expected_error, (
            f"Expected {expected_error!r} but got {actual_error!r}"
        )
