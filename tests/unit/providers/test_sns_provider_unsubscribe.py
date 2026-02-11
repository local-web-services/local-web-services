"""Tests for SNS provider-level Unsubscribe."""

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


class TestProviderUnsubscribe:
    @pytest.mark.asyncio
    async def test_unsubscribe_returns_true_on_success(
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
        actual_result = await provider.unsubscribe(sub_arn)

        # Assert
        assert actual_result is True

    @pytest.mark.asyncio
    async def test_unsubscribe_returns_false_when_not_found(
        self,
        provider: SnsProvider,
    ) -> None:
        # Act
        actual_result = await provider.unsubscribe("arn:aws:sns:us-east-1:000000000000:x:nope")

        # Assert
        assert actual_result is False
