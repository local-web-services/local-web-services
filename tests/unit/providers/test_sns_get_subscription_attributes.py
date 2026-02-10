"""Tests for SNS GetSubscriptionAttributes route."""

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


class TestGetSubscriptionAttributes:
    @pytest.mark.asyncio
    async def test_get_subscription_attributes_success(
        self,
        client: httpx.AsyncClient,
        provider: SnsProvider,
    ) -> None:
        await provider.create_topic("my-topic")
        sub_arn = await provider.subscribe(
            topic_name="my-topic", protocol="sqs", endpoint="my-queue"
        )

        resp = await client.post(
            "/",
            data={"Action": "GetSubscriptionAttributes", "SubscriptionArn": sub_arn},
        )

        assert resp.status_code == 200
        assert "GetSubscriptionAttributesResponse" in resp.text
        assert "<key>Protocol</key>" in resp.text
        assert "<value>sqs</value>" in resp.text
        assert "<key>Endpoint</key>" in resp.text
        assert "<value>my-queue</value>" in resp.text
        assert "<key>TopicArn</key>" in resp.text
        assert TOPIC_ARN in resp.text
        assert "<key>SubscriptionArn</key>" in resp.text
        assert sub_arn in resp.text

    @pytest.mark.asyncio
    async def test_get_subscription_attributes_not_found(
        self,
        client: httpx.AsyncClient,
    ) -> None:
        resp = await client.post(
            "/",
            data={
                "Action": "GetSubscriptionAttributes",
                "SubscriptionArn": "arn:aws:sns:us-east-1:000000000000:my-topic:nonexistent",
            },
        )

        assert resp.status_code == 404
        assert "NotFound" in resp.text
