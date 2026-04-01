"""Integration tests for the /_ldk/lifecycle management API endpoints."""

from __future__ import annotations

import httpx


class TestGetLifecycleReturnsAllServices:
    async def test_get_lifecycle_returns_all_services(
        self, client: httpx.AsyncClient, lifecycle_configs
    ):
        # Arrange
        expected_status_code = 200
        expected_services = set(lifecycle_configs.keys())

        # Act
        response = await client.get("/_ldk/lifecycle")

        # Assert
        assert (
            response.status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {response.status_code!r}"
        body = response.json()
        actual_services = set(body.keys())
        assert (
            actual_services == expected_services
        ), f"Expected {expected_services!r} but got {actual_services!r}"


class TestPostLifecycleUpdatesServiceConfig:
    async def test_post_lifecycle_updates_service_config(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_enabled = True
        expected_create_dwell_ms = 300
        expected_delete_dwell_ms = 150
        payload = {
            "dynamodb": {
                "enabled": expected_enabled,
                "create_dwell_ms": expected_create_dwell_ms,
                "delete_dwell_ms": expected_delete_dwell_ms,
            }
        }

        # Act
        response = await client.post("/_ldk/lifecycle", json=payload)

        # Assert
        assert (
            response.status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {response.status_code!r}"
        body = response.json()
        assert "updated" in body, f'Expected {"updated"!r} to be in {body!r}'
        actual_updated = body["updated"]
        assert "dynamodb" in actual_updated, f'Expected {"dynamodb"!r} to be in {actual_updated!r}'
        actual_cfg = body["lifecycle"]["dynamodb"]
        actual_enabled = actual_cfg["enabled"]
        actual_create_dwell_ms = actual_cfg["create_dwell_ms"]
        actual_delete_dwell_ms = actual_cfg["delete_dwell_ms"]
        assert (
            actual_enabled == expected_enabled
        ), f"Expected {expected_enabled!r} but got {actual_enabled!r}"
        assert (
            actual_create_dwell_ms == expected_create_dwell_ms
        ), f"Expected {expected_create_dwell_ms!r} but got {actual_create_dwell_ms!r}"
        assert (
            actual_delete_dwell_ms == expected_delete_dwell_ms
        ), f"Expected {expected_delete_dwell_ms!r} but got {actual_delete_dwell_ms!r}"


class TestResetClearsLifecycleConfigs:
    async def test_reset_clears_lifecycle_configs(
        self, client: httpx.AsyncClient, lifecycle_configs
    ):
        # Arrange
        setup_payload = {
            "dynamodb": {
                "enabled": True,
                "create_dwell_ms": 500,
                "delete_dwell_ms": 250,
            }
        }
        await client.post("/_ldk/lifecycle", json=setup_payload)
        expected_enabled = True
        expected_create_dwell_ms = 0
        expected_delete_dwell_ms = 0

        # Act
        reset_response = await client.post("/_ldk/reset")

        # Assert
        assert (
            reset_response.status_code == 200
        ), f"Expected {200!r} but got {reset_response.status_code!r}"
        actual_enabled = lifecycle_configs["dynamodb"].enabled
        actual_create_dwell_ms = lifecycle_configs["dynamodb"].create_dwell_ms
        actual_delete_dwell_ms = lifecycle_configs["dynamodb"].delete_dwell_ms
        assert (
            actual_enabled == expected_enabled
        ), f"Expected {expected_enabled!r} but got {actual_enabled!r}"
        assert (
            actual_create_dwell_ms == expected_create_dwell_ms
        ), f"Expected {expected_create_dwell_ms!r} but got {actual_create_dwell_ms!r}"
        assert (
            actual_delete_dwell_ms == expected_delete_dwell_ms
        ), f"Expected {expected_delete_dwell_ms!r} but got {actual_delete_dwell_ms!r}"
