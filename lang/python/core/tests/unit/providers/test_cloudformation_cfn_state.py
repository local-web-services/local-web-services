"""Tests for CloudFormation _CfnState."""

from __future__ import annotations

from lws.providers.cloudformation._cfn_state import _CfnState


class TestCfnState:
    def test_initial_state_has_empty_stacks(self) -> None:
        # Arrange
        expected_count = 0

        # Act
        state = _CfnState()

        # Assert
        actual_count = len(state.stacks)
        assert (
            actual_count == expected_count
        ), f"Expected {expected_count!r} stacks but got {actual_count!r}"

    def test_stacks_property_returns_store(self) -> None:
        # Arrange
        state = _CfnState()
        stack_name = "my-stack"
        stack_data = {"StackName": stack_name, "StackStatus": "CREATE_COMPLETE"}
        state.stacks[stack_name] = stack_data

        # Act
        actual_stacks = state.stacks

        # Assert
        assert stack_name in actual_stacks, f"Expected {stack_name!r} to be in stacks"
        actual_data = actual_stacks[stack_name]
        assert actual_data == stack_data, f"Expected {stack_data!r} but got {actual_data!r}"

    def test_reset_clears_all_stacks(self) -> None:
        # Arrange
        state = _CfnState()
        state.stacks["stack-a"] = {"StackName": "stack-a"}
        state.stacks["stack-b"] = {"StackName": "stack-b"}
        expected_count = 0

        # Act
        state.reset()

        # Assert
        actual_count = len(state.stacks)
        assert (
            actual_count == expected_count
        ), f"Expected {expected_count!r} stacks after reset but got {actual_count!r}"
