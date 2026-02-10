"""Tests for Step Functions UpdateStateMachine operation."""

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


class TestUpdateStateMachine:
    async def test_update_definition(self, client: httpx.AsyncClient) -> None:
        """UpdateStateMachine should update the definition and return updateDate."""
        resp = await _request(
            client,
            "UpdateStateMachine",
            {
                "stateMachineArn": "arn:aws:states:us-east-1:000000000000:stateMachine:test-sm",
                "definition": UPDATED_DEFINITION,
            },
        )
        assert resp.status_code == 200
        data = resp.json()
        assert "updateDate" in data

    async def test_update_role_arn(self, client: httpx.AsyncClient) -> None:
        """UpdateStateMachine should update roleArn."""
        resp = await _request(
            client,
            "UpdateStateMachine",
            {
                "stateMachineArn": "arn:aws:states:us-east-1:000000000000:stateMachine:test-sm",
                "roleArn": "arn:aws:iam::000000000000:role/new-role",
            },
        )
        assert resp.status_code == 200
        data = resp.json()
        assert "updateDate" in data

        # Verify the roleArn was updated via DescribeStateMachine
        desc_resp = await _request(
            client,
            "DescribeStateMachine",
            {"stateMachineArn": "arn:aws:states:us-east-1:000000000000:stateMachine:test-sm"},
        )
        assert desc_resp.status_code == 200
        assert desc_resp.json()["roleArn"] == "arn:aws:iam::000000000000:role/new-role"

    async def test_update_nonexistent_state_machine_returns_error(
        self, client: httpx.AsyncClient
    ) -> None:
        """UpdateStateMachine with invalid ARN should return StateMachineDoesNotExist."""
        resp = await _request(
            client,
            "UpdateStateMachine",
            {
                "stateMachineArn": "arn:aws:states:us-east-1:000:stateMachine:nonexistent",
                "definition": "{}",
            },
        )
        assert resp.status_code == 400
        body = resp.json()
        assert body["__type"] == "StateMachineDoesNotExist"

    async def test_update_definition_changes_behavior(self, client: httpx.AsyncClient) -> None:
        """After updating definition, new executions should use the new definition."""
        # Update with new definition
        await _request(
            client,
            "UpdateStateMachine",
            {
                "stateMachineArn": (
                    "arn:aws:states:us-east-1:000000000000:stateMachine:test-express"
                ),
                "definition": UPDATED_DEFINITION,
            },
        )

        # Run an execution with the updated definition
        exec_resp = await _request(
            client,
            "StartSyncExecution",
            {
                "stateMachineArn": "arn:aws:states:us-east-1:000:stateMachine:test-express",
                "input": "{}",
            },
        )
        assert exec_resp.status_code == 200
        data = exec_resp.json()
        assert data["status"] == "SUCCEEDED"
        output = json.loads(data["output"])
        assert output == {"greeting": "updated"}
