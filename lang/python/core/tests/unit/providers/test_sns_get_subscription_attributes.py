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
        # Arrange
        topic_name = "my-topic"
        endpoint = "my-queue"
        protocol = "sqs"
        expected_status = 200
        await provider.create_topic(topic_name)
        sub_arn = await provider.subscribe(
            topic_name=topic_name, protocol=protocol, endpoint=endpoint
        )

        # Act
        resp = await client.post(
            "/",
            data={"Action": "GetSubscriptionAttributes", "SubscriptionArn": sub_arn},
        )

        # Assert
        assert resp.status_code == expected_status, (
            f"Expected {expected_status!r} but got {resp.status_code!r}"
        )
        assert "GetSubscriptionAttributesResponse" in resp.text, (
            f'Expected {"GetSubscriptionAttributesResponse"!r} to be in {resp.text!r}'
        )
        assert "<key>Protocol</key>" in resp.text, (
            f'Expected {"<key>Protocol</key>"!r} to be in {resp.text!r}'
        )
        assert f"<value>{protocol}</value>" in resp.text, (
            "Expected {!r} to be in {!r}".format(f"<value>{protocol}</value>", resp.text)
        )
        assert "<key>Endpoint</key>" in resp.text, (
            f'Expected {"<key>Endpoint</key>"!r} to be in {resp.text!r}'
        )
        assert f"<value>{endpoint}</value>" in resp.text, (
            "Expected {!r} to be in {!r}".format(f"<value>{endpoint}</value>", resp.text)
        )
        assert "<key>TopicArn</key>" in resp.text, (
            f'Expected {"<key>TopicArn</key>"!r} to be in {resp.text!r}'
        )
        assert TOPIC_ARN in resp.text, f"Expected {TOPIC_ARN!r} to be in {resp.text!r}"
        assert "<key>SubscriptionArn</key>" in resp.text, (
            f'Expected {"<key>SubscriptionArn</key>"!r} to be in {resp.text!r}'
        )
        assert sub_arn in resp.text, f"Expected {sub_arn!r} to be in {resp.text!r}"

    @pytest.mark.asyncio
    async def test_get_subscription_attributes_not_found(
        self,
        client: httpx.AsyncClient,
    ) -> None:
        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "GetSubscriptionAttributes",
                "SubscriptionArn": "arn:aws:sns:us-east-1:000000000000:my-topic:nonexistent",
            },
        )

        # Assert
        expected_status = 404
        assert resp.status_code == expected_status, (
            f"Expected {expected_status!r} but got {resp.status_code!r}"
        )
        assert "NotFound" in resp.text, f'Expected {"NotFound"!r} to be in {resp.text!r}'
