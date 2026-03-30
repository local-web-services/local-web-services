"""Tests that StepFunctions routes return ServiceUnavailableException when capacity is exhausted."""

from __future__ import annotations

import json

import httpx
import pytest

from lws.providers._shared.aws_capacity import AwsCapacityConfig
from lws.providers.stepfunctions.provider import StateMachineConfig, StepFunctionsProvider
from lws.providers.stepfunctions.routes import create_stepfunctions_app

_SIMPLE_DEFINITION = json.dumps(
    {
        "StartAt": "Pass",
        "States": {
            "Pass": {
                "Type": "Pass",
                "End": True,
            }
        },
    }
)

_STATE_MACHINE_ARN = "arn:aws:states:us-east-1:000:stateMachine:test-sm"


class TestStepFunctionsRoutesCapacityExhausted:
    """StepFunctions routes return 503 for StartExecution when capacity slots=0."""

    @pytest.fixture()
    async def provider(self) -> StepFunctionsProvider:
        """Start and yield a StepFunctionsProvider, then stop it."""
        p = StepFunctionsProvider(
            state_machines=[StateMachineConfig(name="test-sm", definition=_SIMPLE_DEFINITION)],
            max_wait_seconds=0.01,
        )
        await p.start()
        yield p
        await p.stop()

    @pytest.mark.asyncio
    async def test_start_execution_capacity_exhausted(
        self, provider: StepFunctionsProvider
    ) -> None:
        # Arrange
        capacity = AwsCapacityConfig(slots=0)
        app = create_stepfunctions_app(provider, capacity=capacity)
        transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
        expected_status_code = 400
        expected_error_type = "ServiceUnavailableException"

        # Act
        async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
            resp = await client.post(
                "/",
                json={"stateMachineArn": _STATE_MACHINE_ARN, "input": "{}"},
                headers={"x-amz-target": "AWSStepFunctions.StartExecution"},
            )

        # Assert
        actual_status_code = resp.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = resp.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"
