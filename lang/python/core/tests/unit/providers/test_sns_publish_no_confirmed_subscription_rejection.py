"""Tests for SNS publish enforcement — rejection when no confirmed subscription exists."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.sns.provider import SnsProvider, TopicConfig
from lws.providers.sns.routes import create_sns_app


async def _started_provider(topics: list[TopicConfig] | None = None) -> SnsProvider:
    provider = SnsProvider(topics=topics or [])
    await provider.start()
    return provider


def _client(app) -> httpx.AsyncClient:
    transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


class TestSnsPublishNoConfirmedSubscriptionRejection:
    """Publish is rejected when the topic has no confirmed subscriptions."""

    @pytest.mark.asyncio
    async def test_publish_rejected_when_no_subscriptions(self) -> None:
        # Arrange
        expected_status_code = 400
        expected_error_fragment = "No confirmed subscriptions"
        topic_arn = "arn:aws:sns:us-east-1:000000000000:my-topic"
        provider = await _started_provider(
            topics=[TopicConfig(topic_name="my-topic", topic_arn=topic_arn)]
        )
        app = create_sns_app(provider)

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
    async def test_publish_accepted_when_confirmed_subscription_exists(self) -> None:
        # Arrange
        expected_status_code = 200
        topic_arn = "arn:aws:sns:us-east-1:000000000000:my-topic"
        provider = await _started_provider(
            topics=[TopicConfig(topic_name="my-topic", topic_arn=topic_arn)]
        )
        await provider.subscribe(topic_name="my-topic", protocol="lambda", endpoint="my-func")
        app = create_sns_app(provider)

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
            "<MessageId>" in response.text
        ), f'Expected {"<MessageId>"!r} to be in {response.text!r}'
