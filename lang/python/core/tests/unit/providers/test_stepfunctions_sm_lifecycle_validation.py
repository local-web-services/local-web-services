"""Tests for StepFunctionsProvider state machine ACTIVE lifecycle validation."""

from __future__ import annotations

import json

import pytest

from lws.providers.stepfunctions.provider import (
    StateMachineConfig,
    StepFunctionsProvider,
)

PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})


class TestStateMachineLifecycleValidation:
    """Provider enforces ACTIVE status before starting executions."""

    async def test_start_execution_succeeds_when_active(self) -> None:
        # Arrange
        expected_sm_name = "my-sm"
        provider = StepFunctionsProvider(max_wait_seconds=0.01)
        provider.create_state_machine(expected_sm_name, PASS_DEFINITION)

        # Act
        result = await provider.start_execution(expected_sm_name)

        # Assert
        actual_execution_arn = result.get("executionArn")
        assert actual_execution_arn is not None, "Expected executionArn in result"
        assert expected_sm_name in actual_execution_arn

    async def test_start_execution_raises_when_creating(self) -> None:
        # Arrange
        expected_sm_name = "creating-sm"
        expected_status = "CREATING"
        provider = StepFunctionsProvider(max_wait_seconds=0.01)
        provider.create_state_machine(expected_sm_name, PASS_DEFINITION)
        provider.set_state_machine_status(expected_sm_name, expected_status)

        # Act
        # Assert
        with pytest.raises(ValueError, match="not ACTIVE"):
            await provider.start_execution(expected_sm_name)

    async def test_start_execution_raises_when_deleting(self) -> None:
        # Arrange
        expected_sm_name = "deleting-sm"
        expected_status = "DELETING"
        provider = StepFunctionsProvider(max_wait_seconds=0.01)
        provider.create_state_machine(expected_sm_name, PASS_DEFINITION)
        provider.set_state_machine_status(expected_sm_name, expected_status)

        # Act
        # Assert
        with pytest.raises(ValueError, match="not ACTIVE"):
            await provider.start_execution(expected_sm_name)

    async def test_get_state_machine_status_defaults_to_active(self) -> None:
        # Arrange
        expected_status = "ACTIVE"
        expected_sm_name = "fresh-sm"
        provider = StepFunctionsProvider(max_wait_seconds=0.01)
        provider.create_state_machine(expected_sm_name, PASS_DEFINITION)

        # Act
        actual_status = provider.get_state_machine_status(expected_sm_name)

        # Assert
        assert (
            actual_status == expected_status
        ), f"Expected status '{expected_status}' but got '{actual_status}'"

    async def test_set_state_machine_status_persists(self) -> None:
        # Arrange
        expected_status = "CREATING"
        expected_sm_name = "my-sm"
        provider = StepFunctionsProvider(max_wait_seconds=0.01)
        provider.create_state_machine(expected_sm_name, PASS_DEFINITION)

        # Act
        provider.set_state_machine_status(expected_sm_name, expected_status)

        # Assert
        actual_status = provider.get_state_machine_status(expected_sm_name)
        assert (
            actual_status == expected_status
        ), f"Expected status '{expected_status}' but got '{actual_status}'"

    async def test_reset_restores_active_status_for_preconfigured_sm(self) -> None:
        # Arrange
        expected_status = "ACTIVE"
        expected_sm_name = "static-sm"
        provider = StepFunctionsProvider(
            state_machines=[StateMachineConfig(name=expected_sm_name, definition=PASS_DEFINITION)],
            max_wait_seconds=0.01,
        )
        await provider.start()
        provider.set_state_machine_status(expected_sm_name, "CREATING")

        # Act
        await provider.reset()

        # Assert
        actual_status = provider.get_state_machine_status(expected_sm_name)
        assert (
            actual_status == expected_status
        ), f"Expected reset to restore status to '{expected_status}' but got '{actual_status}'"
        await provider.stop()

    async def test_create_state_machine_sets_active_status(self) -> None:
        # Arrange
        expected_status = "ACTIVE"
        expected_sm_name = "new-sm"
        provider = StepFunctionsProvider(max_wait_seconds=0.01)

        # Act
        provider.create_state_machine(expected_sm_name, PASS_DEFINITION)

        # Assert
        actual_status = provider.get_state_machine_status(expected_sm_name)
        assert actual_status == expected_status, (
            f"Expected create_state_machine to set status '{expected_status}' "
            f"but got '{actual_status}'"
        )

    async def test_delete_state_machine_clears_status(self) -> None:
        # Arrange
        expected_status = "ACTIVE"
        expected_sm_name = "to-delete-sm"
        provider = StepFunctionsProvider(max_wait_seconds=0.01)
        provider.create_state_machine(expected_sm_name, PASS_DEFINITION)

        # Act
        provider.delete_state_machine(expected_sm_name)

        # Assert: status defaults back to ACTIVE for unknown SM name
        actual_status = provider.get_state_machine_status(expected_sm_name)
        assert (
            actual_status == expected_status
        ), f"Expected deleted SM status to default to '{expected_status}' but got '{actual_status}'"
