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


class TestCreateStateMachine:
    async def test_create_returns_arn(self, provider: StepFunctionsProvider) -> None:
        arn = provider.create_state_machine(
            name="test-sm",
            definition='{"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": true}}}',
        )
        assert arn == "arn:aws:states:us-east-1:000000000000:stateMachine:test-sm"

    async def test_created_appears_in_list(self, provider: StepFunctionsProvider) -> None:
        provider.create_state_machine(
            name="my-sm",
            definition='{"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": true}}}',
        )
        names = provider.list_state_machines()
        assert "my-sm" in names

    async def test_create_is_idempotent(self, provider: StepFunctionsProvider) -> None:
        definition = '{"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": true}}}'
        arn1 = provider.create_state_machine(name="sm", definition=definition)
        arn2 = provider.create_state_machine(name="sm", definition=definition)
        assert arn1 == arn2

    async def test_create_express_type(self, provider: StepFunctionsProvider) -> None:
        provider.create_state_machine(
            name="express-sm",
            definition='{"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": true}}}',
            workflow_type="EXPRESS",
        )
        attrs = provider.describe_state_machine("express-sm")
        assert attrs["type"] == "EXPRESS"
