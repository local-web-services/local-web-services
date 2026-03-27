"""Tests for SNS publish enforcement — rejection when subscribed SQS queue is not ACTIVE."""

from __future__ import annotations

import httpx
import pytest

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker
from lws.providers.sns.provider import SnsProvider, TopicConfig
from lws.providers.sns.routes import create_sns_app
from lws.providers.sqs.provider import SqsProvider


async def _started_provider(topic_arn: str) -> SnsProvider:
    provider = SnsProvider(topics=[TopicConfig(topic_name="my-topic", topic_arn=topic_arn)])
    await provider.start()
    return provider


def _client(app) -> httpx.AsyncClient:
    transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


class TestSnsPublishSqsQueueNotActiveRejection:
    """Publish is rejected when a subscribed SQS queue is CREATING or DELETING."""

    @pytest.mark.asyncio
    async def test_publish_rejected_when_subscribed_queue_is_creating(self) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_fragment = "not ACTIVE"
        expected_queue_name = "my-queue"
        topic_arn = "arn:aws:sns:us-east-1:000000000000:my-topic"
        provider = await _started_provider(topic_arn)
        queue_url = f"http://localhost:4566/000000000000/{expected_queue_name}"
        await provider.subscribe(topic_name="my-topic", protocol="sqs", endpoint=queue_url)
        lc = ResourceLifecycleConfig()
        sqs_tracker = ResourceStateTracker(lc)
        sqs_tracker.set_state(expected_queue_name, "CREATING")
        sqs_provider = SqsProvider()
        app = create_sns_app(provider, sqs_provider=sqs_provider, sqs_tracker=sqs_tracker)

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                data={
                    "Action": "Publish",
                    "TopicArn": topic_arn,
                    "Message": "hello",
                },
            )

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        assert (
            expected_error_fragment in response.text
        ), f"Expected {expected_error_fragment!r} to be in {response.text!r}"

    @pytest.mark.asyncio
    async def test_publish_rejected_when_subscribed_queue_is_deleting(self) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_fragment = "not ACTIVE"
        expected_queue_name = "my-queue"
        topic_arn = "arn:aws:sns:us-east-1:000000000000:my-topic"
        provider = await _started_provider(topic_arn)
        queue_url = f"http://localhost:4566/000000000000/{expected_queue_name}"
        await provider.subscribe(topic_name="my-topic", protocol="sqs", endpoint=queue_url)
        lc = ResourceLifecycleConfig()
        sqs_tracker = ResourceStateTracker(lc)
        sqs_tracker.set_state(expected_queue_name, "DELETING")
        sqs_provider = SqsProvider()
        app = create_sns_app(provider, sqs_provider=sqs_provider, sqs_tracker=sqs_tracker)

        # Act
        async with _client(app) as client:
            response = await client.post(
                "/",
                data={
                    "Action": "Publish",
                    "TopicArn": topic_arn,
                    "Message": "hello",
                },
            )

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        assert (
            expected_error_fragment in response.text
        ), f"Expected {expected_error_fragment!r} to be in {response.text!r}"
