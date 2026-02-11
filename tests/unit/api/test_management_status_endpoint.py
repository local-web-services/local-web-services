"""Unit tests for the LDK management API."""

from __future__ import annotations

import pytest
from fastapi import FastAPI
from fastapi.testclient import TestClient

from lws.api.management import create_management_router
from lws.runtime.orchestrator import Orchestrator

from ._helpers import FakeProvider


@pytest.fixture
def management_app():
    """Create a FastAPI app with the management router."""
    orchestrator = Orchestrator()
    orchestrator._running = True

    providers = {
        "lambda:myFunc": FakeProvider("lambda:myFunc"),
        "dynamodb": FakeProvider("dynamodb"),
    }
    orchestrator._providers = providers

    router = create_management_router(
        orchestrator=orchestrator,
        providers=providers,
    )

    app = FastAPI()
    app.include_router(router)
    return app


@pytest.fixture
def client(management_app):
    """Create a test client for the management API."""
    return TestClient(management_app)


class TestStatusEndpoint:
    """Tests for GET /_ldk/status."""

    def test_status_returns_running(self, client):
        # Arrange
        expected_status_code = 200

        # Act
        resp = client.get("/_ldk/status")

        # Assert
        assert resp.status_code == expected_status_code
        data = resp.json()
        assert data["running"] is True

    def test_status_lists_providers(self, client):
        # Arrange
        expected_provider_count = 2

        # Act
        resp = client.get("/_ldk/status")

        # Assert
        data = resp.json()
        assert "providers" in data
        actual_provider_count = len(data["providers"])
        assert actual_provider_count == expected_provider_count

    def test_status_provider_health(self, client):
        resp = client.get("/_ldk/status")
        data = resp.json()
        for provider in data["providers"]:
            assert "name" in provider
            assert "healthy" in provider
            assert provider["healthy"] is True

    def test_status_provider_ids(self, client):
        # Arrange
        expected_lambda_id = "lambda:myFunc"
        expected_dynamodb_id = "dynamodb"

        # Act
        resp = client.get("/_ldk/status")

        # Assert
        data = resp.json()
        actual_ids = {p["id"] for p in data["providers"]}
        assert expected_lambda_id in actual_ids
        assert expected_dynamodb_id in actual_ids
