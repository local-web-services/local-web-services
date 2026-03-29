"""Tests for Glacier get vault notifications route."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.glacier.routes import create_glacier_app


@pytest.fixture()
def client() -> TestClient:
    app, _ = create_glacier_app()
    return TestClient(app)


class TestGetVaultNotifications:
    def test_get_vault_notifications_returns_config(self, client: TestClient) -> None:
        # Arrange
        vault_name = "get-notif-vault"
        client.put(f"/-/vaults/{vault_name}")
        expected_sns_topic = "arn:aws:sns:us-east-1:000000000000:my-topic"
        notification_config = {
            "SNSTopic": expected_sns_topic,
            "Events": ["InventoryRetrievalCompleted"],
        }
        client.put(
            f"/-/vaults/{vault_name}/notification-configuration",
            content=json.dumps(notification_config),
        )

        # Act
        response = client.get(f"/-/vaults/{vault_name}/notification-configuration")

        # Assert
        actual_sns_topic = response.json()["VaultNotificationConfig"]["SNSTopic"]
        assert (
            actual_sns_topic == expected_sns_topic
        ), f"Expected {expected_sns_topic!r} but got {actual_sns_topic!r}"

    def test_get_vault_notifications_not_configured_returns_404(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 404
        vault_name = "no-notif-vault"
        client.put(f"/-/vaults/{vault_name}")

        # Act
        response = client.get(f"/-/vaults/{vault_name}/notification-configuration")

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
