"""Tests for SNS provider-level list_subscriptions_by_topic."""

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


class TestProviderListSubscriptionsByTopic:
    @pytest.mark.asyncio
    async def test_raises_key_error_when_topic_not_found(
        self,
        provider: SnsProvider,
    ) -> None:
        with pytest.raises(KeyError):
            provider.list_subscriptions_by_topic("nonexistent")

    @pytest.mark.asyncio
    async def test_returns_subscriptions_for_topic(
        self,
        provider: SnsProvider,
    ) -> None:
        # Arrange
        topic_name = "my-topic"
        expected_endpoint = "func-a"
        expected_count = 1
        await provider.create_topic(topic_name)
        await provider.subscribe(
            topic_name=topic_name,
            protocol="lambda",
            endpoint=expected_endpoint,
        )

        # Act
        actual_subs = provider.list_subscriptions_by_topic(topic_name)

        # Assert
        assert len(actual_subs) == expected_count
        assert actual_subs[0].endpoint == expected_endpoint
