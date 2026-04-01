"""Unit tests: CloudFormation DescribeStackEvents handler."""

from __future__ import annotations

import asyncio

from lws.providers.cloudformation._cfn_handlers import (
    _handle_create_stack,
    _handle_describe_stack_events,
)
from lws.providers.cloudformation._cfn_state import _CfnState

_ACCOUNT = "111111111111"


class TestDescribeStackEvents:
    def test_describe_events_returns_at_least_one_event(self) -> None:
        # Arrange
        state = _CfnState()
        asyncio.run(_handle_create_stack(state, {"StackName": "my-stack"}, _ACCOUNT))

        # Act
        response = asyncio.run(
            _handle_describe_stack_events(state, {"StackName": "my-stack"}, _ACCOUNT)
        )

        # Assert
        actual_status = response.status_code
        expected_status = 200
        assert actual_status == expected_status
        assert b"CREATE_COMPLETE" in response.body

    def test_describe_events_for_unknown_stack_returns_not_found(self) -> None:
        # Arrange
        state = _CfnState()

        # Act
        response = asyncio.run(
            _handle_describe_stack_events(state, {"StackName": "ghost"}, _ACCOUNT)
        )

        # Assert
        actual_status = response.status_code
        expected_status = 400
        assert actual_status == expected_status
        assert b"StackNotFoundException" in response.body
