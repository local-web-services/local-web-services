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
        # Arrange
        expected_arn = "arn:aws:states:us-east-1:000000000000:stateMachine:test-sm"

        # Act
        actual_arn = provider.create_state_machine(
            name="test-sm",
            definition='{"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": true}}}',
        )

        # Assert
        assert actual_arn == expected_arn

    async def test_created_appears_in_list(self, provider: StepFunctionsProvider) -> None:
        provider.create_state_machine(
            name="my-sm",
            definition='{"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": true}}}',
        )
        names = provider.list_state_machines()
        assert "my-sm" in names

    async def test_create_raises_when_already_exists(self, provider: StepFunctionsProvider) -> None:
        # Arrange
        definition = '{"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": true}}}'
        provider.create_state_machine(name="sm", definition=definition)

        # Act / Assert
        try:
            provider.create_state_machine(name="sm", definition=definition)
            assert False, "Expected ValueError for duplicate state machine"
        except ValueError:
            pass

    async def test_create_express_type(self, provider: StepFunctionsProvider) -> None:
        # Arrange
        expected_type = "EXPRESS"

        # Act
        provider.create_state_machine(
            name="express-sm",
            definition='{"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": true}}}',
            workflow_type=expected_type,
        )

        # Assert
        attrs = provider.describe_state_machine("express-sm")
        actual_type = attrs["type"]
        assert actual_type == expected_type
