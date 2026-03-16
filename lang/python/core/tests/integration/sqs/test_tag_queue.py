"""Integration test for SQS TagQueue."""

from __future__ import annotations

import httpx


class TestTagQueue:
    async def test_tag_queue(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        queue_url = "http://testserver/000000000000/test-queue"

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "TagQueue",
                "QueueUrl": queue_url,
                "Tag.1.Key": "env",
                "Tag.1.Value": "test",
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
