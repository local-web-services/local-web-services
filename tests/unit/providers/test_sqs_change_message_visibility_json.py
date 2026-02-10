"""Tests for SQS ChangeMessageVisibility (JSON protocol)."""

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


class TestChangeMessageVisibilityJson:
    @pytest.mark.asyncio
    async def test_change_message_visibility_success(
        self,
        client: httpx.AsyncClient,
        provider: SqsProvider,
    ) -> None:
        await provider.create_queue("test-queue")
        await provider.send_message("test-queue", "hello")

        # Receive to get receipt handle
        recv_resp = await client.post(
            "/",
            json={"QueueUrl": _QUEUE_URL, "MaxNumberOfMessages": 1},
            headers=_headers("ReceiveMessage"),
        )
        messages = recv_resp.json()["Messages"]
        receipt_handle = messages[0]["ReceiptHandle"]

        resp = await client.post(
            "/",
            json={
                "QueueUrl": _QUEUE_URL,
                "ReceiptHandle": receipt_handle,
                "VisibilityTimeout": 0,
            },
            headers=_headers("ChangeMessageVisibility"),
        )

        assert resp.status_code == 200

    @pytest.mark.asyncio
    async def test_change_message_visibility_nonexistent_queue(
        self,
        client: httpx.AsyncClient,
    ) -> None:
        resp = await client.post(
            "/",
            json={
                "QueueUrl": "http://localhost:4566/000000000000/nonexistent",
                "ReceiptHandle": "fake-handle",
                "VisibilityTimeout": 30,
            },
            headers=_headers("ChangeMessageVisibility"),
        )

        assert resp.status_code == 400
        data = resp.json()
        assert "NonExistentQueue" in data["__type"]

    @pytest.mark.asyncio
    async def test_change_visibility_makes_message_visible(
        self,
        client: httpx.AsyncClient,
        provider: SqsProvider,
    ) -> None:
        await provider.create_queue("test-queue")
        await provider.send_message("test-queue", "hello")

        # Receive message (makes it invisible)
        recv_resp = await client.post(
            "/",
            json={"QueueUrl": _QUEUE_URL, "MaxNumberOfMessages": 1},
            headers=_headers("ReceiveMessage"),
        )
        messages = recv_resp.json()["Messages"]
        receipt_handle = messages[0]["ReceiptHandle"]

        # Try to receive again -- should be empty (message is invisible)
        recv_resp2 = await client.post(
            "/",
            json={"QueueUrl": _QUEUE_URL, "MaxNumberOfMessages": 1},
            headers=_headers("ReceiveMessage"),
        )
        assert recv_resp2.json()["Messages"] == []

        # Set visibility timeout to 0 to make the message visible immediately
        await client.post(
            "/",
            json={
                "QueueUrl": _QUEUE_URL,
                "ReceiptHandle": receipt_handle,
                "VisibilityTimeout": 0,
            },
            headers=_headers("ChangeMessageVisibility"),
        )

        # Now the message should be receivable again
        recv_resp3 = await client.post(
            "/",
            json={"QueueUrl": _QUEUE_URL, "MaxNumberOfMessages": 1},
            headers=_headers("ReceiveMessage"),
        )
        assert len(recv_resp3.json()["Messages"]) == 1
