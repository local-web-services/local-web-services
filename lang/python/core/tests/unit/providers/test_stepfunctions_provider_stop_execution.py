"""Tests for Step Functions provider-level StopExecution."""

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


class TestProviderStopExecution:
    async def test_stop_execution_provider(self, provider: StepFunctionsProvider) -> None:
        """Provider.stop_execution should set status to ABORTED."""
        # Arrange
        expected_status = "ABORTED"
        result = await provider.start_execution(
            state_machine_name="test-express",
            input_data={},
        )
        arn = result["executionArn"]

        # Act
        provider.stop_execution(arn)

        # Assert
        history = provider.get_execution(arn)
        actual_status = history.status.value
        assert history is not None
        assert actual_status == expected_status
        assert history.end_time is not None

    async def test_stop_execution_with_error_cause(self, provider: StepFunctionsProvider) -> None:
        """Provider.stop_execution should store error and cause."""
        # Arrange
        expected_error = "MyError"
        expected_cause = "MyCause"
        result = await provider.start_execution(
            state_machine_name="test-express",
            input_data={},
        )
        arn = result["executionArn"]

        # Act
        provider.stop_execution(arn, error=expected_error, cause=expected_cause)

        # Assert
        history = provider.get_execution(arn)
        assert history is not None
        assert history.error == expected_error
        assert history.cause == expected_cause

    async def test_stop_nonexistent_execution_raises(self, provider: StepFunctionsProvider) -> None:
        """Provider.stop_execution should raise KeyError for unknown ARN."""
        with pytest.raises(KeyError):
            provider.stop_execution("arn:aws:states:us-east-1:000:execution:sm:nope")
