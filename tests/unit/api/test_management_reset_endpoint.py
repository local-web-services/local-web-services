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


class TestResetEndpoint:
    """Tests for POST /_ldk/reset."""

    def test_reset_returns_ok(self, client):
        resp = client.post("/_ldk/reset")
        assert resp.status_code == 200
        data = resp.json()
        assert data["status"] == "ok"

    def test_reset_returns_provider_count(self, client):
        resp = client.post("/_ldk/reset")
        data = resp.json()
        assert "providers_reset" in data
        # No providers have a reset() method, so count should be 0
        assert data["providers_reset"] == 0
