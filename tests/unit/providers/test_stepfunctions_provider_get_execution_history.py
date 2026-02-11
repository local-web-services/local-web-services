"""Tests for Step Functions provider-level GetExecutionHistory."""

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


class TestProviderGetExecutionHistory:
    async def test_get_execution_history(self, provider: StepFunctionsProvider) -> None:
        """Provider.get_execution_history should return events list."""
        result = await provider.start_execution(
            state_machine_name="test-express",
            input_data={"x": 1},
        )
        arn = result["executionArn"]

        events = provider.get_execution_history(arn)
        assert len(events) >= 1
        assert events[0]["type"] == "ExecutionStarted"

    async def test_get_execution_history_max_results(self, provider: StepFunctionsProvider) -> None:
        """Provider.get_execution_history should respect max_results."""
        result = await provider.start_execution(
            state_machine_name="test-express",
            input_data={},
        )
        arn = result["executionArn"]

        events = provider.get_execution_history(arn, max_results=1)
        assert len(events) == 1

    async def test_get_execution_history_nonexistent_raises(
        self, provider: StepFunctionsProvider
    ) -> None:
        """Provider.get_execution_history should raise KeyError for unknown ARN."""
        with pytest.raises(KeyError):
            provider.get_execution_history("arn:aws:states:us-east-1:000:execution:sm:nope")
