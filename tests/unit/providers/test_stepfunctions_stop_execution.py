"""Tests for Step Functions StopExecution operation."""

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

UPDATED_DEFINITION = json.dumps(
    {
        "StartAt": "NewPass",
        "States": {
            "NewPass": {
                "Type": "Pass",
                "Result": {"greeting": "updated"},
                "End": True,
            }
        },
    }
)


@pytest.fixture()
async def provider() -> StepFunctionsProvider:
    """Provider with a simple Pass state machine."""
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
    yield p
    await p.stop()


@pytest.fixture()
async def client(provider: StepFunctionsProvider) -> httpx.AsyncClient:
    """An httpx client wired to a Step Functions ASGI app."""
    app = create_stepfunctions_app(provider)
    transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


async def _request(client: httpx.AsyncClient, target: str, body: dict) -> httpx.Response:
    return await client.post(
        "/",
        content=json.dumps(body),
        headers={"X-Amz-Target": f"AWSStepFunctions.{target}"},
    )


class TestStopExecution:
    async def test_stop_execution_sets_aborted(self, client: httpx.AsyncClient) -> None:
        """StopExecution should set execution status to ABORTED."""
        # Arrange
        expected_status_code = 200
        expected_status = "ABORTED"

        start_resp = await _request(
            client,
            "StartSyncExecution",
            {
                "stateMachineArn": "arn:aws:states:us-east-1:000:stateMachine:test-express",
                "input": "{}",
            },
        )
        arn = start_resp.json()["executionArn"]

        # Act
        stop_resp = await _request(
            client,
            "StopExecution",
            {"executionArn": arn},
        )

        # Assert
        assert stop_resp.status_code == expected_status_code
        data = stop_resp.json()
        assert "stopDate" in data

        desc_resp = await _request(
            client,
            "DescribeExecution",
            {"executionArn": arn},
        )
        assert desc_resp.status_code == expected_status_code
        actual_status = desc_resp.json()["status"]
        assert actual_status == expected_status

    async def test_stop_execution_with_error_and_cause(self, client: httpx.AsyncClient) -> None:
        """StopExecution should store error and cause when provided."""
        # Arrange
        expected_status_code = 200
        expected_status = "ABORTED"
        expected_error = "UserCancelled"
        expected_cause = "User requested cancellation"

        start_resp = await _request(
            client,
            "StartSyncExecution",
            {
                "stateMachineArn": "arn:aws:states:us-east-1:000:stateMachine:test-express",
                "input": "{}",
            },
        )
        arn = start_resp.json()["executionArn"]

        # Act
        stop_resp = await _request(
            client,
            "StopExecution",
            {
                "executionArn": arn,
                "error": expected_error,
                "cause": expected_cause,
            },
        )

        # Assert
        assert stop_resp.status_code == expected_status_code

        desc_resp = await _request(
            client,
            "DescribeExecution",
            {"executionArn": arn},
        )
        data = desc_resp.json()
        assert data["status"] == expected_status
        assert data["error"] == expected_error
        assert data["cause"] == expected_cause

    async def test_stop_nonexistent_execution_returns_error(
        self, client: httpx.AsyncClient
    ) -> None:
        """StopExecution with invalid ARN should return ExecutionDoesNotExist."""
        # Arrange
        expected_status_code = 400
        expected_error_type = "ExecutionDoesNotExist"

        # Act
        resp = await _request(
            client,
            "StopExecution",
            {"executionArn": "arn:aws:states:us-east-1:000:execution:sm:does-not-exist"},
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type
