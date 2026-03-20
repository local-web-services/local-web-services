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
        assert stop_resp.status_code == expected_status_code, (
            f"Expected {expected_status_code!r} but got {stop_resp.status_code!r}"
        )
        data = stop_resp.json()
        assert "stopDate" in data, f'Expected {"stopDate"!r} to be in {data!r}'

        desc_resp = await _request(
            client,
            "DescribeExecution",
            {"executionArn": arn},
        )
        assert desc_resp.status_code == expected_status_code, (
            f"Expected {expected_status_code!r} but got {desc_resp.status_code!r}"
        )
        actual_status = desc_resp.json()["status"]
        assert actual_status == expected_status, (
            f"Expected {expected_status!r} but got {actual_status!r}"
        )

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
        assert stop_resp.status_code == expected_status_code, (
            f"Expected {expected_status_code!r} but got {stop_resp.status_code!r}"
        )

        desc_resp = await _request(
            client,
            "DescribeExecution",
            {"executionArn": arn},
        )
        data = desc_resp.json()
        assert data["status"] == expected_status, (
            f'Expected {expected_status!r} but got {data["status"]!r}'
        )
        assert data["error"] == expected_error, (
            f'Expected {expected_error!r} but got {data["error"]!r}'
        )
        assert data["cause"] == expected_cause, (
            f'Expected {expected_cause!r} but got {data["cause"]!r}'
        )

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
        assert resp.status_code == expected_status_code, (
            f"Expected {expected_status_code!r} but got {resp.status_code!r}"
        )
        body = resp.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type, (
            f"Expected {expected_error_type!r} but got {actual_error_type!r}"
        )
