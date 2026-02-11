"""Integration test for SQS CreateQueue."""

from __future__ import annotations

import httpx


class TestCreateQueue:
    async def test_create_queue(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_queue_name = "new-integration-queue"
        expected_queue_url_fragment = f"/{expected_queue_name}"

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "CreateQueue",
                "QueueName": expected_queue_name,
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
        assert "<QueueUrl>" in resp.text
        assert expected_queue_url_fragment in resp.text
