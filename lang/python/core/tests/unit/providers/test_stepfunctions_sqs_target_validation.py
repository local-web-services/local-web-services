"""Tests for ServiceTaskBridge SQS queue existence pre-flight validation."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge

from ._helpers import FakeSqs


def make_bridge(**services) -> ServiceTaskBridge:
    return ServiceTaskBridge(services)


class TestServiceTaskBridgeSqsTargetValidation:
    """SQS sendMessage pre-flight queue existence checks."""

    async def test_send_message_succeeds_when_queue_exists(self) -> None:
        # Arrange
        expected_queue_name = "existing-queue"
        expected_message_id = "msg-123"
        sqs = FakeSqs(message_id=expected_message_id, queues={expected_queue_name})
        bridge = make_bridge(sqs=sqs)

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::sqs:sendMessage",
            {"QueueUrl": expected_queue_name, "MessageBody": "hello"},
        )

        # Assert
        actual_message_id = result["MessageId"]
        assert (
            actual_message_id == expected_message_id
        ), f"Expected MessageId '{expected_message_id}' but got '{actual_message_id}'"

    async def test_send_message_raises_when_queue_does_not_exist(self) -> None:
        # Arrange
        expected_error_pattern = "SQS queue does not exist"
        sqs = FakeSqs(queues=set())  # no queues registered
        bridge = make_bridge(sqs=sqs)

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error_pattern):
            await bridge.invoke(
                "arn:aws:states:::sqs:sendMessage",
                {"QueueUrl": "http://localhost/000/nonexistent-queue", "MessageBody": "body"},
            )

    async def test_send_message_raises_queue_name_from_url(self) -> None:
        # Arrange
        expected_missing_queue = "missing-queue"
        expected_error_pattern = expected_missing_queue
        sqs = FakeSqs(queues=set())
        bridge = make_bridge(sqs=sqs)

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error_pattern):
            await bridge.invoke(
                "arn:aws:states:::sqs:sendMessage",
                {
                    "QueueUrl": f"http://localhost:4566/000000000000/{expected_missing_queue}",
                    "MessageBody": "msg",
                },
            )
