"""Unit tests for StepFunctionsProvider.inject_execution."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions.engine import ExecutionStatus
from lws.providers.stepfunctions.provider import (
    StateMachineConfig,
    StepFunctionsProvider,
)

SIMPLE_PASS_DEFINITION = """{
    "StartAt": "Pass",
    "States": {"Pass": {"Type": "Pass", "End": true}}
}"""

EXECUTION_ARN = "arn:aws:states:us-east-1:000000000000:execution:my-sm:injected-001"


@pytest.fixture()
async def provider() -> StepFunctionsProvider:
    p = StepFunctionsProvider(
        state_machines=[StateMachineConfig(name="my-sm", definition=SIMPLE_PASS_DEFINITION)],
        max_wait_seconds=0.01,
    )
    await p.start()
    yield p
    await p.stop()


class TestInjectExecution:
    """Tests for StepFunctionsProvider.inject_execution."""

    async def test_inject_execution_is_visible_via_get_execution(
        self, provider: StepFunctionsProvider
    ) -> None:
        # Arrange
        expected_arn = EXECUTION_ARN

        # Act
        provider.inject_execution(expected_arn, "RUNNING")

        # Assert
        actual_history = provider.get_execution(expected_arn)
        assert actual_history is not None, "Expected value to be set but was None"
        assert (
            actual_history.execution_arn == expected_arn
        ), f"Expected {expected_arn!r} but got {actual_history.execution_arn!r}"

    async def test_inject_execution_sets_running_status(
        self, provider: StepFunctionsProvider
    ) -> None:
        # Arrange
        expected_status = ExecutionStatus.RUNNING

        # Act
        provider.inject_execution(EXECUTION_ARN, "RUNNING")

        # Assert
        actual_history = provider.get_execution(EXECUTION_ARN)
        assert actual_history is not None, "Expected value to be set but was None"
        assert (
            actual_history.status == expected_status
        ), f"Expected {expected_status!r} but got {actual_history.status!r}"

    async def test_inject_execution_parses_state_machine_name(
        self, provider: StepFunctionsProvider
    ) -> None:
        # Arrange
        expected_sm_name = "my-sm"

        # Act
        provider.inject_execution(EXECUTION_ARN, "RUNNING")

        # Assert
        actual_history = provider.get_execution(EXECUTION_ARN)
        assert actual_history is not None, "Expected value to be set but was None"
        assert (
            actual_history.state_machine_name == expected_sm_name
        ), f"Expected {expected_sm_name!r} but got {actual_history.state_machine_name!r}"

    async def test_inject_execution_visible_in_list_executions(
        self, provider: StepFunctionsProvider
    ) -> None:
        # Arrange
        expected_arn = EXECUTION_ARN

        # Act
        provider.inject_execution(expected_arn, "RUNNING")

        # Assert
        actual_executions = provider.list_executions(state_machine_name="my-sm")
        actual_arns = [h.execution_arn for h in actual_executions]
        assert expected_arn in actual_arns, f"Expected {expected_arn!r} to be in {actual_arns!r}"

    async def test_inject_execution_reset_clears_injected(
        self, provider: StepFunctionsProvider
    ) -> None:
        # Arrange
        provider.inject_execution(EXECUTION_ARN, "RUNNING")

        # Act
        await provider.reset()

        # Assert
        actual_history = provider.get_execution(EXECUTION_ARN)
        assert actual_history is None, f"Expected None but got {actual_history!r}"
