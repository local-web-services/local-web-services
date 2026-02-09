"""Unit tests for the LDK management API."""

from __future__ import annotations

import pytest
from fastapi import FastAPI
from fastapi.testclient import TestClient

from lws.api.management import create_management_router
from lws.runtime.orchestrator import Orchestrator

from ._helpers import ErrorCompute, FakeCompute, FakeProvider


@pytest.fixture
def management_app():
    """Create a FastAPI app with the management router."""
    orchestrator = Orchestrator()
    orchestrator._running = True

    compute_providers = {
        "myFunc": FakeCompute("myFunc", {"statusCode": 200, "body": '{"id": 1}'}),
        "errorFunc": ErrorCompute(),
    }

    providers = {
        "lambda:myFunc": FakeProvider("lambda:myFunc"),
        "dynamodb": FakeProvider("dynamodb"),
    }
    orchestrator._providers = providers

    router = create_management_router(
        orchestrator=orchestrator,
        compute_providers=compute_providers,
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
        resp = client.get("/_ldk/status")
        assert resp.status_code == 200
        data = resp.json()
        assert data["running"] is True

    def test_status_lists_providers(self, client):
        resp = client.get("/_ldk/status")
        data = resp.json()
        assert "providers" in data
        assert len(data["providers"]) == 2

    def test_status_provider_health(self, client):
        resp = client.get("/_ldk/status")
        data = resp.json()
        for provider in data["providers"]:
            assert "name" in provider
            assert "healthy" in provider
            assert provider["healthy"] is True

    def test_status_provider_ids(self, client):
        resp = client.get("/_ldk/status")
        data = resp.json()
        ids = {p["id"] for p in data["providers"]}
        assert "lambda:myFunc" in ids
        assert "dynamodb" in ids
