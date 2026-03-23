"""Tests for Glacier ListVaults route."""

from __future__ import annotations

import pytest
from fastapi.testclient import TestClient

from lws.providers.glacier.routes import create_glacier_app


@pytest.fixture()
def client() -> TestClient:
    app, _ = create_glacier_app()
    return TestClient(app)


class TestListVaults:
    def test_list_vaults_empty(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 200
        expected_vault_count = 0

        # Act
        response = client.get("/-/vaults")

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = response.json()
        actual_vault_count = len(body["VaultList"])
        assert (
            actual_vault_count == expected_vault_count
        ), f"Expected {expected_vault_count!r} but got {actual_vault_count!r}"

    def test_list_vaults_returns_vault_list(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 200
        expected_vault_count = 2
        vault_name_1 = "vault-alpha"
        vault_name_2 = "vault-beta"
        client.put(f"/-/vaults/{vault_name_1}")
        client.put(f"/-/vaults/{vault_name_2}")

        # Act
        response = client.get("/-/vaults")

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        body = response.json()
        actual_vault_count = len(body["VaultList"])
        assert (
            actual_vault_count == expected_vault_count
        ), f"Expected {expected_vault_count!r} but got {actual_vault_count!r}"
        actual_names = [v["VaultName"] for v in body["VaultList"]]
        assert vault_name_1 in actual_names, f"Expected {vault_name_1!r} to be in {actual_names!r}"
        assert vault_name_2 in actual_names, f"Expected {vault_name_2!r} to be in {actual_names!r}"

    def test_list_vaults_contains_vault_arn(self, client: TestClient) -> None:
        # Arrange
        vault_name = "arn-list-vault"
        expected_arn_suffix = f"vaults/{vault_name}"
        client.put(f"/-/vaults/{vault_name}")

        # Act
        response = client.get("/-/vaults")

        # Assert
        body = response.json()
        actual_arn = body["VaultList"][0]["VaultARN"]
        assert actual_arn.endswith(expected_arn_suffix), "Expected value to be truthy"
