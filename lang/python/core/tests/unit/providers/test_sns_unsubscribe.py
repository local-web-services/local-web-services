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
        # Arrange
        topic_name = "my-topic"
        expected_status = 200
        expected_subscriber_count = 0
        await provider.create_topic(topic_name)
        sub_arn = await provider.subscribe(
            topic_name=topic_name, protocol="lambda", endpoint="my-func"
        )

        # Act
        resp = await client.post("/", data={"Action": "Unsubscribe", "SubscriptionArn": sub_arn})

        # Assert
        assert resp.status_code == expected_status, (
            f"Expected {expected_status!r} but got {resp.status_code!r}"
        )
        assert "UnsubscribeResponse" in resp.text, (
            f'Expected {"UnsubscribeResponse"!r} to be in {resp.text!r}'
        )
        actual_topic = provider.get_topic(topic_name)
        assert len(actual_topic.subscribers) == expected_subscriber_count, (
            f"Expected {expected_subscriber_count!r} but got {len(actual_topic.subscribers)!r}"
        )

    @pytest.mark.asyncio
    async def test_unsubscribe_not_found(
        self,
        client: httpx.AsyncClient,
    ) -> None:
        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "Unsubscribe",
                "SubscriptionArn": "arn:aws:sns:us-east-1:000000000000:my-topic:nonexistent",
            },
        )

        # Assert
        expected_status = 404
        assert resp.status_code == expected_status, (
            f"Expected {expected_status!r} but got {resp.status_code!r}"
        )
        assert "NotFound" in resp.text, f'Expected {"NotFound"!r} to be in {resp.text!r}'

    @pytest.mark.asyncio
    async def test_unsubscribe_removes_only_target(
        self,
        client: httpx.AsyncClient,
        provider: SnsProvider,
    ) -> None:
        """Unsubscribing one subscription should not affect others."""
        # Arrange
        topic_name = "my-topic"
        expected_status = 200
        expected_remaining_count = 1
        await provider.create_topic(topic_name)
        sub_arn_1 = await provider.subscribe(
            topic_name=topic_name, protocol="lambda", endpoint="func-a"
        )
        sub_arn_2 = await provider.subscribe(
            topic_name=topic_name, protocol="lambda", endpoint="func-b"
        )

        # Act
        resp = await client.post("/", data={"Action": "Unsubscribe", "SubscriptionArn": sub_arn_1})

        # Assert
        assert resp.status_code == expected_status, (
            f"Expected {expected_status!r} but got {resp.status_code!r}"
        )
        actual_topic = provider.get_topic(topic_name)
        assert len(actual_topic.subscribers) == expected_remaining_count, (
            f"Expected {expected_remaining_count!r} but got {len(actual_topic.subscribers)!r}"
        )
        assert actual_topic.subscribers[0].subscription_arn == sub_arn_2, (
            f"Expected {sub_arn_2!r} but got {actual_topic.subscribers[0].subscription_arn!r}"
        )
