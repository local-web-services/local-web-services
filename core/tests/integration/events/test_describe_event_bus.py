"""Integration test for EventBridge DescribeEventBus."""

from __future__ import annotations

import httpx


class TestDescribeEventBus:
    async def test_describe_event_bus(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_bus_name = "default"

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.DescribeEventBus"},
            json={"Name": expected_bus_name},
        )

        # Assert
        assert resp.status_code == expected_status_code
