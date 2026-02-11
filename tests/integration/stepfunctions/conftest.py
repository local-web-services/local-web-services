"""Shared fixtures for Step Functions integration tests."""

from __future__ import annotations

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
