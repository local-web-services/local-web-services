"""Integration tests for the SNS HTTP wire protocol."""

from __future__ import annotations

import httpx
import pytest

from ldk.providers.sns.provider import SnsProvider, TopicConfig
from ldk.providers.sns.routes import create_sns_app


@pytest.fixture
async def provider():
    p = SnsProvider(
        topics=[
            TopicConfig(
                topic_name="test-topic",
                topic_arn="arn:aws:sns:us-east-1:123456789012:test-topic",
            )
        ]
    )
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def app(provider):
    return create_sns_app(provider)


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c


class TestSnsHttpOperations:
    async def test_publish_message(self, client: httpx.AsyncClient):
        resp = await client.post(
            "/",
            data={
                "Action": "Publish",
                "TopicArn": "arn:aws:sns:us-east-1:123456789012:test-topic",
                "Message": "hello",
            },
        )
        assert resp.status_code == 200
        assert "<MessageId>" in resp.text

    async def test_list_topics(self, client: httpx.AsyncClient):
        resp = await client.post(
            "/",
            data={"Action": "ListTopics"},
        )
        assert resp.status_code == 200
        assert "arn:aws:sns:us-east-1:123456789012:test-topic" in resp.text

    async def test_subscribe(self, client: httpx.AsyncClient):
        resp = await client.post(
            "/",
            data={
                "Action": "Subscribe",
                "TopicArn": "arn:aws:sns:us-east-1:123456789012:test-topic",
                "Protocol": "sqs",
                "Endpoint": "arn:aws:sqs:us-east-1:123456789012:my-queue",
            },
        )
        assert resp.status_code == 200
        assert "<SubscriptionArn>" in resp.text
