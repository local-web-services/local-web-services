"""Tests for the Step Functions provider.

Covers provider lifecycle, IStateMachine interface, ASL parsing,
cloud assembly parsing, execution tracking, workflow types, and HTTP routes.
"""

from __future__ import annotations

import json

import httpx
import pytest

from lws.providers.stepfunctions.asl_parser import (
    ChoiceState,
    FailState,
    MapState,
    ParallelState,
    PassState,
    StateMachineDefinition,
    SucceedState,
    TaskState,
    WaitState,
    parse_definition,
)
from lws.providers.stepfunctions.provider import (
    StateMachineConfig,
    StepFunctionsProvider,
    WorkflowType,
)
from lws.providers.stepfunctions.routes import create_stepfunctions_app

# ---------------------------------------------------------------------------
# Fixtures
# ---------------------------------------------------------------------------

SIMPLE_PASS_DEFINITION = json.dumps(
    {
        "StartAt": "PassState",
        "States": {
            "PassState": {
                "Type": "Pass",
                "Result": {"greeting": "hello"},
                "End": True,
            }
        },
    }
)

TWO_STEP_DEFINITION = json.dumps(
    {
        "StartAt": "First",
        "States": {
            "First": {
                "Type": "Pass",
                "Result": {"step": 1},
                "Next": "Second",
            },
            "Second": {
                "Type": "Pass",
                "Result": {"step": 2},
                "End": True,
            },
        },
    }
)

SUCCEED_DEFINITION = json.dumps(
    {
        "StartAt": "Done",
        "States": {
            "Done": {
                "Type": "Succeed",
            }
        },
    }
)

FAIL_DEFINITION = json.dumps(
    {
        "StartAt": "Oops",
        "States": {
            "Oops": {
                "Type": "Fail",
                "Error": "CustomError",
                "Cause": "Something went wrong",
            }
        },
    }
)


@pytest.fixture()
async def provider() -> StepFunctionsProvider:
    """Provider with a simple Pass state machine."""
    p = StepFunctionsProvider(
        state_machines=[
            StateMachineConfig(name="simple-pass", definition=SIMPLE_PASS_DEFINITION),
            StateMachineConfig(name="two-step", definition=TWO_STEP_DEFINITION),
            StateMachineConfig(name="succeed-sm", definition=SUCCEED_DEFINITION),
            StateMachineConfig(name="fail-sm", definition=FAIL_DEFINITION),
        ],
        max_wait_seconds=0.01,
    )
    await p.start()
    yield p
    await p.stop()


@pytest.fixture()
async def express_provider() -> StepFunctionsProvider:
    """Provider with an EXPRESS workflow."""
    p = StepFunctionsProvider(
        state_machines=[
            StateMachineConfig(
                name="express-pass",
                definition=SIMPLE_PASS_DEFINITION,
                workflow_type=WorkflowType.EXPRESS,
            ),
        ],
        max_wait_seconds=0.01,
    )
    await p.start()
    yield p
    await p.stop()


# ---------------------------------------------------------------------------
# P2-07: ASL Parser
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Provider lifecycle
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Standard workflow execution
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Express workflow (P2-16)
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Execution tracking (P2-15)
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Cloud Assembly parsing (P2-17)
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# HTTP routes
# ---------------------------------------------------------------------------


@pytest.fixture()
async def sfn_client() -> httpx.AsyncClient:
    """An httpx client wired to a Step Functions ASGI app."""
    p = StepFunctionsProvider(
        state_machines=[
            StateMachineConfig(name="test-sm", definition=SIMPLE_PASS_DEFINITION),
            StateMachineConfig(
                name="test-express",
                definition=SIMPLE_PASS_DEFINITION,
                workflow_type=WorkflowType.EXPRESS,
            ),
        ],
        max_wait_seconds=0.01,
    )
    await p.start()
    app = create_stepfunctions_app(p)
    transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
    client = httpx.AsyncClient(transport=transport, base_url="http://testserver")
    yield client
    await p.stop()


class TestAslParser:
    """Test ASL JSON parsing into dataclasses."""

    def test_parse_pass_state(self) -> None:
        # Arrange
        expected_start_at = "PassState"
        expected_result = {"greeting": "hello"}

        # Act
        defn = parse_definition(SIMPLE_PASS_DEFINITION)

        # Assert
        assert defn.start_at == expected_start_at, f"Expected {expected_start_at!r} but got {defn.start_at!r}"
        assert expected_start_at in defn.states, f"Expected {expected_start_at!r} to be in {defn.states!r}"
        state = defn.states[expected_start_at]
        assert isinstance(state, PassState), f"Expected instance of {PassState!r} but got {type(state)!r}"
        assert state.result == expected_result, f"Expected {expected_result!r} but got {state.result!r}"
        assert state.end is True, "Expected value to be truthy"

    def test_parse_task_state(self) -> None:
        # Arrange
        expected_timeout = 30

        # Act
        defn = parse_definition(
            {
                "StartAt": "MyTask",
                "States": {
                    "MyTask": {
                        "Type": "Task",
                        "Resource": "arn:aws:lambda:us-east-1:000:function:myFunc",
                        "End": True,
                        "TimeoutSeconds": expected_timeout,
                    }
                },
            }
        )

        # Assert
        state = defn.states["MyTask"]
        assert isinstance(state, TaskState), f"Expected instance of {TaskState!r} but got {type(state)!r}"
        assert "myFunc" in state.resource, f'Expected {"myFunc"!r} to be in {state.resource!r}'
        assert state.timeout_seconds == expected_timeout, f"Expected {expected_timeout!r} but got {state.timeout_seconds!r}"

    def test_parse_choice_state(self) -> None:
        # Arrange
        expected_default = "Small"

        # Act
        defn = parse_definition(
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
                        "Default": expected_default,
                    },
                    "Big": {"Type": "Succeed"},
                    "Small": {"Type": "Succeed"},
                },
            }
        )

        # Assert
        state = defn.states["Check"]
        assert isinstance(state, ChoiceState), f"Expected instance of {ChoiceState!r} but got {type(state)!r}"
        assert len(state.choices) == 1, f"Expected {1!r} but got {len(state.choices)!r}"
        assert state.default == expected_default, f"Expected {expected_default!r} but got {state.default!r}"

    def test_parse_wait_state(self) -> None:
        defn = parse_definition(
            {
                "StartAt": "Wait",
                "States": {
                    "Wait": {
                        "Type": "Wait",
                        "Seconds": 5,
                        "Next": "Done",
                    },
                    "Done": {"Type": "Succeed"},
                },
            }
        )
        state = defn.states["Wait"]
        assert isinstance(state, WaitState), f"Expected instance of {WaitState!r} but got {type(state)!r}"
        assert state.seconds == 5, f"Expected {5!r} but got {state.seconds!r}"

    def test_parse_parallel_state(self) -> None:
        defn = parse_definition(
            {
                "StartAt": "Parallel",
                "States": {
                    "Parallel": {
                        "Type": "Parallel",
                        "Branches": [
                            {
                                "StartAt": "B1",
                                "States": {"B1": {"Type": "Pass", "End": True}},
                            }
                        ],
                        "End": True,
                    }
                },
            }
        )
        state = defn.states["Parallel"]
        assert isinstance(state, ParallelState), f"Expected instance of {ParallelState!r} but got {type(state)!r}"
        assert len(state.branches) == 1, f"Expected {1!r} but got {len(state.branches)!r}"

    def test_parse_map_state(self) -> None:
        defn = parse_definition(
            {
                "StartAt": "MapIt",
                "States": {
                    "MapIt": {
                        "Type": "Map",
                        "Iterator": {
                            "StartAt": "Process",
                            "States": {"Process": {"Type": "Pass", "End": True}},
                        },
                        "MaxConcurrency": 3,
                        "End": True,
                    }
                },
            }
        )
        state = defn.states["MapIt"]
        assert isinstance(state, MapState), f"Expected instance of {MapState!r} but got {type(state)!r}"
        assert state.max_concurrency == 3, f"Expected {3!r} but got {state.max_concurrency!r}"

    def test_parse_fail_state(self) -> None:
        expected_error = "CustomError"
        defn = parse_definition(FAIL_DEFINITION)
        state = defn.states["Oops"]
        assert isinstance(state, FailState), f"Expected instance of {FailState!r} but got {type(state)!r}"
        assert state.error == expected_error, f"Expected {expected_error!r} but got {state.error!r}"

    def test_parse_succeed_state(self) -> None:
        defn = parse_definition(SUCCEED_DEFINITION)
        state = defn.states["Done"]
        assert isinstance(state, SucceedState), f"Expected instance of {SucceedState!r} but got {type(state)!r}"

    def test_parse_retry_catch(self) -> None:
        defn = parse_definition(
            {
                "StartAt": "TaskWithRetry",
                "States": {
                    "TaskWithRetry": {
                        "Type": "Task",
                        "Resource": "arn:aws:lambda:us-east-1:000:function:fn",
                        "Retry": [
                            {
                                "ErrorEquals": ["States.TaskFailed"],
                                "IntervalSeconds": 2,
                                "MaxAttempts": 3,
                                "BackoffRate": 1.5,
                            }
                        ],
                        "Catch": [
                            {
                                "ErrorEquals": ["States.ALL"],
                                "Next": "Fallback",
                            }
                        ],
                        "End": True,
                    },
                    "Fallback": {"Type": "Pass", "End": True},
                },
            }
        )
        state = defn.states["TaskWithRetry"]
        assert isinstance(state, TaskState), f"Expected instance of {TaskState!r} but got {type(state)!r}"
        assert len(state.retry) == 1, f"Expected {1!r} but got {len(state.retry)!r}"
        assert state.retry[0].max_attempts == 3, f"Expected {3!r} but got {state.retry[0].max_attempts!r}"
        assert len(state.catch) == 1, f"Expected {1!r} but got {len(state.catch)!r}"

    def test_parse_comment(self) -> None:
        expected_comment = "My state machine"
        defn = parse_definition(
            {
                "Comment": expected_comment,
                "StartAt": "S1",
                "States": {"S1": {"Type": "Succeed", "Comment": "done"}},
            }
        )
        assert defn.comment == expected_comment, f"Expected {expected_comment!r} but got {defn.comment!r}"

    def test_parse_from_string(self) -> None:
        defn = parse_definition(SIMPLE_PASS_DEFINITION)
        assert isinstance(defn, StateMachineDefinition), f"Expected instance of {StateMachineDefinition!r} but got {type(defn)!r}"

    def test_unknown_state_type_raises(self) -> None:
        with pytest.raises(ValueError, match="Unknown state type"):
            parse_definition(
                {
                    "StartAt": "X",
                    "States": {"X": {"Type": "UnknownType"}},
                }
            )
