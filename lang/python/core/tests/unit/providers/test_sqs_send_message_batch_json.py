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
        # Arrange
        expected_status_code = 200
        expected_successful_count = 2
        expected_failed_count = 0
        expected_ids = {"msg1", "msg2"}

        await provider.create_queue("test-queue")

        # Act
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

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
        data = resp.json()
        actual_successful_count = len(data["Successful"])
        actual_failed_count = len(data["Failed"])
        assert actual_successful_count == expected_successful_count
        assert actual_failed_count == expected_failed_count

        actual_ids = {entry["Id"] for entry in data["Successful"]}
        assert actual_ids == expected_ids
        for entry in data["Successful"]:
            assert "MessageId" in entry
            assert "MD5OfMessageBody" in entry

    @pytest.mark.asyncio
    async def test_send_message_batch_empty_entries(
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
            headers=_headers("SendMessageBatch"),
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
        data = resp.json()
        assert data["Successful"] == []
        assert data["Failed"] == []

    @pytest.mark.asyncio
    async def test_send_message_batch_messages_receivable(
        self,
        client: httpx.AsyncClient,
        provider: SqsProvider,
    ) -> None:
        # Arrange
        expected_status_code = 200
        expected_body_a = "body-a"
        expected_body_b = "body-b"

        await provider.create_queue("test-queue")

        await client.post(
            "/",
            json={
                "QueueUrl": _QUEUE_URL,
                "Entries": [
                    {"Id": "a", "MessageBody": expected_body_a},
                    {"Id": "b", "MessageBody": expected_body_b},
                ],
            },
            headers=_headers("SendMessageBatch"),
        )

        # Act
        resp = await client.post(
            "/",
            json={"QueueUrl": _QUEUE_URL, "MaxNumberOfMessages": 10},
            headers=_headers("ReceiveMessage"),
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
        data = resp.json()
        actual_bodies = {msg["Body"] for msg in data["Messages"]}
        assert expected_body_a in actual_bodies
        assert expected_body_b in actual_bodies
