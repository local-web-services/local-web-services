"""Unit tests for PUT /_ldk/chaos/{service} management endpoint."""

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
    }


@pytest.fixture
def client():
    orchestrator = Orchestrator()
    chaos_configs = _make_chaos_configs()
    router = create_management_router(orchestrator=orchestrator, chaos_configs=chaos_configs)
    fast_app = FastAPI()
    fast_app.include_router(router)
    return TestClient(fast_app)


class TestManagementChaosPutService:
    """Tests for PUT /_ldk/chaos/{service}."""

    def test_put_returns_200_for_known_service(self, client):
        # Arrange
        expected_status_code = 200

        # Act
        resp = client.put("/_ldk/chaos/dynamodb", json={"error_rate": 0.8})

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code

    def test_put_enables_chaos_automatically(self, client):
        # Arrange
        expected_enabled = True

        # Act
        resp = client.put("/_ldk/chaos/dynamodb", json={"error_rate": 0.8})

        # Assert
        actual_enabled = resp.json()["enabled"]
        assert actual_enabled == expected_enabled

    def test_put_updates_error_rate(self, client):
        # Arrange
        expected_error_rate = 0.8

        # Act
        resp = client.put("/_ldk/chaos/dynamodb", json={"error_rate": 0.8})

        # Assert
        actual_error_rate = resp.json()["error_rate"]
        assert actual_error_rate == expected_error_rate

    def test_put_updates_latency(self, client):
        # Arrange
        expected_latency_min = 100

        # Act
        resp = client.put(
            "/_ldk/chaos/dynamodb", json={"latency_min_ms": 100, "latency_max_ms": 200}
        )

        # Assert
        actual_latency_min = resp.json()["latency_min_ms"]
        assert actual_latency_min == expected_latency_min

    def test_put_returns_404_for_unknown_service(self, client):
        # Arrange
        expected_status_code = 404

        # Act
        resp = client.put("/_ldk/chaos/unknown-service", json={"error_rate": 1.0})

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
