"""Integration test for SQS DeleteQueue."""

from __future__ import annotations

import httpx


class TestDeleteQueue:
    async def test_delete_queue(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_queue_name = "queue-to-delete"
        queue_url = f"http://localhost:4566/000000000000/{expected_queue_name}"

        await client.post(
            "/",
            data={
                "Action": "CreateQueue",
                "QueueName": expected_queue_name,
            },
        )

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "DeleteQueue",
                "QueueUrl": queue_url,
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
