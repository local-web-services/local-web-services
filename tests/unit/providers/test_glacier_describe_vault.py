"""Tests for Glacier DescribeVault route."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.glacier.routes import create_glacier_app


@pytest.fixture()
def client() -> TestClient:
    app = create_glacier_app()
    return TestClient(app)


class TestDescribeVault:
    def test_describe_vault_returns_vault_info(self, client: TestClient) -> None:
        # Arrange
        vault_name = "describe-vault"
        expected_status_code = 200
        client.put(f"/-/vaults/{vault_name}")

        # Act
        response = client.get(f"/-/vaults/{vault_name}")

        # Assert
        actual_status_code = response.status_code
        assert actual_status_code == expected_status_code
        body = response.json()
        actual_vault_name = body["VaultName"]
        assert actual_vault_name == vault_name
        assert "VaultARN" in body
        assert "CreationDate" in body

    def test_describe_vault_contains_arn(self, client: TestClient) -> None:
        # Arrange
        vault_name = "arn-vault"
        expected_arn_suffix = f"vaults/{vault_name}"
        client.put(f"/-/vaults/{vault_name}")

        # Act
        response = client.get(f"/-/vaults/{vault_name}")

        # Assert
        body = response.json()
        actual_arn = body["VaultARN"]
        assert actual_arn.endswith(expected_arn_suffix)

    def test_describe_vault_not_found_returns_404(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 404
        expected_error_type = "ResourceNotFoundException"

        # Act
        response = client.get("/-/vaults/nonexistent-vault")

        # Assert
        actual_status_code = response.status_code
        assert actual_status_code == expected_status_code
        body = response.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type
