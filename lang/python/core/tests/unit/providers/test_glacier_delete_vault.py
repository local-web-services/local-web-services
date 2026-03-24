"""Tests for Glacier DeleteVault route."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.glacier.routes import create_glacier_app


@pytest.fixture()
def client() -> TestClient:
    app, _ = create_glacier_app()
    return TestClient(app)


class TestDeleteVault:
    def test_delete_vault_returns_204(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 204
        vault_name = "delete-vault"
        client.put(f"/-/vaults/{vault_name}")

        # Act
        response = client.delete(f"/-/vaults/{vault_name}")

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"

    def test_delete_vault_not_found_returns_404(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 404
        expected_error_type = "ResourceNotFoundException"

        # Act
        response = client.delete("/-/vaults/nonexistent-vault")

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = response.json()
        actual_error_type = body["__type"]
        assert (
            actual_error_type == expected_error_type
        ), f"Expected {expected_error_type!r} but got {actual_error_type!r}"

    def test_delete_vault_removes_vault(self, client: TestClient) -> None:
        # Arrange
        vault_name = "remove-vault"
        expected_describe_status = 404
        client.put(f"/-/vaults/{vault_name}")

        # Act
        client.delete(f"/-/vaults/{vault_name}")

        # Assert
        describe_response = client.get(f"/-/vaults/{vault_name}")
        actual_describe_status = describe_response.status_code
        assert (
            actual_describe_status == expected_describe_status
        ), f"Expected {expected_describe_status!r} but got {actual_describe_status!r}"
