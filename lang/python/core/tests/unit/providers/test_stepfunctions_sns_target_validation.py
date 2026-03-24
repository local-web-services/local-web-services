"""Tests for ServiceTaskBridge SNS topic existence pre-flight validation."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge

from ._helpers import FakeSns


def make_bridge(**services) -> ServiceTaskBridge:
    return ServiceTaskBridge(services)


class TestServiceTaskBridgeSnsTargetValidation:
    """SNS publish pre-flight topic existence checks."""

    async def test_publish_succeeds_when_topic_exists(self) -> None:
        # Arrange
        expected_topic_name = "my-topic"
        expected_message_id = "sns-111"
        sns = FakeSns(message_id=expected_message_id, topics={expected_topic_name})
        bridge = make_bridge(sns=sns)
        topic_arn = f"arn:aws:sns:us-east-1:000000000000:{expected_topic_name}"

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::sns:publish",
            {"TopicArn": topic_arn, "Message": "hello"},
        )

        # Assert
        actual_message_id = result["MessageId"]
        assert (
            actual_message_id == expected_message_id
        ), f"Expected MessageId '{expected_message_id}' but got '{actual_message_id}'"

    async def test_publish_raises_when_topic_does_not_exist(self) -> None:
        # Arrange
        expected_error_pattern = "SNS topic does not exist"
        sns = FakeSns(topics=set())  # no topics
        bridge = make_bridge(sns=sns)

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error_pattern):
            await bridge.invoke(
                "arn:aws:states:::sns:publish",
                {
                    "TopicArn": "arn:aws:sns:us-east-1:000000000000:ghost-topic",
                    "Message": "msg",
                },
            )

    async def test_publish_raises_correct_topic_name_in_error(self) -> None:
        # Arrange
        expected_missing_topic = "missing-topic"
        expected_error_pattern = expected_missing_topic
        sns = FakeSns(topics=set())
        bridge = make_bridge(sns=sns)

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error_pattern):
            await bridge.invoke(
                "arn:aws:states:::sns:publish",
                {
                    "TopicArn": f"arn:aws:sns:us-east-1:000000000000:{expected_missing_topic}",
                    "Message": "msg",
                },
            )
