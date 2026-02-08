"""Tests for the Step Functions provider.

Covers provider lifecycle, IStateMachine interface, ASL parsing,
cloud assembly parsing, execution tracking, workflow types, and HTTP routes.
"""

from __future__ import annotations

import asyncio
import json

import httpx
import pytest

from ldk.interfaces.state_machine import IStateMachine
from ldk.providers.stepfunctions.asl_parser import (
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
from ldk.providers.stepfunctions.provider import (
    StateMachineConfig,
    StepFunctionsProvider,
    WorkflowType,
    parse_cloud_assembly_state_machine,
)
from ldk.providers.stepfunctions.routes import create_stepfunctions_app

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


class TestAslParser:
    """Test ASL JSON parsing into dataclasses."""

    def test_parse_pass_state(self) -> None:
        defn = parse_definition(SIMPLE_PASS_DEFINITION)
        assert defn.start_at == "PassState"
        assert "PassState" in defn.states
        state = defn.states["PassState"]
        assert isinstance(state, PassState)
        assert state.result == {"greeting": "hello"}
        assert state.end is True

    def test_parse_task_state(self) -> None:
        defn = parse_definition(
            {
                "StartAt": "MyTask",
                "States": {
                    "MyTask": {
                        "Type": "Task",
                        "Resource": "arn:aws:lambda:us-east-1:000:function:myFunc",
                        "End": True,
                        "TimeoutSeconds": 30,
                    }
                },
            }
        )
        state = defn.states["MyTask"]
        assert isinstance(state, TaskState)
        assert "myFunc" in state.resource
        assert state.timeout_seconds == 30

    def test_parse_choice_state(self) -> None:
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
                        "Default": "Small",
                    },
                    "Big": {"Type": "Succeed"},
                    "Small": {"Type": "Succeed"},
                },
            }
        )
        state = defn.states["Check"]
        assert isinstance(state, ChoiceState)
        assert len(state.choices) == 1
        assert state.default == "Small"

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
        assert isinstance(state, WaitState)
        assert state.seconds == 5

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
        assert isinstance(state, ParallelState)
        assert len(state.branches) == 1

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
        assert isinstance(state, MapState)
        assert state.max_concurrency == 3

    def test_parse_fail_state(self) -> None:
        defn = parse_definition(FAIL_DEFINITION)
        state = defn.states["Oops"]
        assert isinstance(state, FailState)
        assert state.error == "CustomError"

    def test_parse_succeed_state(self) -> None:
        defn = parse_definition(SUCCEED_DEFINITION)
        state = defn.states["Done"]
        assert isinstance(state, SucceedState)

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
        assert isinstance(state, TaskState)
        assert len(state.retry) == 1
        assert state.retry[0].max_attempts == 3
        assert len(state.catch) == 1

    def test_parse_comment(self) -> None:
        defn = parse_definition(
            {
                "Comment": "My state machine",
                "StartAt": "S1",
                "States": {"S1": {"Type": "Succeed", "Comment": "done"}},
            }
        )
        assert defn.comment == "My state machine"

    def test_parse_from_string(self) -> None:
        defn = parse_definition(SIMPLE_PASS_DEFINITION)
        assert isinstance(defn, StateMachineDefinition)

    def test_unknown_state_type_raises(self) -> None:
        with pytest.raises(ValueError, match="Unknown state type"):
            parse_definition(
                {
                    "StartAt": "X",
                    "States": {"X": {"Type": "UnknownType"}},
                }
            )


# ---------------------------------------------------------------------------
# Provider lifecycle
# ---------------------------------------------------------------------------


class TestProviderLifecycle:
    """Provider lifecycle: start, stop, health_check, name."""

    async def test_name(self, provider: StepFunctionsProvider) -> None:
        assert provider.name == "stepfunctions"

    async def test_health_check_running(self, provider: StepFunctionsProvider) -> None:
        assert await provider.health_check() is True

    async def test_health_check_stopped(self) -> None:
        p = StepFunctionsProvider(
            state_machines=[StateMachineConfig(name="sm", definition=SIMPLE_PASS_DEFINITION)]
        )
        assert await p.health_check() is False

    async def test_stop_clears_state(self) -> None:
        p = StepFunctionsProvider(
            state_machines=[StateMachineConfig(name="sm", definition=SIMPLE_PASS_DEFINITION)]
        )
        await p.start()
        assert p.get_definition("sm") is not None
        await p.stop()
        assert p.get_definition("sm") is None

    async def test_implements_istatemachine(self, provider: StepFunctionsProvider) -> None:
        assert isinstance(provider, IStateMachine)

    async def test_list_state_machines(self, provider: StepFunctionsProvider) -> None:
        names = provider.list_state_machines()
        assert "simple-pass" in names
        assert "two-step" in names


# ---------------------------------------------------------------------------
# Standard workflow execution
# ---------------------------------------------------------------------------


class TestStandardExecution:
    """Standard (STANDARD) workflow execution tests."""

    async def test_simple_pass_execution(self, provider: StepFunctionsProvider) -> None:
        result = await provider.start_execution("simple-pass", input_data={"x": 1})
        assert "executionArn" in result
        assert "startDate" in result

        # Wait for background execution to complete
        await asyncio.sleep(0.1)

        execution_arn = result["executionArn"]
        history = provider.get_execution(execution_arn)
        assert history is not None
        assert history.output_data == {"greeting": "hello"}

    async def test_two_step_execution(self, provider: StepFunctionsProvider) -> None:
        result = await provider.start_execution("two-step", input_data={})
        await asyncio.sleep(0.1)

        history = provider.get_execution(result["executionArn"])
        assert history is not None
        assert history.output_data == {"step": 2}

    async def test_succeed_execution(self, provider: StepFunctionsProvider) -> None:
        result = await provider.start_execution("succeed-sm", input_data={"val": "ok"})
        await asyncio.sleep(0.1)

        history = provider.get_execution(result["executionArn"])
        assert history is not None
        assert history.status.value == "SUCCEEDED"

    async def test_fail_execution(self, provider: StepFunctionsProvider) -> None:
        result = await provider.start_execution("fail-sm", input_data={})
        await asyncio.sleep(0.1)

        history = provider.get_execution(result["executionArn"])
        assert history is not None
        assert history.status.value == "FAILED"
        assert history.error == "CustomError"

    async def test_unknown_state_machine_raises(self, provider: StepFunctionsProvider) -> None:
        with pytest.raises(KeyError, match="State machine not found"):
            await provider.start_execution("nonexistent")

    async def test_list_executions(self, provider: StepFunctionsProvider) -> None:
        await provider.start_execution("simple-pass")
        await asyncio.sleep(0.1)
        executions = provider.list_executions("simple-pass")
        assert len(executions) >= 1

    async def test_execution_name(self, provider: StepFunctionsProvider) -> None:
        result = await provider.start_execution("simple-pass", execution_name="custom-name")
        assert "custom-name" in result["executionArn"]


# ---------------------------------------------------------------------------
# Express workflow (P2-16)
# ---------------------------------------------------------------------------


class TestExpressExecution:
    """Express (EXPRESS) workflow execution tests."""

    async def test_express_returns_output(self, express_provider: StepFunctionsProvider) -> None:
        result = await express_provider.start_execution("express-pass", input_data={"x": 1})
        assert result["status"] == "SUCCEEDED"
        assert "output" in result

    async def test_express_blocks_until_complete(
        self, express_provider: StepFunctionsProvider
    ) -> None:
        """Express execution should block and return the result directly."""
        result = await express_provider.start_execution("express-pass")
        assert result["status"] == "SUCCEEDED"
        assert "executionArn" in result


# ---------------------------------------------------------------------------
# Execution tracking (P2-15)
# ---------------------------------------------------------------------------


class TestExecutionTracking:
    """Execution history and state transition tracking."""

    async def test_execution_has_transitions(self, provider: StepFunctionsProvider) -> None:
        result = await provider.start_execution("two-step", input_data={"x": 1})
        await asyncio.sleep(0.1)

        history = provider.get_execution(result["executionArn"])
        assert history is not None
        assert len(history.transitions) == 2
        assert history.transitions[0].state_name == "First"
        assert history.transitions[1].state_name == "Second"

    async def test_execution_timing(self, provider: StepFunctionsProvider) -> None:
        result = await provider.start_execution("simple-pass")
        await asyncio.sleep(0.1)

        history = provider.get_execution(result["executionArn"])
        assert history is not None
        assert history.start_time > 0
        assert history.end_time is not None
        assert history.end_time >= history.start_time


# ---------------------------------------------------------------------------
# Cloud Assembly parsing (P2-17)
# ---------------------------------------------------------------------------


class TestCloudAssemblyParsing:
    """Cloud assembly state machine resource parsing."""

    def test_parse_basic_state_machine(self) -> None:
        props = {
            "DefinitionString": json.dumps(
                {
                    "StartAt": "S1",
                    "States": {"S1": {"Type": "Succeed"}},
                }
            ),
        }
        config = parse_cloud_assembly_state_machine("MySM", props)
        assert config.name == "MySM"
        assert config.workflow_type == WorkflowType.STANDARD

    def test_parse_express_workflow(self) -> None:
        props = {
            "DefinitionString": json.dumps(
                {
                    "StartAt": "S1",
                    "States": {"S1": {"Type": "Succeed"}},
                }
            ),
            "StateMachineType": "EXPRESS",
        }
        config = parse_cloud_assembly_state_machine("MySM", props)
        assert config.workflow_type == WorkflowType.EXPRESS

    def test_definition_substitutions(self) -> None:
        props = {
            "DefinitionString": json.dumps(
                {
                    "StartAt": "Task1",
                    "States": {
                        "Task1": {
                            "Type": "Task",
                            "Resource": "${LambdaArn}",
                            "End": True,
                        }
                    },
                }
            ),
            "DefinitionSubstitutions": {
                "LambdaArn": "arn:aws:lambda:us-east-1:000:function:myFunc"
            },
        }
        config = parse_cloud_assembly_state_machine("MySM", props)
        assert "myFunc" in config.definition

    def test_resource_arn_remapping(self) -> None:
        props = {
            "DefinitionString": json.dumps(
                {
                    "StartAt": "Task1",
                    "States": {
                        "Task1": {
                            "Type": "Task",
                            "Resource": "arn:aws:lambda:us-east-1:000:function:prodFunc",
                            "End": True,
                        }
                    },
                }
            ),
        }
        mapping = {"arn:aws:lambda:us-east-1:000:function:prodFunc": "local-handler"}
        config = parse_cloud_assembly_state_machine("MySM", props, mapping)
        assert "local-handler" in config.definition


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


class TestRoutes:
    """Step Functions HTTP route tests."""

    async def test_start_execution(self, sfn_client: httpx.AsyncClient) -> None:
        resp = await sfn_client.post(
            "/",
            json={
                "stateMachineArn": "arn:aws:states:us-east-1:000:stateMachine:test-sm",
                "input": json.dumps({"x": 1}),
            },
            headers={"x-amz-target": "AWSStepFunctions.StartExecution"},
        )
        assert resp.status_code == 200
        data = resp.json()
        assert "executionArn" in data

    async def test_start_sync_execution(self, sfn_client: httpx.AsyncClient) -> None:
        resp = await sfn_client.post(
            "/",
            json={
                "stateMachineArn": "arn:aws:states:us-east-1:000:stateMachine:test-express",
                "input": json.dumps({"x": 1}),
            },
            headers={"x-amz-target": "AWSStepFunctions.StartSyncExecution"},
        )
        assert resp.status_code == 200
        data = resp.json()
        assert data["status"] == "SUCCEEDED"

    async def test_describe_execution(self, sfn_client: httpx.AsyncClient) -> None:
        # Start an execution first
        start_resp = await sfn_client.post(
            "/",
            json={
                "stateMachineArn": "arn:aws:states:us-east-1:000:stateMachine:test-express",
                "input": "{}",
            },
            headers={"x-amz-target": "AWSStepFunctions.StartSyncExecution"},
        )
        arn = start_resp.json()["executionArn"]

        resp = await sfn_client.post(
            "/",
            json={"executionArn": arn},
            headers={"x-amz-target": "AWSStepFunctions.DescribeExecution"},
        )
        assert resp.status_code == 200
        data = resp.json()
        assert data["status"] == "SUCCEEDED"

    async def test_list_executions(self, sfn_client: httpx.AsyncClient) -> None:
        resp = await sfn_client.post(
            "/",
            json={"stateMachineArn": "arn:aws:states:us-east-1:000:stateMachine:test-sm"},
            headers={"x-amz-target": "AWSStepFunctions.ListExecutions"},
        )
        assert resp.status_code == 200
        data = resp.json()
        assert "executions" in data

    async def test_list_state_machines(self, sfn_client: httpx.AsyncClient) -> None:
        resp = await sfn_client.post(
            "/",
            json={},
            headers={"x-amz-target": "AWSStepFunctions.ListStateMachines"},
        )
        assert resp.status_code == 200
        data = resp.json()
        assert len(data["stateMachines"]) == 2

    async def test_unknown_action(self, sfn_client: httpx.AsyncClient) -> None:
        resp = await sfn_client.post(
            "/",
            json={},
            headers={"x-amz-target": "AWSStepFunctions.Bogus"},
        )
        assert resp.status_code == 400

    async def test_nonexistent_state_machine(self, sfn_client: httpx.AsyncClient) -> None:
        resp = await sfn_client.post(
            "/",
            json={
                "stateMachineArn": "arn:aws:states:us-east-1:000:stateMachine:nonexistent",
            },
            headers={"x-amz-target": "AWSStepFunctions.StartExecution"},
        )
        assert resp.status_code == 400

    async def test_describe_nonexistent_execution(self, sfn_client: httpx.AsyncClient) -> None:
        resp = await sfn_client.post(
            "/",
            json={"executionArn": "arn:aws:states:us-east-1:000:execution:sm:does-not-exist"},
            headers={"x-amz-target": "AWSStepFunctions.DescribeExecution"},
        )
        assert resp.status_code == 400
