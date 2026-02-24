"""Integration test for SQS ChangeMessageVisibilityBatch."""

from __future__ import annotations

import httpx


class TestChangeMessageVisibilityBatch:
    async def test_change_message_visibility_batch(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        queue_url = "http://testserver/000000000000/test-queue"

        await client.post(
            "/",
            data={
                "Action": "SendMessage",
                "QueueUrl": queue_url,
                "MessageBody": "vis-batch-test",
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
                "Action": "ChangeMessageVisibilityBatch",
                "QueueUrl": queue_url,
                "ChangeMessageVisibilityBatchRequestEntry.1.Id": "msg1",
                "ChangeMessageVisibilityBatchRequestEntry.1.ReceiptHandle": receipt_handle,
                "ChangeMessageVisibilityBatchRequestEntry.1.VisibilityTimeout": "60",
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
