"""Unit tests: _CfnState initial state."""

from __future__ import annotations

from lws.providers.cloudformation._cfn_state import _CfnState


class TestCfnState:
    def test_stacks_empty_on_init(self) -> None:
        # Arrange / Act
        state = _CfnState()

        # Assert
        actual_stacks = state.stacks
        expected_stacks: dict = {}
        assert actual_stacks == expected_stacks

    def test_reset_clears_stacks(self) -> None:
        # Arrange
        state = _CfnState()
        state.stacks["my-stack"] = {"StackName": "my-stack"}

        # Act
        state.reset()

        # Assert
        actual_stacks = state.stacks
        expected_stacks: dict = {}
        assert actual_stacks == expected_stacks
