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
        assert actual_status_code == expected_status_code, (
            f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        )
        body = response.json()
        actual_vault_name = body["VaultName"]
        assert actual_vault_name == vault_name, (
            f"Expected {vault_name!r} but got {actual_vault_name!r}"
        )
        assert "VaultARN" in body, f'Expected {"VaultARN"!r} to be in {body!r}'
        assert "CreationDate" in body, f'Expected {"CreationDate"!r} to be in {body!r}'

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
        assert actual_arn.endswith(expected_arn_suffix), "Expected value to be truthy"

    def test_describe_vault_not_found_returns_404(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 404
        expected_error_type = "ResourceNotFoundException"

        # Act
        response = client.get("/-/vaults/nonexistent-vault")

        # Assert
        actual_status_code = response.status_code
        assert actual_status_code == expected_status_code, (
            f"Expected {expected_status_code!r} but got {actual_status_code!r}"
        )
        body = response.json()
        actual_error_type = body["__type"]
        assert actual_error_type == expected_error_type, (
            f"Expected {expected_error_type!r} but got {actual_error_type!r}"
        )
