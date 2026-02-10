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
        await provider.create_topic("my-topic")
        await provider.subscribe(topic_name="my-topic", protocol="lambda", endpoint="func-a")
        subs = provider.list_subscriptions_by_topic("my-topic")
        assert len(subs) == 1
        assert subs[0].endpoint == "func-a"
