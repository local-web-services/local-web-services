"""Integration test for SQS ListDeadLetterSourceQueues."""

from __future__ import annotations

import httpx


class TestListDeadLetterSourceQueues:
    async def test_list_dead_letter_source_queues(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        queue_url = "http://testserver/000000000000/test-queue"

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "ListDeadLetterSourceQueues",
                "QueueUrl": queue_url,
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
