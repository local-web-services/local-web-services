"""Tests for the Step Functions provider.

Covers provider lifecycle, IStateMachine interface, ASL parsing,
cloud assembly parsing, execution tracking, workflow types, and HTTP routes.
"""

from __future__ import annotations

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


class TestRoutes:
    """Step Functions HTTP route tests."""

    async def test_start_execution(self, sfn_client: httpx.AsyncClient) -> None:
        # Act
        resp = await sfn_client.post(
            "/",
            json={
                "stateMachineArn": "arn:aws:states:us-east-1:000:stateMachine:test-sm",
                "input": json.dumps({"x": 1}),
            },
            headers={"x-amz-target": "AWSStepFunctions.StartExecution"},
        )

        # Assert
        expected_status_code = 200
        assert resp.status_code == expected_status_code
        data = resp.json()
        assert "executionArn" in data

    async def test_start_sync_execution(self, sfn_client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 200
        expected_status = "SUCCEEDED"

        # Act
        resp = await sfn_client.post(
            "/",
            json={
                "stateMachineArn": "arn:aws:states:us-east-1:000:stateMachine:test-express",
                "input": json.dumps({"x": 1}),
            },
            headers={"x-amz-target": "AWSStepFunctions.StartSyncExecution"},
        )

        # Assert
        assert resp.status_code == expected_status_code
        data = resp.json()
        actual_status = data["status"]
        assert actual_status == expected_status

    async def test_describe_execution(self, sfn_client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 200
        expected_status = "SUCCEEDED"

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

        # Act
        resp = await sfn_client.post(
            "/",
            json={"executionArn": arn},
            headers={"x-amz-target": "AWSStepFunctions.DescribeExecution"},
        )

        # Assert
        assert resp.status_code == expected_status_code
        data = resp.json()
        actual_status = data["status"]
        assert actual_status == expected_status

    async def test_list_executions(self, sfn_client: httpx.AsyncClient) -> None:
        # Act
        resp = await sfn_client.post(
            "/",
            json={"stateMachineArn": "arn:aws:states:us-east-1:000:stateMachine:test-sm"},
            headers={"x-amz-target": "AWSStepFunctions.ListExecutions"},
        )

        # Assert
        expected_status_code = 200
        assert resp.status_code == expected_status_code
        data = resp.json()
        assert "executions" in data

    async def test_list_state_machines(self, sfn_client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 200
        expected_count = 2

        # Act
        resp = await sfn_client.post(
            "/",
            json={},
            headers={"x-amz-target": "AWSStepFunctions.ListStateMachines"},
        )

        # Assert
        assert resp.status_code == expected_status_code
        data = resp.json()
        assert len(data["stateMachines"]) == expected_count

    async def test_unknown_action_returns_error(self, sfn_client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_type = "UnknownOperationException"

        # Act
        resp = await sfn_client.post(
            "/",
            json={},
            headers={"x-amz-target": "AWSStepFunctions.Bogus"},
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type
        assert "lws" in body["message"]
        assert "StepFunctions" in body["message"]
        assert "Bogus" in body["message"]

    async def test_nonexistent_state_machine(self, sfn_client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 400

        # Act
        resp = await sfn_client.post(
            "/",
            json={
                "stateMachineArn": "arn:aws:states:us-east-1:000:stateMachine:nonexistent",
            },
            headers={"x-amz-target": "AWSStepFunctions.StartExecution"},
        )

        # Assert
        assert resp.status_code == expected_status_code

    async def test_describe_nonexistent_execution(self, sfn_client: httpx.AsyncClient) -> None:
        # Arrange
        expected_status_code = 400

        # Act
        resp = await sfn_client.post(
            "/",
            json={"executionArn": "arn:aws:states:us-east-1:000:execution:sm:does-not-exist"},
            headers={"x-amz-target": "AWSStepFunctions.DescribeExecution"},
        )

        # Assert
        assert resp.status_code == expected_status_code
