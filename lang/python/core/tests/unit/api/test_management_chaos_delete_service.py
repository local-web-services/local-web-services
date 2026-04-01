"""Unit tests for DELETE /_ldk/chaos/{service} management endpoint."""

from __future__ import annotations

import pytest
from fastapi import FastAPI
from fastapi.testclient import TestClient

from lws.api.management import create_management_router
from lws.providers._shared.aws_chaos import AwsChaosConfig
from lws.runtime.orchestrator import Orchestrator


def _make_chaos_configs() -> dict[str, AwsChaosConfig]:
    return {
        "dynamodb": AwsChaosConfig(
            enabled=True, error_rate=0.9, latency_min_ms=50, latency_max_ms=100
        ),
    }


@pytest.fixture
def client():
    orchestrator = Orchestrator()
    chaos_configs = _make_chaos_configs()
    router = create_management_router(orchestrator=orchestrator, chaos_configs=chaos_configs)
    fast_app = FastAPI()
    fast_app.include_router(router)
    return TestClient(fast_app)


class TestManagementChaosDeleteService:
    """Tests for DELETE /_ldk/chaos/{service}."""

    def test_delete_returns_200_for_known_service(self, client):
        # Arrange
        expected_status_code = 200

        # Act
        resp = client.delete("/_ldk/chaos/dynamodb")

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code

    def test_delete_disables_chaos(self, client):
        # Arrange
        expected_enabled = False

        # Act
        resp = client.delete("/_ldk/chaos/dynamodb")

        # Assert
        actual_enabled = resp.json()["enabled"]
        assert actual_enabled == expected_enabled

    def test_delete_resets_error_rate_to_zero(self, client):
        # Arrange
        expected_error_rate = 0.0

        # Act
        resp = client.delete("/_ldk/chaos/dynamodb")

        # Assert
        actual_error_rate = resp.json()["error_rate"]
        assert actual_error_rate == expected_error_rate

    def test_delete_resets_latency_to_zero(self, client):
        # Arrange
        expected_latency_min = 0

        # Act
        resp = client.delete("/_ldk/chaos/dynamodb")

        # Assert
        actual_latency_min = resp.json()["latency_min_ms"]
        assert actual_latency_min == expected_latency_min

    def test_delete_returns_404_for_unknown_service(self, client):
        # Arrange
        expected_status_code = 404

        # Act
        resp = client.delete("/_ldk/chaos/unknown-service")

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
