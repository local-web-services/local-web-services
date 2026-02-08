"""Tests for the Step Functions provider.

Covers provider lifecycle, IStateMachine interface, ASL parsing,
cloud assembly parsing, execution tracking, workflow types, and HTTP routes.
"""

from __future__ import annotations

import json

import httpx
import pytest

from ldk.providers.stepfunctions.provider import (
    StateMachineConfig,
    StepFunctionsProvider,
    WorkflowType,
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
