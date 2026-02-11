"""Tests for SQS SendMessageBatch (JSON protocol)."""

from __future__ import annotations

import httpx
import pytest

from lws.providers.sqs.provider import SqsProvider
from lws.providers.sqs.routes import create_sqs_app


@pytest.fixture
async def provider():
    p = SqsProvider()
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def client(provider: SqsProvider) -> httpx.AsyncClient:
    app = create_sqs_app(provider)
    transport = httpx.ASGITransport(app=app)
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


_QUEUE_URL = "http://localhost:4566/000000000000/test-queue"
_JSON_HEADERS = {"X-Amz-Target": "AmazonSQS.{action}"}


def _headers(action: str) -> dict[str, str]:
    return {"X-Amz-Target": f"AmazonSQS.{action}"}


class TestSendMessageBatchJson:
    @pytest.mark.asyncio
    async def test_send_message_batch_success(
        self,
        client: httpx.AsyncClient,
        provider: SqsProvider,
    ) -> None:
        await provider.create_queue("test-queue")

        resp = await client.post(
            "/",
            json={
                "QueueUrl": _QUEUE_URL,
                "Entries": [
                    {"Id": "msg1", "MessageBody": "hello"},
                    {"Id": "msg2", "MessageBody": "world", "DelaySeconds": 0},
                ],
            },
            headers=_headers("SendMessageBatch"),
        )

        assert resp.status_code == 200
        data = resp.json()
        assert len(data["Successful"]) == 2
        assert len(data["Failed"]) == 0

        # Verify each entry has the expected fields
        ids = {entry["Id"] for entry in data["Successful"]}
        assert ids == {"msg1", "msg2"}
        for entry in data["Successful"]:
            assert "MessageId" in entry
            assert "MD5OfMessageBody" in entry

    @pytest.mark.asyncio
    async def test_send_message_batch_empty_entries(
        self,
        client: httpx.AsyncClient,
        provider: SqsProvider,
    ) -> None:
        await provider.create_queue("test-queue")

        resp = await client.post(
            "/",
            json={"QueueUrl": _QUEUE_URL, "Entries": []},
            headers=_headers("SendMessageBatch"),
        )

        assert resp.status_code == 200
        data = resp.json()
        assert data["Successful"] == []
        assert data["Failed"] == []

    @pytest.mark.asyncio
    async def test_send_message_batch_messages_receivable(
        self,
        client: httpx.AsyncClient,
        provider: SqsProvider,
    ) -> None:
        await provider.create_queue("test-queue")

        await client.post(
            "/",
            json={
                "QueueUrl": _QUEUE_URL,
                "Entries": [
                    {"Id": "a", "MessageBody": "body-a"},
                    {"Id": "b", "MessageBody": "body-b"},
                ],
            },
            headers=_headers("SendMessageBatch"),
        )

        # Receive the messages to verify they were actually enqueued
        resp = await client.post(
            "/",
            json={"QueueUrl": _QUEUE_URL, "MaxNumberOfMessages": 10},
            headers=_headers("ReceiveMessage"),
        )
        assert resp.status_code == 200
        data = resp.json()
        bodies = {msg["Body"] for msg in data["Messages"]}
        assert "body-a" in bodies
        assert "body-b" in bodies
