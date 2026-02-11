"""Tests for SQS ChangeMessageVisibilityBatch (JSON protocol)."""

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


class TestChangeMessageVisibilityBatchJson:
    @pytest.mark.asyncio
    async def test_change_message_visibility_batch_success(
        self,
        client: httpx.AsyncClient,
        provider: SqsProvider,
    ) -> None:
        await provider.create_queue("test-queue")
        await provider.send_message("test-queue", "msg1")
        await provider.send_message("test-queue", "msg2")

        # Receive messages
        recv_resp = await client.post(
            "/",
            json={"QueueUrl": _QUEUE_URL, "MaxNumberOfMessages": 10},
            headers=_headers("ReceiveMessage"),
        )
        messages = recv_resp.json()["Messages"]

        entries = [
            {
                "Id": f"entry{i}",
                "ReceiptHandle": msg["ReceiptHandle"],
                "VisibilityTimeout": 0,
            }
            for i, msg in enumerate(messages)
        ]

        resp = await client.post(
            "/",
            json={"QueueUrl": _QUEUE_URL, "Entries": entries},
            headers=_headers("ChangeMessageVisibilityBatch"),
        )

        assert resp.status_code == 200
        data = resp.json()
        assert len(data["Successful"]) == 2
        assert len(data["Failed"]) == 0

    @pytest.mark.asyncio
    async def test_change_message_visibility_batch_nonexistent_queue(
        self,
        client: httpx.AsyncClient,
    ) -> None:
        resp = await client.post(
            "/",
            json={
                "QueueUrl": "http://localhost:4566/000000000000/nonexistent",
                "Entries": [{"Id": "e1", "ReceiptHandle": "fake", "VisibilityTimeout": 0}],
            },
            headers=_headers("ChangeMessageVisibilityBatch"),
        )

        assert resp.status_code == 400
        data = resp.json()
        assert "NonExistentQueue" in data["__type"]

    @pytest.mark.asyncio
    async def test_change_message_visibility_batch_invalid_handle(
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
                    {"Id": "e1", "ReceiptHandle": "invalid-handle", "VisibilityTimeout": 0}
                ],
            },
            headers=_headers("ChangeMessageVisibilityBatch"),
        )

        assert resp.status_code == 200
        data = resp.json()
        assert len(data["Successful"]) == 0
        assert len(data["Failed"]) == 1
        assert data["Failed"][0]["Id"] == "e1"
        assert data["Failed"][0]["Code"] == "ReceiptHandleIsInvalid"
