"""Integration test for EventBridge DeleteEventBus."""

from __future__ import annotations

import httpx


class TestDeleteEventBus:
    async def test_delete_event_bus(self, client: httpx.AsyncClient):
        # Arrange
        expected_bus_name = "bus-to-delete"
        expected_create_status = 200
        expected_delete_status = 200

        create_resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.CreateEventBus"},
            json={"Name": expected_bus_name},
        )
        assert create_resp.status_code == expected_create_status

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.DeleteEventBus"},
            json={"Name": expected_bus_name},
        )

        # Assert
        assert resp.status_code == expected_delete_status
        body = resp.json()
        assert body == {}
