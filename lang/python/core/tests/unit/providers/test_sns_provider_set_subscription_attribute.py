"""Tests for SNS provider-level set_subscription_attribute."""

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


class TestProviderSetSubscriptionAttribute:
    @pytest.mark.asyncio
    async def test_raises_key_error_when_not_found(
        self,
        provider: SnsProvider,
    ) -> None:
        with pytest.raises(KeyError):
            await provider.set_subscription_attribute("nonexistent", "Foo", "Bar")

    @pytest.mark.asyncio
    async def test_sets_and_reads_back_attribute(
        self,
        provider: SnsProvider,
    ) -> None:
        # Arrange
        topic_name = "my-topic"
        attribute_name = "RawMessageDelivery"
        expected_value = "true"
        await provider.create_topic(topic_name)
        sub_arn = await provider.subscribe(
            topic_name=topic_name, protocol="lambda", endpoint="my-func"
        )

        # Act
        await provider.set_subscription_attribute(sub_arn, attribute_name, expected_value)
        actual_attrs = await provider.get_subscription_attributes(sub_arn)

        # Assert
        assert actual_attrs[attribute_name] == expected_value
