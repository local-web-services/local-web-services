"""Integration test for SQS SendMessageBatch."""

from __future__ import annotations

import httpx


class TestSendMessageBatch:
    async def test_send_message_batch(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        queue_url = "http://testserver/000000000000/test-queue"

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "SendMessageBatch",
                "QueueUrl": queue_url,
                "SendMessageBatchRequestEntry.1.Id": "msg1",
                "SendMessageBatchRequestEntry.1.MessageBody": "hello batch",
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
