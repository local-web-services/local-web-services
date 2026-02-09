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


class TestInvokeEndpoint:
    """Tests for POST /_ldk/invoke."""

    def test_invoke_returns_payload(self, client):
        resp = client.post(
            "/_ldk/invoke",
            json={"function_name": "myFunc", "event": {"key": "value"}},
        )
        assert resp.status_code == 200
        data = resp.json()
        assert data["payload"] == {"statusCode": 200, "body": '{"id": 1}'}
        assert data["error"] is None

    def test_invoke_unknown_function_returns_404(self, client):
        resp = client.post(
            "/_ldk/invoke",
            json={"function_name": "nonexistent", "event": {}},
        )
        assert resp.status_code == 404
        data = resp.json()
        assert "error" in data
        assert "nonexistent" in data["error"]

    def test_invoke_with_empty_event(self, client):
        resp = client.post(
            "/_ldk/invoke",
            json={"function_name": "myFunc"},
        )
        assert resp.status_code == 200
        assert resp.json()["error"] is None

    def test_invoke_error_function(self, client):
        resp = client.post(
            "/_ldk/invoke",
            json={"function_name": "errorFunc", "event": {}},
        )
        assert resp.status_code == 200
        data = resp.json()
        assert data["error"] == "handler error"
