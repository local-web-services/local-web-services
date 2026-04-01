"""Unit tests: CloudFormation ListStacks handler."""

from __future__ import annotations

import asyncio

from lws.providers.cloudformation._cfn_handlers import (
    _handle_create_stack,
    _handle_list_stacks,
    _handle_update_stack,
)
from lws.providers.cloudformation._cfn_state import _CfnState

_ACCOUNT = "111111111111"


class TestListStacks:
    def test_list_stacks_returns_all_summaries(self) -> None:
        # Arrange
        state = _CfnState()
        asyncio.run(_handle_create_stack(state, {"StackName": "stack-a"}, _ACCOUNT))
        asyncio.run(_handle_create_stack(state, {"StackName": "stack-b"}, _ACCOUNT))
        asyncio.run(_handle_update_stack(state, {"StackName": "stack-b"}, _ACCOUNT))

        # Act
        response = asyncio.run(_handle_list_stacks(state, {}, _ACCOUNT))

        # Assert
        actual_status = response.status_code
        expected_status = 200
        assert actual_status == expected_status
        body_text = response.body.decode()
        assert "stack-a" in body_text
        assert "stack-b" in body_text

    def test_list_stacks_with_status_filter(self) -> None:
        # Arrange
        state = _CfnState()
        asyncio.run(_handle_create_stack(state, {"StackName": "stack-a"}, _ACCOUNT))
        asyncio.run(_handle_create_stack(state, {"StackName": "stack-b"}, _ACCOUNT))
        asyncio.run(_handle_update_stack(state, {"StackName": "stack-b"}, _ACCOUNT))

        # Act
        response = asyncio.run(
            _handle_list_stacks(
                state,
                {"StackStatusFilter.member.1": "UPDATE_COMPLETE"},
                _ACCOUNT,
            )
        )

        # Assert
        actual_status = response.status_code
        expected_status = 200
        assert actual_status == expected_status
        body_text = response.body.decode()
        assert "stack-b" in body_text
        assert "stack-a" not in body_text
