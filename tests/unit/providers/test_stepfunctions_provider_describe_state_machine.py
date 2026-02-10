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
        provider.create_state_machine(
            name="described-sm",
            definition='{"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": true}}}',
            role_arn="arn:aws:iam::123:role/MyRole",
        )
        attrs = provider.describe_state_machine("described-sm")
        assert attrs["name"] == "described-sm"
        assert "stateMachineArn" in attrs
        assert attrs["roleArn"] == "arn:aws:iam::123:role/MyRole"
        assert attrs["status"] == "ACTIVE"

    async def test_describe_nonexistent_raises(self, provider: StepFunctionsProvider) -> None:
        with pytest.raises(KeyError, match="State machine not found"):
            provider.describe_state_machine("nonexistent")
