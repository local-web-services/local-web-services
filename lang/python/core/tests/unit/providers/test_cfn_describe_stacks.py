"""Unit tests: CloudFormation DescribeStacks handler."""

from __future__ import annotations

import asyncio

from lws.providers.cloudformation._cfn_handlers import (
    _handle_create_stack,
    _handle_describe_stacks,
)
from lws.providers.cloudformation._cfn_state import _CfnState

_ACCOUNT = "111111111111"


class TestDescribeStacks:
    def test_describe_all_stacks_returns_all(self) -> None:
        # Arrange
        state = _CfnState()
        for name in ["stack-a", "stack-b", "stack-c"]:
            asyncio.run(_handle_create_stack(state, {"StackName": name}, _ACCOUNT))

        # Act
        response = asyncio.run(_handle_describe_stacks(state, {}, _ACCOUNT))

        # Assert
        actual_status = response.status_code
        expected_status = 200
        assert actual_status == expected_status
        body_text = response.body.decode()
        assert "stack-a" in body_text
        assert "stack-b" in body_text
        assert "stack-c" in body_text

    def test_describe_with_name_filter_returns_single_stack(self) -> None:
        # Arrange
        state = _CfnState()
        asyncio.run(_handle_create_stack(state, {"StackName": "my-stack"}, _ACCOUNT))

        # Act
        response = asyncio.run(_handle_describe_stacks(state, {"StackName": "my-stack"}, _ACCOUNT))

        # Assert
        actual_status = response.status_code
        expected_status = 200
        assert actual_status == expected_status
        assert b"my-stack" in response.body

    def test_describe_unknown_stack_returns_not_found(self) -> None:
        # Arrange
        state = _CfnState()

        # Act
        response = asyncio.run(_handle_describe_stacks(state, {"StackName": "ghost"}, _ACCOUNT))

        # Assert
        actual_status = response.status_code
        expected_status = 400
        assert actual_status == expected_status
        assert b"StackNotFoundException" in response.body
