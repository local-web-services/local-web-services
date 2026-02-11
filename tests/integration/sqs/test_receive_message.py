"""Integration test for SQS ReceiveMessage."""

from __future__ import annotations

import httpx


class TestReceiveMessage:
    async def test_receive_empty_queue(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        queue_url = "http://localhost:4566/000000000000/test-queue"

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "ReceiveMessage",
                "QueueUrl": queue_url,
                "MaxNumberOfMessages": "1",
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
        assert "<Message>" not in resp.text
