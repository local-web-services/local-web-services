"""Integration test for SQS SetQueueAttributes."""

from __future__ import annotations

import httpx


class TestSetQueueAttributes:
    async def test_set_queue_attributes(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        queue_url = "http://testserver/000000000000/test-queue"

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "SetQueueAttributes",
                "QueueUrl": queue_url,
                "Attribute.1.Name": "VisibilityTimeout",
                "Attribute.1.Value": "30",
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
