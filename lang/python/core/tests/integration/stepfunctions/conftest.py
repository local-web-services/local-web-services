"""Shared fixtures and BDD step definitions for Step Functions integration tests."""

from __future__ import annotations

import pytest
from starlette.testclient import TestClient

from lws.providers.stepfunctions.provider import (
    StateMachineConfig,
    StepFunctionsProvider,
    WorkflowType,
)
from lws.providers.stepfunctions.routes import create_stepfunctions_app

# Import step packages — each __init__.py aggregates its step files.
# Wildcard into conftest namespace so pytest-bdd can discover step definitions.
from .given import *  # noqa: F401,F403
from .then import *  # noqa: F401,F403
from .when import *  # noqa: F401,F403


@pytest.fixture
async def provider():
    p = StepFunctionsProvider(
        state_machines=[
            StateMachineConfig(
                name="PassMachine",
                definition={
                    "StartAt": "PassState",
                    "States": {"PassState": {"Type": "Pass", "End": True}},
                },
                workflow_type=WorkflowType.STANDARD,
            ),
            StateMachineConfig(
                name="PassMachineExpress",
                definition={
                    "StartAt": "PassState",
                    "States": {"PassState": {"Type": "Pass", "End": True}},
                },
                workflow_type=WorkflowType.EXPRESS,
            ),
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
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c
