"""Integration tests for the /_ldk/capacity management API endpoints."""

from __future__ import annotations

import httpx


class TestGetCapacityReturnsAllServices:
    async def test_get_capacity_returns_all_services(
        self, client: httpx.AsyncClient, capacity_configs
    ):
        # Arrange
        expected_status_code = 200
        expected_services = set(capacity_configs.keys())

        # Act
        response = await client.get("/_ldk/capacity")

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        actual_services = set(body.keys())
        assert actual_services == expected_services


class TestPostCapacityUpdatesServiceConfig:
    async def test_post_capacity_updates_service_config(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_slots = 0
        payload = {"stepfunctions": {"slots": expected_slots}}

        # Act
        response = await client.post("/_ldk/capacity", json=payload)

        # Assert
        assert response.status_code == expected_status_code
        body = response.json()
        assert "updated" in body
        actual_updated = body["updated"]
        assert "stepfunctions" in actual_updated
        actual_cfg = body["capacity"]["stepfunctions"]
        actual_slots = actual_cfg["slots"]
        assert actual_slots == expected_slots


class TestResetClearsCapacityConfigs:
    async def test_reset_clears_capacity_configs(self, client: httpx.AsyncClient, capacity_configs):
        # Arrange
        setup_payload = {"stepfunctions": {"slots": 0}}
        await client.post("/_ldk/capacity", json=setup_payload)
        expected_slots = None

        # Act
        reset_response = await client.post("/_ldk/reset")

        # Assert
        assert reset_response.status_code == 200
        actual_slots = capacity_configs["stepfunctions"].slots
        assert actual_slots == expected_slots
