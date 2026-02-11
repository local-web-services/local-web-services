"""Integration test for SQS PurgeQueue."""

from __future__ import annotations

import httpx


class TestPurgeQueue:
    async def test_purge_queue(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_queue_name = "test-queue"
        queue_url = f"http://localhost:4566/000000000000/{expected_queue_name}"

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "PurgeQueue",
                "QueueUrl": queue_url,
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
