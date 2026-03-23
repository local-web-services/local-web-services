"""Tests for Glacier CreateVault route."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.glacier.routes import create_glacier_app


@pytest.fixture()
def client() -> TestClient:
    app, _ = create_glacier_app()
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
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"

    def test_create_vault_returns_location_header(self, client: TestClient) -> None:
        # Arrange
        vault_name = "location-vault"
        expected_location_suffix = f"/vaults/{vault_name}"

        # Act
        response = client.put(f"/-/vaults/{vault_name}")

        # Assert
        actual_location = response.headers["location"]
        assert actual_location.endswith(expected_location_suffix), "Expected value to be truthy"

    def test_create_vault_duplicate_returns_409(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 409
        vault_name = "duplicate-vault"
        client.put(f"/-/vaults/{vault_name}")

        # Act
        response = client.put(f"/-/vaults/{vault_name}")

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
