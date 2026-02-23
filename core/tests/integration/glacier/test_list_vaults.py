"""Integration test for Glacier ListVaults."""

from __future__ import annotations

import httpx


class TestListVaults:
    async def test_list_vaults_empty(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_vault_count = 0

        # Act
        response = await client.get("/-/vaults")

        # Assert
        actual_status_code = response.status_code
        assert actual_status_code == expected_status_code
        body = response.json()
        actual_vault_count = len(body["VaultList"])
        assert actual_vault_count == expected_vault_count

    async def test_list_vaults_with_multiple_vaults(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_vault_count = 2
        vault_name_1 = "vault-one"
        vault_name_2 = "vault-two"
        await client.put(f"/-/vaults/{vault_name_1}")
        await client.put(f"/-/vaults/{vault_name_2}")

        # Act
        response = await client.get("/-/vaults")

        # Assert
        actual_status_code = response.status_code
        assert actual_status_code == expected_status_code
        body = response.json()
        actual_vault_count = len(body["VaultList"])
        assert actual_vault_count == expected_vault_count
        actual_names = [v["VaultName"] for v in body["VaultList"]]
        assert vault_name_1 in actual_names
        assert vault_name_2 in actual_names

    async def test_list_vaults_excludes_deleted(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_vault_count = 1
        expected_remaining_name = "kept-vault"
        deleted_name = "deleted-vault"
        await client.put(f"/-/vaults/{expected_remaining_name}")
        await client.put(f"/-/vaults/{deleted_name}")
        await client.delete(f"/-/vaults/{deleted_name}")

        # Act
        response = await client.get("/-/vaults")

        # Assert
        actual_status_code = response.status_code
        assert actual_status_code == expected_status_code
        body = response.json()
        actual_vault_count = len(body["VaultList"])
        assert actual_vault_count == expected_vault_count
        actual_name = body["VaultList"][0]["VaultName"]
        assert actual_name == expected_remaining_name
