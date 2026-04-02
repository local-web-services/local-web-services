"""Unit tests: CloudFormation CreateStack handler."""

from __future__ import annotations

import asyncio

from lws.providers.cloudformation._cfn_handlers import _handle_create_stack
from lws.providers.cloudformation._cfn_state import _CfnState

_ACCOUNT = "111111111111"


class TestCreateStack:
    def test_create_stack_returns_stack_id(self) -> None:
        # Arrange
        state = _CfnState()
        params = {"StackName": "my-stack", "TemplateBody": "{}"}

        # Act
        response = asyncio.run(_handle_create_stack(state, params, _ACCOUNT))

        # Assert
        actual_status = response.status_code
        expected_status = 200
        assert actual_status == expected_status
        assert "my-stack" in state.stacks
        assert "StackId" in state.stacks["my-stack"]

    def test_create_stack_sets_create_complete_status(self) -> None:
        # Arrange
        state = _CfnState()
        params = {"StackName": "my-stack"}

        # Act
        asyncio.run(_handle_create_stack(state, params, _ACCOUNT))

        # Assert
        actual_status = state.stacks["my-stack"]["StackStatus"]
        expected_status = "CREATE_COMPLETE"
        assert actual_status == expected_status

    def test_create_stack_duplicate_returns_already_exists(self) -> None:
        # Arrange
        state = _CfnState()
        params = {"StackName": "my-stack"}
        asyncio.run(_handle_create_stack(state, params, _ACCOUNT))

        # Act
        response = asyncio.run(_handle_create_stack(state, params, _ACCOUNT))

        # Assert
        actual_status = response.status_code
        expected_status = 400
        assert actual_status == expected_status
        assert b"AlreadyExistsException" in response.body
