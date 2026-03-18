"""Tests for SQS DeleteMessageBatch (JSON protocol)."""

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


class TestDeleteMessageBatchJson:
    @pytest.mark.asyncio
    async def test_delete_message_batch_success(
        self,
        client: httpx.AsyncClient,
        provider: SqsProvider,
    ) -> None:
        # Arrange
        expected_status_code = 200
        expected_successful_count = 2
        expected_failed_count = 0
        queue_name = "test-queue"

        await provider.create_queue(queue_name)
        await provider.send_message(queue_name, "msg1")
        await provider.send_message(queue_name, "msg2")

        recv_resp = await client.post(
            "/",
            json={"QueueUrl": _QUEUE_URL, "MaxNumberOfMessages": 10},
            headers=_headers("ReceiveMessage"),
        )
        messages = recv_resp.json()["Messages"]
        assert len(messages) == 2

        entries = [
            {"Id": f"del{i}", "ReceiptHandle": msg["ReceiptHandle"]}
            for i, msg in enumerate(messages)
        ]

        # Act
        resp = await client.post(
            "/",
            json={"QueueUrl": _QUEUE_URL, "Entries": entries},
            headers=_headers("DeleteMessageBatch"),
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
        data = resp.json()
        actual_successful_count = len(data["Successful"])
        actual_failed_count = len(data["Failed"])
        assert actual_successful_count == expected_successful_count
        assert actual_failed_count == expected_failed_count

    @pytest.mark.asyncio
    async def test_delete_message_batch_empty_entries(
        self,
        client: httpx.AsyncClient,
        provider: SqsProvider,
    ) -> None:
        # Arrange
        expected_status_code = 200
        await provider.create_queue("test-queue")

        # Act
        resp = await client.post(
            "/",
            json={"QueueUrl": _QUEUE_URL, "Entries": []},
            headers=_headers("DeleteMessageBatch"),
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
        data = resp.json()
        assert data["Successful"] == []
        assert data["Failed"] == []
