"""Unit tests: CloudFormation DeleteStack handler."""

from __future__ import annotations

import asyncio

from lws.providers.cloudformation._cfn_handlers import (
    _handle_create_stack,
    _handle_delete_stack,
)
from lws.providers.cloudformation._cfn_state import _CfnState

_ACCOUNT = "111111111111"


class TestDeleteStack:
    def test_delete_stack_removes_from_state(self) -> None:
        # Arrange
        state = _CfnState()
        asyncio.run(_handle_create_stack(state, {"StackName": "my-stack"}, _ACCOUNT))

        # Act
        response = asyncio.run(_handle_delete_stack(state, {"StackName": "my-stack"}, _ACCOUNT))

        # Assert
        actual_status_code = response.status_code
        expected_status_code = 200
        assert actual_status_code == expected_status_code
        assert "my-stack" not in state.stacks

    def test_delete_nonexistent_stack_is_noop(self) -> None:
        # Arrange
        state = _CfnState()

        # Act
        response = asyncio.run(_handle_delete_stack(state, {"StackName": "ghost-stack"}, _ACCOUNT))

        # Assert
        actual_status = response.status_code
        expected_status = 200
        assert actual_status == expected_status
