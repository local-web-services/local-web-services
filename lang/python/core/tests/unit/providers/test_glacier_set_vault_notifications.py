"""Tests for Glacier set vault notifications route."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.glacier.routes import create_glacier_app


@pytest.fixture()
def client() -> TestClient:
    app, _ = create_glacier_app()
    return TestClient(app)


class TestSetVaultNotifications:
    def test_set_vault_notifications_returns_204(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 204
        vault_name = "notif-vault"
        client.put(f"/-/vaults/{vault_name}")
        notification_config = {
            "SNSTopic": "arn:aws:sns:us-east-1:000000000000:test-topic",
            "Events": ["ArchiveRetrievalCompleted"],
        }

        # Act
        response = client.put(
            f"/-/vaults/{vault_name}/notification-configuration",
            content=json.dumps(notification_config),
        )

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"

    def test_set_vault_notifications_vault_not_found(self, client: TestClient) -> None:
        # Arrange
        expected_status_code = 404

        # Act
        response = client.put(
            "/-/vaults/nonexistent/notification-configuration",
            content=json.dumps({}),
        )

        # Assert
        actual_status_code = response.status_code
        assert (
            actual_status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {actual_status_code!r}"
