"""Tests for Step Functions provider management operations."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions.provider import StepFunctionsProvider


@pytest.fixture()
async def provider() -> StepFunctionsProvider:
    p = StepFunctionsProvider()
    await p.start()
    yield p
    await p.stop()


class TestDescribeStateMachine:
    async def test_describe_returns_attributes(self, provider: StepFunctionsProvider) -> None:
        # Arrange
        expected_name = "described-sm"
        expected_role_arn = "arn:aws:iam::123:role/MyRole"
        expected_status = "ACTIVE"

        # Act
        provider.create_state_machine(
            name=expected_name,
            definition='{"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": true}}}',
            role_arn=expected_role_arn,
        )
        attrs = provider.describe_state_machine(expected_name)

        # Assert
        assert attrs["name"] == expected_name, f'Expected {expected_name!r} but got {attrs["name"]!r}'
        assert "stateMachineArn" in attrs, f'Expected {"stateMachineArn"!r} to be in {attrs!r}'
        assert attrs["roleArn"] == expected_role_arn, f'Expected {expected_role_arn!r} but got {attrs["roleArn"]!r}'
        assert attrs["status"] == expected_status, f'Expected {expected_status!r} but got {attrs["status"]!r}'

    async def test_describe_nonexistent_raises(self, provider: StepFunctionsProvider) -> None:
        with pytest.raises(KeyError, match="State machine not found"):
            provider.describe_state_machine("nonexistent")
