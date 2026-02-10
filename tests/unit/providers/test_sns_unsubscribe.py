"""Tests for SNS Unsubscribe route."""

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


class TestUnsubscribe:
    @pytest.mark.asyncio
    async def test_unsubscribe_success(
        self,
        client: httpx.AsyncClient,
        provider: SnsProvider,
    ) -> None:
        await provider.create_topic("my-topic")
        sub_arn = await provider.subscribe(
            topic_name="my-topic", protocol="lambda", endpoint="my-func"
        )

        resp = await client.post("/", data={"Action": "Unsubscribe", "SubscriptionArn": sub_arn})

        assert resp.status_code == 200
        assert "UnsubscribeResponse" in resp.text

        # Verify the subscription was actually removed
        topic = provider.get_topic("my-topic")
        assert len(topic.subscribers) == 0

    @pytest.mark.asyncio
    async def test_unsubscribe_not_found(
        self,
        client: httpx.AsyncClient,
    ) -> None:
        resp = await client.post(
            "/",
            data={
                "Action": "Unsubscribe",
                "SubscriptionArn": "arn:aws:sns:us-east-1:000000000000:my-topic:nonexistent",
            },
        )

        assert resp.status_code == 404
        assert "NotFound" in resp.text

    @pytest.mark.asyncio
    async def test_unsubscribe_removes_only_target(
        self,
        client: httpx.AsyncClient,
        provider: SnsProvider,
    ) -> None:
        """Unsubscribing one subscription should not affect others."""
        await provider.create_topic("my-topic")
        sub_arn_1 = await provider.subscribe(
            topic_name="my-topic", protocol="lambda", endpoint="func-a"
        )
        sub_arn_2 = await provider.subscribe(
            topic_name="my-topic", protocol="lambda", endpoint="func-b"
        )

        resp = await client.post("/", data={"Action": "Unsubscribe", "SubscriptionArn": sub_arn_1})

        assert resp.status_code == 200

        topic = provider.get_topic("my-topic")
        assert len(topic.subscribers) == 1
        assert topic.subscribers[0].subscription_arn == sub_arn_2
