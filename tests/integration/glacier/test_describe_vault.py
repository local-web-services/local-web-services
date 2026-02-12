"""Integration test for Glacier DescribeVault."""

from __future__ import annotations

import httpx


class TestDescribeVault:
    async def test_describe_vault_returns_vault_info(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        vault_name = "describe-vault"
        expected_arn_suffix = f"vaults/{vault_name}"
        await client.put(f"/-/vaults/{vault_name}")

        # Act
        response = await client.get(f"/-/vaults/{vault_name}")

        # Assert
        actual_status_code = response.status_code
        assert actual_status_code == expected_status_code
        body = response.json()
        actual_vault_name = body["VaultName"]
        assert actual_vault_name == vault_name
        actual_arn = body["VaultARN"]
        assert actual_arn.endswith(expected_arn_suffix)
        assert "CreationDate" in body

    async def test_describe_vault_not_found(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 404
        expected_error_type = "ResourceNotFoundException"

        # Act
        response = await client.get("/-/vaults/nonexistent-vault")

        # Assert
        actual_status_code = response.status_code
        assert actual_status_code == expected_status_code
        body = response.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type

    async def test_describe_vault_shows_archive_count(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_archive_count = 1
        vault_name = "archive-count-vault"
        await client.put(f"/-/vaults/{vault_name}")
        await client.post(
            f"/-/vaults/{vault_name}/archives",
            content=b"archive-data",
        )

        # Act
        response = await client.get(f"/-/vaults/{vault_name}")

        # Assert
        actual_status_code = response.status_code
        assert actual_status_code == expected_status_code
        body = response.json()
        actual_archive_count = body["NumberOfArchives"]
        assert actual_archive_count == expected_archive_count
