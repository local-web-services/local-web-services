"""Integration test for Glacier CreateVault."""

from __future__ import annotations

import httpx


class TestCreateVault:
    async def test_create_vault_returns_201(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 201
        vault_name = "test-vault"

        # Act
        response = await client.put(f"/-/vaults/{vault_name}")

        # Assert
        actual_status_code = response.status_code
        assert actual_status_code == expected_status_code

    async def test_create_vault_idempotent(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 201
        vault_name = "idempotent-vault"
        await client.put(f"/-/vaults/{vault_name}")

        # Act
        response = await client.put(f"/-/vaults/{vault_name}")

        # Assert
        actual_status_code = response.status_code
        assert actual_status_code == expected_status_code

    async def test_create_vault_location_header(self, client: httpx.AsyncClient):
        # Arrange
        vault_name = "location-vault"
        expected_location_suffix = f"/vaults/{vault_name}"

        # Act
        response = await client.put(f"/-/vaults/{vault_name}")

        # Assert
        actual_location = response.headers["location"]
        assert actual_location.endswith(expected_location_suffix)
