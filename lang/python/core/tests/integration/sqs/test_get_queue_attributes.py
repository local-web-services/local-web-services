"""Integration test for SQS GetQueueUrl."""

from __future__ import annotations

import httpx


class TestGetQueueAttributes:
    async def test_get_queue_url(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_queue_name = "test-queue"

        # Act
        resp = await client.post(
            "/",
            data={"Action": "GetQueueUrl", "QueueName": expected_queue_name},
        )

        # Assert
        assert resp.status_code == expected_status_code
        actual_text = resp.text
        assert "<QueueUrl>" in actual_text
        assert expected_queue_name in actual_text
