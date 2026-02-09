"""Tests for the Step Functions provider.

Covers provider lifecycle, IStateMachine interface, ASL parsing,
cloud assembly parsing, execution tracking, workflow types, and HTTP routes.
"""

from __future__ import annotations

import asyncio
import json

import httpx
import pytest

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
