"""Tests for SNS provider-level find_subscription."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.sns.provider import SnsProvider
from lws.providers.sns.routes import create_sns_app


@pytest.fixture
async def provider():
    p = SnsProvider()
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def client(provider: SnsProvider) -> httpx.AsyncClient:
    app = create_sns_app(provider)
    transport = httpx.ASGITransport(app=app)
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


TOPIC_ARN = "arn:aws:sns:us-east-1:000000000000:my-topic"


class TestProviderFindSubscription:
    @pytest.mark.asyncio
    async def test_find_subscription_returns_sub_and_topic(
        self,
        provider: SnsProvider,
    ) -> None:
        # Arrange
        topic_name = "my-topic"
        await provider.create_topic(topic_name)
        sub_arn = await provider.subscribe(
            topic_name=topic_name, protocol="lambda", endpoint="my-func"
        )

        # Act
        actual_sub, actual_topic = provider.find_subscription(sub_arn)

        # Assert
        assert actual_sub is not None, "Expected value to be set but was None"
        assert actual_topic is not None, "Expected value to be set but was None"
        assert (
            actual_sub.subscription_arn == sub_arn
        ), f"Expected {sub_arn!r} but got {actual_sub.subscription_arn!r}"
        assert (
            actual_topic.topic_name == topic_name
        ), f"Expected {topic_name!r} but got {actual_topic.topic_name!r}"

    @pytest.mark.asyncio
    async def test_find_subscription_returns_none_when_not_found(
        self,
        provider: SnsProvider,
    ) -> None:
        # Act
        actual_sub, actual_topic = provider.find_subscription("nonexistent")

        # Assert
        assert actual_sub is None, f"Expected None but got {actual_sub!r}"
        assert actual_topic is None, f"Expected None but got {actual_topic!r}"
