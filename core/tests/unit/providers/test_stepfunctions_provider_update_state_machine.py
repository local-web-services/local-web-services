"""Tests for Step Functions provider-level UpdateStateMachine."""

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


class TestProviderUpdateStateMachine:
    async def test_update_definition(self, provider: StepFunctionsProvider) -> None:
        """Provider.update_state_machine should update the definition."""
        update_date = provider.update_state_machine("test-sm", definition=UPDATED_DEFINITION)
        assert isinstance(update_date, float)

        # Verify the definition was updated
        defn = provider.get_definition("test-sm")
        assert defn is not None
        assert "NewPass" in defn.states

    async def test_update_role_arn(self, provider: StepFunctionsProvider) -> None:
        """Provider.update_state_machine should update the role ARN."""
        # Arrange
        expected_role_arn = "arn:aws:iam::000:role/updated"

        # Act
        provider.update_state_machine("test-sm", role_arn=expected_role_arn)

        # Assert
        info = provider.describe_state_machine("test-sm")
        actual_role_arn = info["roleArn"]
        assert actual_role_arn == expected_role_arn

    async def test_update_nonexistent_raises(self, provider: StepFunctionsProvider) -> None:
        """Provider.update_state_machine should raise KeyError for unknown name."""
        with pytest.raises(KeyError):
            provider.update_state_machine("nonexistent", definition="{}")
