"""Tests for ServiceTaskBridge capacity enforcement on SNS dispatches."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge

from ._helpers import FakeExhaustedCapacity, FakeSns, FakeUnlimitedCapacity


def make_bridge(**services) -> ServiceTaskBridge:
    return ServiceTaskBridge(services)


class TestSnsCapacity:
    """SNS dispatch is blocked when capacity is exhausted."""

    async def test_publish_raises_when_capacity_exhausted(self) -> None:
        # Arrange
        sns = FakeSns()
        bridge = make_bridge(sns=sns, sns_capacity=FakeExhaustedCapacity())
        expected_error = "SNS capacity is exhausted"

        # Act / Assert
        with pytest.raises(RuntimeError, match=expected_error):
            await bridge.invoke(
                "arn:aws:states:::sns:publish",
                {"TopicArn": "arn:aws:sns:us-east-1:123:alerts", "Message": "hello"},
            )

    async def test_publish_succeeds_when_capacity_unlimited(self) -> None:
        # Arrange
        sns = FakeSns()
        bridge = make_bridge(sns=sns, sns_capacity=FakeUnlimitedCapacity())

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::sns:publish",
            {"TopicArn": "arn:aws:sns:us-east-1:123:alerts", "Message": "hello"},
        )

        # Assert
        actual_message_id = result.get("MessageId")
        assert actual_message_id is not None, "Expected a MessageId in the response"
