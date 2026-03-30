"""Tests for ServiceTaskBridge capacity enforcement on SQS dispatches."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge

from ._helpers import FakeExhaustedCapacity, FakeSqs, FakeUnlimitedCapacity


def make_bridge(**services) -> ServiceTaskBridge:
    return ServiceTaskBridge(services)


class TestSqsCapacity:
    """SQS dispatch is blocked when capacity is exhausted."""

    async def test_send_message_raises_when_capacity_exhausted(self) -> None:
        # Arrange
        sqs = FakeSqs()
        bridge = make_bridge(sqs=sqs, sqs_capacity=FakeExhaustedCapacity())
        expected_error = "SQS capacity is exhausted"

        # Act / Assert
        with pytest.raises(RuntimeError, match=expected_error):
            await bridge.invoke(
                "arn:aws:states:::sqs:sendMessage",
                {"QueueUrl": "http://sqs/orders", "MessageBody": "hello"},
            )

    async def test_send_message_succeeds_when_capacity_unlimited(self) -> None:
        # Arrange
        sqs = FakeSqs()
        bridge = make_bridge(sqs=sqs, sqs_capacity=FakeUnlimitedCapacity())

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::sqs:sendMessage",
            {"QueueUrl": "http://sqs/orders", "MessageBody": "hello"},
        )

        # Assert
        actual_message_id = result.get("MessageId")
        assert actual_message_id is not None, "Expected a MessageId in the response"
