"""Tests for SNS ConfirmSubscription route."""

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


class TestConfirmSubscription:
    @pytest.mark.asyncio
    async def test_confirm_subscription_success(
        self,
        client: httpx.AsyncClient,
    ) -> None:
        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "ConfirmSubscription",
                "TopicArn": TOPIC_ARN,
                "Token": "some-confirmation-token",
            },
        )

        # Assert
        expected_status = 200
        assert resp.status_code == expected_status
        assert "ConfirmSubscriptionResponse" in resp.text
        assert "<SubscriptionArn>" in resp.text

    @pytest.mark.asyncio
    async def test_confirm_subscription_returns_subscription_arn(
        self,
        client: httpx.AsyncClient,
    ) -> None:
        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "ConfirmSubscription",
                "TopicArn": TOPIC_ARN,
                "Token": "another-token",
            },
        )

        # Assert
        expected_status = 200
        assert resp.status_code == expected_status
        assert TOPIC_ARN in resp.text
