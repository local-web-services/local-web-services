"""Integration test for SQS ListQueues."""

from __future__ import annotations

import httpx


class TestListQueues:
    async def test_list_queues(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_queue_name = "test-queue"

        # Act
        resp = await client.post(
            "/",
            data={"Action": "ListQueues"},
        )

        # Assert
        assert resp.status_code == expected_status_code
        assert expected_queue_name in resp.text
