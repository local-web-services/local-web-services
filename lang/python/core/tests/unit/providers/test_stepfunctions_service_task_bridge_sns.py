"""Tests for ServiceTaskBridge SNS service integration dispatch."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge

from ._helpers import FakeSns


def make_bridge(**services) -> ServiceTaskBridge:
    return ServiceTaskBridge(services)


class TestServiceTaskBridgeInvokeSns:
    """SNS service integration dispatching."""

    async def test_publish_extracts_topic_name_from_arn(self) -> None:
        # Arrange
        expected_topic_name = "my-topic"
        expected_message = "hello sns"
        expected_message_id = "sns-001"
        sns = FakeSns(message_id=expected_message_id)
        bridge = make_bridge(sns=sns)

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::sns:publish",
            {
                "TopicArn": f"arn:aws:sns:us-east-1:000000000000:{expected_topic_name}",
                "Message": expected_message,
            },
        )

        # Assert
        actual_message_id = result["MessageId"]
        actual_topic, actual_message = sns.publish_calls[0]
        assert actual_message_id == expected_message_id
        assert actual_topic == expected_topic_name
        assert actual_message == expected_message

    async def test_publish_missing_provider_raises(self) -> None:
        # Arrange
        bridge = make_bridge()
        expected_error = "No SNS provider"

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error):
            await bridge.invoke("arn:aws:states:::sns:publish", {})
