"""Tests for Step Functions GetExecutionHistory operation."""

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


class TestGetExecutionHistory:
    async def test_get_execution_history_returns_events(self, client: httpx.AsyncClient) -> None:
        """GetExecutionHistory should return a list of events."""
        # Arrange
        expected_status_code = 200
        expected_first_event_type = "ExecutionStarted"
        expected_last_event_type = "ExecutionSucceeded"

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
        resp = await _request(
            client,
            "GetExecutionHistory",
            {"executionArn": arn},
        )

        # Assert
        assert resp.status_code == expected_status_code
        data = resp.json()
        assert "events" in data
        events = data["events"]
        assert len(events) >= 1
        actual_first_event_type = events[0]["type"]
        actual_last_event_type = events[-1]["type"]
        assert actual_first_event_type == expected_first_event_type
        assert actual_last_event_type == expected_last_event_type

    async def test_get_execution_history_with_max_results(self, client: httpx.AsyncClient) -> None:
        """GetExecutionHistory should respect maxResults."""
        start_resp = await _request(
            client,
            "StartSyncExecution",
            {
                "stateMachineArn": "arn:aws:states:us-east-1:000:stateMachine:test-express",
                "input": "{}",
            },
        )
        arn = start_resp.json()["executionArn"]

        resp = await _request(
            client,
            "GetExecutionHistory",
            {"executionArn": arn, "maxResults": 1},
        )
        assert resp.status_code == 200
        data = resp.json()
        assert len(data["events"]) == 1

    async def test_get_execution_history_nonexistent_returns_error(
        self, client: httpx.AsyncClient
    ) -> None:
        """GetExecutionHistory with invalid ARN should return ExecutionDoesNotExist."""
        # Arrange
        expected_status_code = 400
        expected_error_type = "ExecutionDoesNotExist"

        # Act
        resp = await _request(
            client,
            "GetExecutionHistory",
            {"executionArn": "arn:aws:states:us-east-1:000:execution:sm:does-not-exist"},
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type

    async def test_get_execution_history_aborted_execution(self, client: httpx.AsyncClient) -> None:
        """GetExecutionHistory for an aborted execution should include ExecutionAborted event."""
        # Arrange
        expected_status_code = 200
        expected_last_event_type = "ExecutionAborted"

        start_resp = await _request(
            client,
            "StartSyncExecution",
            {
                "stateMachineArn": "arn:aws:states:us-east-1:000:stateMachine:test-express",
                "input": "{}",
            },
        )
        arn = start_resp.json()["executionArn"]

        await _request(
            client,
            "StopExecution",
            {"executionArn": arn, "error": "Aborted", "cause": "test"},
        )

        # Act
        resp = await _request(
            client,
            "GetExecutionHistory",
            {"executionArn": arn},
        )

        # Assert
        assert resp.status_code == expected_status_code
        data = resp.json()
        events = data["events"]
        actual_last_event_type = events[-1]["type"]
        assert actual_last_event_type == expected_last_event_type
