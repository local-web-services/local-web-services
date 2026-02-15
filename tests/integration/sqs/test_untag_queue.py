"""Integration test for SQS UntagQueue."""

from __future__ import annotations

import httpx


class TestUntagQueue:
    async def test_untag_queue(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        queue_url = "http://testserver/000000000000/test-queue"

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "UntagQueue",
                "QueueUrl": queue_url,
                "TagKey.1": "env",
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
