"""Tests for SNS provider-level get_subscription_attributes."""

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


class TestProviderGetSubscriptionAttributes:
    @pytest.mark.asyncio
    async def test_raises_key_error_when_not_found(
        self,
        provider: SnsProvider,
    ) -> None:
        with pytest.raises(KeyError):
            await provider.get_subscription_attributes("nonexistent")

    @pytest.mark.asyncio
    async def test_returns_expected_attributes(
        self,
        provider: SnsProvider,
    ) -> None:
        # Arrange
        topic_name = "my-topic"
        expected_protocol = "sqs"
        expected_endpoint = "my-queue"
        await provider.create_topic(topic_name)
        sub_arn = await provider.subscribe(
            topic_name=topic_name, protocol=expected_protocol, endpoint=expected_endpoint
        )

        # Act
        actual_attrs = await provider.get_subscription_attributes(sub_arn)

        # Assert
        assert actual_attrs["Protocol"] == expected_protocol
        assert actual_attrs["Endpoint"] == expected_endpoint
        assert actual_attrs["TopicArn"] == TOPIC_ARN
        assert actual_attrs["SubscriptionArn"] == sub_arn
