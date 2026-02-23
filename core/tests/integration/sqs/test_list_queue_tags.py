"""Integration test for SQS ListQueueTags."""

from __future__ import annotations

import httpx


class TestListQueueTags:
    async def test_list_queue_tags(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        queue_url = "http://testserver/000000000000/test-queue"

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "ListQueueTags",
                "QueueUrl": queue_url,
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
