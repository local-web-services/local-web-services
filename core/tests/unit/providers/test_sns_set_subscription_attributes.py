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
        # Arrange
        topic_name = "my-topic"
        attribute_name = "RawMessageDelivery"
        expected_value = "true"
        expected_status = 200
        await provider.create_topic(topic_name)
        sub_arn = await provider.subscribe(
            topic_name=topic_name, protocol="lambda", endpoint="my-func"
        )

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "SetSubscriptionAttributes",
                "SubscriptionArn": sub_arn,
                "AttributeName": attribute_name,
                "AttributeValue": expected_value,
            },
        )

        # Assert
        assert resp.status_code == expected_status
        assert "SetSubscriptionAttributesResponse" in resp.text
        actual_attrs = await provider.get_subscription_attributes(sub_arn)
        assert actual_attrs[attribute_name] == expected_value

    @pytest.mark.asyncio
    async def test_set_subscription_attributes_not_found(
        self,
        client: httpx.AsyncClient,
    ) -> None:
        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "SetSubscriptionAttributes",
                "SubscriptionArn": "arn:aws:sns:us-east-1:000000000000:my-topic:nonexistent",
                "AttributeName": "RawMessageDelivery",
                "AttributeValue": "true",
            },
        )

        # Assert
        expected_status = 404
        assert resp.status_code == expected_status
        assert "NotFound" in resp.text
