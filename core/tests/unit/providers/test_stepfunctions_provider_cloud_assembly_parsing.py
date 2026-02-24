"""Tests for the Step Functions provider.

Covers provider lifecycle, IStateMachine interface, ASL parsing,
cloud assembly parsing, execution tracking, workflow types, and HTTP routes.
"""

from __future__ import annotations

import json

import httpx
import pytest

from lws.providers.stepfunctions.provider import (
    StateMachineConfig,
    StepFunctionsProvider,
    WorkflowType,
    parse_cloud_assembly_state_machine,
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

TWO_STEP_DEFINITION = json.dumps(
    {
        "StartAt": "First",
        "States": {
            "First": {
                "Type": "Pass",
                "Result": {"step": 1},
                "Next": "Second",
            },
            "Second": {
                "Type": "Pass",
                "Result": {"step": 2},
                "End": True,
            },
        },
    }
)

SUCCEED_DEFINITION = json.dumps(
    {
        "StartAt": "Done",
        "States": {
            "Done": {
                "Type": "Succeed",
            }
        },
    }
)

FAIL_DEFINITION = json.dumps(
    {
        "StartAt": "Oops",
        "States": {
            "Oops": {
                "Type": "Fail",
                "Error": "CustomError",
                "Cause": "Something went wrong",
            }
        },
    }
)


@pytest.fixture()
async def provider() -> StepFunctionsProvider:
    """Provider with a simple Pass state machine."""
    p = StepFunctionsProvider(
        state_machines=[
            StateMachineConfig(name="simple-pass", definition=SIMPLE_PASS_DEFINITION),
            StateMachineConfig(name="two-step", definition=TWO_STEP_DEFINITION),
            StateMachineConfig(name="succeed-sm", definition=SUCCEED_DEFINITION),
            StateMachineConfig(name="fail-sm", definition=FAIL_DEFINITION),
        ],
        max_wait_seconds=0.01,
    )
    await p.start()
    yield p
    await p.stop()


@pytest.fixture()
async def express_provider() -> StepFunctionsProvider:
    """Provider with an EXPRESS workflow."""
    p = StepFunctionsProvider(
        state_machines=[
            StateMachineConfig(
                name="express-pass",
                definition=SIMPLE_PASS_DEFINITION,
                workflow_type=WorkflowType.EXPRESS,
            ),
        ],
        max_wait_seconds=0.01,
    )
    await p.start()
    yield p
    await p.stop()


# ---------------------------------------------------------------------------
# P2-07: ASL Parser
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Provider lifecycle
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Standard workflow execution
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Express workflow (P2-16)
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Execution tracking (P2-15)
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Cloud Assembly parsing (P2-17)
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# HTTP routes
# ---------------------------------------------------------------------------


@pytest.fixture()
async def sfn_client() -> httpx.AsyncClient:
    """An httpx client wired to a Step Functions ASGI app."""
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
    app = create_stepfunctions_app(p)
    transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
    client = httpx.AsyncClient(transport=transport, base_url="http://testserver")
    yield client
    await p.stop()


class TestCloudAssemblyParsing:
    """Cloud assembly state machine resource parsing."""

    def test_parse_basic_state_machine(self) -> None:
        # Arrange
        expected_name = "MySM"
        props = {
            "DefinitionString": json.dumps(
                {
                    "StartAt": "S1",
                    "States": {"S1": {"Type": "Succeed"}},
                }
            ),
        }

        # Act
        config = parse_cloud_assembly_state_machine(expected_name, props)

        # Assert
        assert config.name == expected_name
        assert config.workflow_type == WorkflowType.STANDARD

    def test_parse_express_workflow(self) -> None:
        props = {
            "DefinitionString": json.dumps(
                {
                    "StartAt": "S1",
                    "States": {"S1": {"Type": "Succeed"}},
                }
            ),
            "StateMachineType": "EXPRESS",
        }
        config = parse_cloud_assembly_state_machine("MySM", props)
        assert config.workflow_type == WorkflowType.EXPRESS

    def test_definition_substitutions(self) -> None:
        props = {
            "DefinitionString": json.dumps(
                {
                    "StartAt": "Task1",
                    "States": {
                        "Task1": {
                            "Type": "Task",
                            "Resource": "${LambdaArn}",
                            "End": True,
                        }
                    },
                }
            ),
            "DefinitionSubstitutions": {
                "LambdaArn": "arn:aws:lambda:us-east-1:000:function:myFunc"
            },
        }
        config = parse_cloud_assembly_state_machine("MySM", props)
        assert "myFunc" in config.definition

    def test_resource_arn_remapping(self) -> None:
        props = {
            "DefinitionString": json.dumps(
                {
                    "StartAt": "Task1",
                    "States": {
                        "Task1": {
                            "Type": "Task",
                            "Resource": "arn:aws:lambda:us-east-1:000:function:prodFunc",
                            "End": True,
                        }
                    },
                }
            ),
        }
        mapping = {"arn:aws:lambda:us-east-1:000:function:prodFunc": "local-handler"}
        config = parse_cloud_assembly_state_machine("MySM", props, mapping)
        assert "local-handler" in config.definition
