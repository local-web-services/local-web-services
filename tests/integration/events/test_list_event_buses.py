"""Integration test for EventBridge ListEventBuses."""

from __future__ import annotations

import httpx


class TestListEventBuses:
    async def test_list_event_buses(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_bus_name = "default"

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.ListEventBuses"},
            json={},
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        actual_bus_names = [b["Name"] for b in body["EventBuses"]]
        assert expected_bus_name in actual_bus_names
