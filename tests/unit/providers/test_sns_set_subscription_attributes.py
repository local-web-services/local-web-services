"""Tests for SNS SetSubscriptionAttributes route."""

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


class TestSetSubscriptionAttributes:
    @pytest.mark.asyncio
    async def test_set_subscription_attributes_success(
        self,
        client: httpx.AsyncClient,
        provider: SnsProvider,
    ) -> None:
        await provider.create_topic("my-topic")
        sub_arn = await provider.subscribe(
            topic_name="my-topic", protocol="lambda", endpoint="my-func"
        )

        resp = await client.post(
            "/",
            data={
                "Action": "SetSubscriptionAttributes",
                "SubscriptionArn": sub_arn,
                "AttributeName": "RawMessageDelivery",
                "AttributeValue": "true",
            },
        )

        assert resp.status_code == 200
        assert "SetSubscriptionAttributesResponse" in resp.text

        # Verify the attribute was actually set by reading it back
        attrs = await provider.get_subscription_attributes(sub_arn)
        assert attrs["RawMessageDelivery"] == "true"

    @pytest.mark.asyncio
    async def test_set_subscription_attributes_not_found(
        self,
        client: httpx.AsyncClient,
    ) -> None:
        resp = await client.post(
            "/",
            data={
                "Action": "SetSubscriptionAttributes",
                "SubscriptionArn": "arn:aws:sns:us-east-1:000000000000:my-topic:nonexistent",
                "AttributeName": "RawMessageDelivery",
                "AttributeValue": "true",
            },
        )

        assert resp.status_code == 404
        assert "NotFound" in resp.text
