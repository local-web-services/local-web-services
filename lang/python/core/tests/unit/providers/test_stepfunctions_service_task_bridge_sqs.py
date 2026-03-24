"""Tests for ServiceTaskBridge SQS service integration dispatch."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge

from ._helpers import FakeSqs


def make_bridge(**services) -> ServiceTaskBridge:
    return ServiceTaskBridge(services)


class TestServiceTaskBridgeInvokeSqs:
    """SQS service integration dispatching."""

    async def test_send_message_by_queue_url(self) -> None:
        # Arrange
        expected_queue_name = "my-queue"
        expected_body = "hello"
        expected_message_id = "msg-xyz"
        sqs = FakeSqs(message_id=expected_message_id)
        bridge = make_bridge(sqs=sqs)

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::sqs:sendMessage",
            {
                "QueueUrl": f"http://localhost:4566/000000000000/{expected_queue_name}",
                "MessageBody": expected_body,
            },
        )

        # Assert
        actual_message_id = result["MessageId"]
        actual_send_calls = sqs.send_calls
        assert actual_message_id == expected_message_id
        assert actual_send_calls[0] == (expected_queue_name, expected_body)

    async def test_send_message_by_queue_name(self) -> None:
        # Arrange
        expected_queue_name = "plain-queue"
        sqs = FakeSqs()
        bridge = make_bridge(sqs=sqs)

        # Act
        await bridge.invoke(
            "arn:aws:states:::sqs:sendMessage",
            {"QueueUrl": expected_queue_name, "MessageBody": "msg"},
        )

        # Assert
        actual_queue_name = sqs.send_calls[0][0]
        assert actual_queue_name == expected_queue_name

    async def test_send_message_missing_provider_raises(self) -> None:
        # Arrange
        bridge = make_bridge()
        expected_error = "No SQS provider"

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error):
            await bridge.invoke("arn:aws:states:::sqs:sendMessage", {})
