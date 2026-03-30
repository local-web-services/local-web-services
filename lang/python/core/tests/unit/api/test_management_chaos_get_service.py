"""Unit tests for GET /_ldk/chaos/{service} management endpoint."""

from __future__ import annotations

import pytest
from fastapi import FastAPI
from fastapi.testclient import TestClient

from lws.api.management import create_management_router
from lws.providers._shared.aws_chaos import AwsChaosConfig
from lws.runtime.orchestrator import Orchestrator


def _make_chaos_configs() -> dict[str, AwsChaosConfig]:
    return {
        "dynamodb": AwsChaosConfig(enabled=False, error_rate=0.0),
        "sqs": AwsChaosConfig(enabled=True, error_rate=0.5),
    }


@pytest.fixture
def client():
    orchestrator = Orchestrator()
    chaos_configs = _make_chaos_configs()
    router = create_management_router(orchestrator=orchestrator, chaos_configs=chaos_configs)
    fast_app = FastAPI()
    fast_app.include_router(router)
    return TestClient(fast_app)


class TestManagementChaosGetService:
    """Tests for GET /_ldk/chaos/{service}."""

    def test_get_returns_200_for_known_service(self, client):
        # Arrange
        expected_status_code = 200

        # Act
        resp = client.get("/_ldk/chaos/dynamodb")

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code

    def test_get_returns_enabled_false_for_disabled_service(self, client):
        # Arrange
        expected_enabled = False

        # Act
        resp = client.get("/_ldk/chaos/dynamodb")

        # Assert
        actual_enabled = resp.json()["enabled"]
        assert actual_enabled == expected_enabled

    def test_get_returns_enabled_true_for_enabled_service(self, client):
        # Arrange
        expected_enabled = True

        # Act
        resp = client.get("/_ldk/chaos/sqs")

        # Assert
        actual_enabled = resp.json()["enabled"]
        assert actual_enabled == expected_enabled

    def test_get_returns_error_rate_for_service(self, client):
        # Arrange
        expected_error_rate = 0.5

        # Act
        resp = client.get("/_ldk/chaos/sqs")

        # Assert
        actual_error_rate = resp.json()["error_rate"]
        assert actual_error_rate == expected_error_rate

    def test_get_returns_404_for_unknown_service(self, client):
        # Arrange
        expected_status_code = 404

        # Act
        resp = client.get("/_ldk/chaos/unknown-service")

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code

    def test_get_returns_error_message_for_unknown_service(self, client):
        # Arrange
        expected_key = "error"

        # Act
        resp = client.get("/_ldk/chaos/unknown-service")

        # Assert
        actual_keys = resp.json().keys()
        assert expected_key in actual_keys
