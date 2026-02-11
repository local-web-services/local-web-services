"""Integration test for EventBridge CreateEventBus."""

from __future__ import annotations

import httpx


class TestCreateEventBus:
    async def test_create_event_bus(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_bus_name = "my-custom-bus"

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.CreateEventBus"},
            json={"Name": expected_bus_name},
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        assert "EventBusArn" in body
        assert expected_bus_name in body["EventBusArn"]
