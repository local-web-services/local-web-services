"""Tests for SNS ListSubscriptionsByTopic route."""

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


class TestListSubscriptionsByTopic:
    @pytest.mark.asyncio
    async def test_list_subscriptions_by_topic_success(
        self,
        client: httpx.AsyncClient,
        provider: SnsProvider,
    ) -> None:
        await provider.create_topic("my-topic")
        await provider.subscribe(topic_name="my-topic", protocol="lambda", endpoint="func-a")
        await provider.subscribe(topic_name="my-topic", protocol="sqs", endpoint="queue-b")

        resp = await client.post(
            "/",
            data={"Action": "ListSubscriptionsByTopic", "TopicArn": TOPIC_ARN},
        )

        assert resp.status_code == 200
        assert "ListSubscriptionsByTopicResponse" in resp.text
        assert "func-a" in resp.text
        assert "queue-b" in resp.text
        assert "<Protocol>lambda</Protocol>" in resp.text
        assert "<Protocol>sqs</Protocol>" in resp.text

    @pytest.mark.asyncio
    async def test_list_subscriptions_by_topic_empty(
        self,
        client: httpx.AsyncClient,
        provider: SnsProvider,
    ) -> None:
        await provider.create_topic("my-topic")

        resp = await client.post(
            "/",
            data={"Action": "ListSubscriptionsByTopic", "TopicArn": TOPIC_ARN},
        )

        assert resp.status_code == 200
        assert "ListSubscriptionsByTopicResponse" in resp.text
        assert "<Subscriptions>" in resp.text

    @pytest.mark.asyncio
    async def test_list_subscriptions_by_topic_not_found(
        self,
        client: httpx.AsyncClient,
    ) -> None:
        resp = await client.post(
            "/",
            data={
                "Action": "ListSubscriptionsByTopic",
                "TopicArn": "arn:aws:sns:us-east-1:000000000000:nonexistent",
            },
        )

        assert resp.status_code == 404
        assert "NotFound" in resp.text

    @pytest.mark.asyncio
    async def test_list_subscriptions_by_topic_isolates_topics(
        self,
        client: httpx.AsyncClient,
        provider: SnsProvider,
    ) -> None:
        """Subscriptions from other topics should not appear."""
        await provider.create_topic("my-topic")
        await provider.create_topic("other-topic")
        await provider.subscribe(topic_name="my-topic", protocol="lambda", endpoint="func-a")
        await provider.subscribe(topic_name="other-topic", protocol="lambda", endpoint="func-b")

        resp = await client.post(
            "/",
            data={"Action": "ListSubscriptionsByTopic", "TopicArn": TOPIC_ARN},
        )

        assert resp.status_code == 200
        assert "func-a" in resp.text
        assert "func-b" not in resp.text
