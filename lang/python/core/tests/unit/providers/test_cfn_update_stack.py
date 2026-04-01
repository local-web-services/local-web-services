"""Unit tests: CloudFormation UpdateStack handler."""

from __future__ import annotations

import asyncio

from lws.providers.cloudformation._cfn_handlers import (
    _handle_create_stack,
    _handle_update_stack,
)
from lws.providers.cloudformation._cfn_state import _CfnState

_ACCOUNT = "111111111111"


class TestUpdateStack:
    def test_update_stack_sets_update_complete(self) -> None:
        # Arrange
        state = _CfnState()
        asyncio.run(_handle_create_stack(state, {"StackName": "my-stack"}, _ACCOUNT))

        # Act
        response = asyncio.run(
            _handle_update_stack(state, {"StackName": "my-stack", "TemplateBody": "{}"}, _ACCOUNT)
        )

        # Assert
        actual_status_code = response.status_code
        expected_status_code = 200
        assert actual_status_code == expected_status_code
        actual_stack_status = state.stacks["my-stack"]["StackStatus"]
        expected_stack_status = "UPDATE_COMPLETE"
        assert actual_stack_status == expected_stack_status

    def test_update_missing_stack_returns_not_found(self) -> None:
        # Arrange
        state = _CfnState()

        # Act
        response = asyncio.run(
            _handle_update_stack(state, {"StackName": "missing-stack"}, _ACCOUNT)
        )

        # Assert
        actual_status = response.status_code
        expected_status = 400
        assert actual_status == expected_status
        assert b"StackNotFoundException" in response.body
