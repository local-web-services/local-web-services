"""Tests for Glacier delete vault notifications route."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.glacier.routes import create_glacier_app


@pytest.fixture()
def client() -> TestClient:
    app, _ = create_glacier_app()
    return TestClient(app)


class TestDeleteVaultNotifications:
    def test_delete_vault_notifications_returns_204(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 204
        vault_name = "del-notif-vault"
        client.put(f"/-/vaults/{vault_name}")
        client.put(
            f"/-/vaults/{vault_name}/notification-configuration",
            content=json.dumps({"SNSTopic": "arn:aws:sns:us-east-1:000000000000:topic"}),
        )

        # Act
        response = client.delete(f"/-/vaults/{vault_name}/notification-configuration")

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
