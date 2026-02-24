"""Integration test for SQS DeleteMessageBatch."""

from __future__ import annotations

import httpx


class TestDeleteMessageBatch:
    async def test_delete_message_batch(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        queue_url = "http://testserver/000000000000/test-queue"

        await client.post(
            "/",
            data={
                "Action": "SendMessage",
                "QueueUrl": queue_url,
                "MessageBody": "batch-delete-me",
            },
        )

        recv_resp = await client.post(
            "/",
            data={
                "Action": "ReceiveMessage",
                "QueueUrl": queue_url,
                "MaxNumberOfMessages": "1",
            },
        )
        assert "<ReceiptHandle>" in recv_resp.text

        text = recv_resp.text
        start = text.index("<ReceiptHandle>") + len("<ReceiptHandle>")
        end = text.index("</ReceiptHandle>")
        receipt_handle = text[start:end]

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "DeleteMessageBatch",
                "QueueUrl": queue_url,
                "DeleteMessageBatchRequestEntry.1.Id": "msg1",
                "DeleteMessageBatchRequestEntry.1.ReceiptHandle": receipt_handle,
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
