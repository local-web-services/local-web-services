"""Integration test for SQS ChangeMessageVisibility."""

from __future__ import annotations

import httpx


class TestChangeMessageVisibility:
    async def test_change_message_visibility(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        queue_url = "http://testserver/000000000000/test-queue"

        await client.post(
            "/",
            data={
                "Action": "SendMessage",
                "QueueUrl": queue_url,
                "MessageBody": "vis-test",
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
                "Action": "ChangeMessageVisibility",
                "QueueUrl": queue_url,
                "ReceiptHandle": receipt_handle,
                "VisibilityTimeout": "60",
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
