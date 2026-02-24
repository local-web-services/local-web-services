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

        entries = [
            {
                "Id": f"entry{i}",
                "ReceiptHandle": msg["ReceiptHandle"],
                "VisibilityTimeout": 0,
            }
            for i, msg in enumerate(messages)
        ]

        # Act
        resp = await client.post(
            "/",
            json={"QueueUrl": _QUEUE_URL, "Entries": entries},
            headers=_headers("ChangeMessageVisibilityBatch"),
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
    async def test_change_message_visibility_batch_nonexistent_queue(
        self,
        client: httpx.AsyncClient,
    ) -> None:
        # Arrange
        expected_status_code = 400

        # Act
        resp = await client.post(
            "/",
            json={
                "QueueUrl": "http://localhost:4566/000000000000/nonexistent",
                "Entries": [{"Id": "e1", "ReceiptHandle": "fake", "VisibilityTimeout": 0}],
            },
            headers=_headers("ChangeMessageVisibilityBatch"),
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
        data = resp.json()
        assert "NonExistentQueue" in data["__type"]

    @pytest.mark.asyncio
    async def test_change_message_visibility_batch_invalid_handle(
        self,
        client: httpx.AsyncClient,
        provider: SqsProvider,
    ) -> None:
        # Arrange
        expected_status_code = 200
        expected_successful_count = 0
        expected_failed_count = 1
        expected_failed_id = "e1"
        expected_failed_code = "ReceiptHandleIsInvalid"

        await provider.create_queue("test-queue")

        # Act
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

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
        data = resp.json()
        actual_successful_count = len(data["Successful"])
        actual_failed_count = len(data["Failed"])
        actual_failed_id = data["Failed"][0]["Id"]
        actual_failed_code = data["Failed"][0]["Code"]
        assert actual_successful_count == expected_successful_count
        assert actual_failed_count == expected_failed_count
        assert actual_failed_id == expected_failed_id
        assert actual_failed_code == expected_failed_code
