"""Tests for Glacier CreateVault route."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.glacier.routes import create_glacier_app


@pytest.fixture()
def client() -> TestClient:
    app = create_glacier_app()
    return TestClient(app)


class TestCreateVault:
    def test_create_vault_returns_201(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 201
        vault_name = "test-vault"

        # Act
        response = client.put(f"/-/vaults/{vault_name}")

        # Assert
        actual_status_code = response.status_code
        assert actual_status_code == expected_status_code

    def test_create_vault_returns_location_header(self, client: TestClient) -> None:
        # Arrange
        vault_name = "location-vault"
        expected_location_suffix = f"/vaults/{vault_name}"

        # Act
        response = client.put(f"/-/vaults/{vault_name}")

        # Assert
        actual_location = response.headers["location"]
        assert actual_location.endswith(expected_location_suffix)

    def test_create_vault_idempotent(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 201
        vault_name = "idempotent-vault"
        client.put(f"/-/vaults/{vault_name}")

        # Act
        response = client.put(f"/-/vaults/{vault_name}")

        # Assert
        actual_status_code = response.status_code
        assert actual_status_code == expected_status_code
