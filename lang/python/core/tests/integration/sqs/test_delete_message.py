"""Integration test for SQS DeleteMessage."""

from __future__ import annotations

import httpx


class TestDeleteMessage:
    async def test_delete_message(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        queue_url = "http://localhost:4566/000000000000/test-queue"

        await client.post(
            "/",
            data={
                "Action": "SendMessage",
                "QueueUrl": queue_url,
                "MessageBody": "to-delete",
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

        # Extract receipt handle from XML
        text = recv_resp.text
        start = text.index("<ReceiptHandle>") + len("<ReceiptHandle>")
        end = text.index("</ReceiptHandle>")
        receipt_handle = text[start:end]

        # Act
        del_resp = await client.post(
            "/",
            data={
                "Action": "DeleteMessage",
                "QueueUrl": queue_url,
                "ReceiptHandle": receipt_handle,
            },
        )

        # Assert
        assert del_resp.status_code == expected_status_code

        recv_resp2 = await client.post(
            "/",
            data={
                "Action": "ReceiveMessage",
                "QueueUrl": queue_url,
                "MaxNumberOfMessages": "1",
            },
        )
        assert "<Message>" not in recv_resp2.text
