"""Integration test for SNS-to-SQS fanout across providers."""

from __future__ import annotations

import asyncio

import httpx
import pytest

from lws.providers.sns.provider import SnsProvider, TopicConfig
from lws.providers.sns.routes import create_sns_app
from lws.providers.sqs.provider import QueueConfig, SqsProvider
from lws.providers.sqs.routes import create_sqs_app

_TOPIC_ARN = "arn:aws:sns:us-east-1:123456789012:fanout-topic"
_QUEUE_ARN = "arn:aws:sqs:us-east-1:123456789012:fanout-queue"


@pytest.fixture
async def sqs_provider():
    p = SqsProvider(queues=[QueueConfig(queue_name="fanout-queue")])
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
async def sns_provider(sqs_provider):
    p = SnsProvider(topics=[TopicConfig(topic_name="fanout-topic", topic_arn=_TOPIC_ARN)])
    p.set_queue_provider(sqs_provider)
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
async def sns_client(sns_provider):
    app = create_sns_app(sns_provider)
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c


@pytest.fixture
async def sqs_client(sqs_provider):
    app = create_sqs_app(sqs_provider)
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c


class TestSnsSqsFanout:
    async def test_publish_to_topic_delivers_to_subscribed_queue(
        self,
        sns_provider: SnsProvider,
        sns_client: httpx.AsyncClient,
        sqs_client: httpx.AsyncClient,
    ):
        # Subscribe the SQS queue to the SNS topic
        await sns_client.post(
            "/",
            data={
                "Action": "Subscribe",
                "TopicArn": _TOPIC_ARN,
                "Protocol": "sqs",
                "Endpoint": _QUEUE_ARN,
            },
        )

        # Publish a message to the SNS topic
        await sns_client.post(
            "/",
            data={
                "Action": "Publish",
                "TopicArn": _TOPIC_ARN,
                "Message": "fanout-test-message",
            },
        )

        # Give async dispatch a moment to complete
        await asyncio.sleep(0.1)

        # Receive the message from SQS
        recv_resp = await sqs_client.post(
            "/",
            data={
                "Action": "ReceiveMessage",
                "QueueUrl": "http://localhost:4566/000000000000/fanout-queue",
                "MaxNumberOfMessages": "1",
            },
        )
        assert recv_resp.status_code == 200
        assert "fanout-test-message" in recv_resp.text
