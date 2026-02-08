"""Integration tests for the SQS HTTP wire protocol."""

from __future__ import annotations

import httpx
import pytest

from ldk.providers.sqs.provider import QueueConfig, SqsProvider
from ldk.providers.sqs.routes import create_sqs_app


@pytest.fixture
async def provider():
    p = SqsProvider(queues=[QueueConfig(queue_name="test-queue")])
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def app(provider):
    return create_sqs_app(provider)


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c


class TestSqsHttpOperations:
    async def test_send_and_receive_message(self, client: httpx.AsyncClient):
        send_resp = await client.post(
            "/",
            data={
                "Action": "SendMessage",
                "QueueUrl": "http://localhost:4566/000000000000/test-queue",
                "MessageBody": "hello world",
            },
        )
        assert send_resp.status_code == 200
        assert "<MessageId>" in send_resp.text

        recv_resp = await client.post(
            "/",
            data={
                "Action": "ReceiveMessage",
                "QueueUrl": "http://localhost:4566/000000000000/test-queue",
                "MaxNumberOfMessages": "1",
            },
        )
        assert recv_resp.status_code == 200
        assert "<Body>hello world</Body>" in recv_resp.text

    async def test_delete_message(self, client: httpx.AsyncClient):
        await client.post(
            "/",
            data={
                "Action": "SendMessage",
                "QueueUrl": "http://localhost:4566/000000000000/test-queue",
                "MessageBody": "to-delete",
            },
        )

        recv_resp = await client.post(
            "/",
            data={
                "Action": "ReceiveMessage",
                "QueueUrl": "http://localhost:4566/000000000000/test-queue",
                "MaxNumberOfMessages": "1",
            },
        )
        assert "<ReceiptHandle>" in recv_resp.text

        # Extract receipt handle from XML
        text = recv_resp.text
        start = text.index("<ReceiptHandle>") + len("<ReceiptHandle>")
        end = text.index("</ReceiptHandle>")
        receipt_handle = text[start:end]

        del_resp = await client.post(
            "/",
            data={
                "Action": "DeleteMessage",
                "QueueUrl": "http://localhost:4566/000000000000/test-queue",
                "ReceiptHandle": receipt_handle,
            },
        )
        assert del_resp.status_code == 200

        recv_resp2 = await client.post(
            "/",
            data={
                "Action": "ReceiveMessage",
                "QueueUrl": "http://localhost:4566/000000000000/test-queue",
                "MaxNumberOfMessages": "1",
            },
        )
        assert "<Message>" not in recv_resp2.text

    async def test_get_queue_url(self, client: httpx.AsyncClient):
        resp = await client.post(
            "/",
            data={"Action": "GetQueueUrl", "QueueName": "test-queue"},
        )
        assert resp.status_code == 200
        assert "<QueueUrl>" in resp.text
        assert "test-queue" in resp.text

    async def test_receive_empty_queue(self, client: httpx.AsyncClient):
        resp = await client.post(
            "/",
            data={
                "Action": "ReceiveMessage",
                "QueueUrl": "http://localhost:4566/000000000000/test-queue",
                "MaxNumberOfMessages": "1",
            },
        )
        assert resp.status_code == 200
        assert "<Message>" not in resp.text
