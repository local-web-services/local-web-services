"""Integration tests for the Step Functions HTTP wire protocol."""

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

_SM_ARN = "arn:aws:states:us-east-1:000000000000:stateMachine:PassMachine"
_DEFINITION = {"StartAt": "PassState", "States": {"PassState": {"Type": "Pass", "End": True}}}


@pytest.fixture
async def provider():
    p = StepFunctionsProvider(
        state_machines=[
            StateMachineConfig(
                name="PassMachine",
                definition=_DEFINITION,
                workflow_type=WorkflowType.EXPRESS,
            )
        ]
    )
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def app(provider):
    return create_stepfunctions_app(provider)


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c


class TestStepFunctionsHttpOperations:
    async def test_start_execution(self, client: httpx.AsyncClient):
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.StartExecution"},
            json={
                "stateMachineArn": _SM_ARN,
                "input": json.dumps({"key": "value"}),
            },
        )
        assert resp.status_code == 200
        body = resp.json()
        assert "executionArn" in body

    async def test_describe_execution(self, client: httpx.AsyncClient):
        start_resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.StartExecution"},
            json={"stateMachineArn": _SM_ARN},
        )
        execution_arn = start_resp.json()["executionArn"]

        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.DescribeExecution"},
            json={"executionArn": execution_arn},
        )
        assert resp.status_code == 200
        body = resp.json()
        assert body["executionArn"] == execution_arn
        assert "status" in body

    async def test_list_state_machines(self, client: httpx.AsyncClient):
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.ListStateMachines"},
            json={},
        )
        assert resp.status_code == 200
        body = resp.json()
        names = [sm["name"] for sm in body["stateMachines"]]
        assert "PassMachine" in names
