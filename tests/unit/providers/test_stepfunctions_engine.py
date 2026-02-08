"""Tests for the Step Functions execution engine.

Covers all state types, path processing, retry/catch, parallel and map
execution, wait states, and error handling.
"""

from __future__ import annotations

import asyncio
from typing import Any

from ldk.providers.stepfunctions.asl_parser import parse_definition
from ldk.providers.stepfunctions.engine import (
    ExecutionEngine,
    ExecutionStatus,
    StatesTaskFailed,
)

# ---------------------------------------------------------------------------
# Mock compute invoker
# ---------------------------------------------------------------------------


class MockCompute:
    """Mock compute invoker for testing."""

    def __init__(self, results: dict[str, Any] | None = None) -> None:
        self._results = results or {}
        self._call_count: dict[str, int] = {}
        self._error_until: dict[str, int] = {}

    async def invoke_function(self, resource_arn: str, payload: Any) -> Any:
        count = self._call_count.get(resource_arn, 0) + 1
        self._call_count[resource_arn] = count

        error_threshold = self._error_until.get(resource_arn, 0)
        if count <= error_threshold:
            raise StatesTaskFailed("States.TaskFailed", f"Error on attempt {count}")

        if resource_arn in self._results:
            result = self._results[resource_arn]
            if callable(result):
                return result(payload)
            return result
        return payload

    def set_error_until(self, resource_arn: str, attempts: int) -> None:
        """Make the function fail for the first N attempts."""
        self._error_until[resource_arn] = attempts


class SlowCompute:
    """Compute that takes a long time (for timeout tests)."""

    async def invoke_function(self, resource_arn: str, payload: Any) -> Any:
        await asyncio.sleep(10)
        return payload


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


# ---------------------------------------------------------------------------
# Succeed / Fail states
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


# ---------------------------------------------------------------------------
# P2-09: Task state with Lambda invocation
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


# ---------------------------------------------------------------------------
# P2-11: Wait state
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


# ---------------------------------------------------------------------------
# P2-12: Retry and Catch
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


# ---------------------------------------------------------------------------
# P2-10 + P2-08: Choice state (tested via engine)
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


# ---------------------------------------------------------------------------
# P2-13: Parallel state
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


# ---------------------------------------------------------------------------
# P2-14: Map state
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
