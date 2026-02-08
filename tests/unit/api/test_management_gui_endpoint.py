"""Unit tests for the GUI dashboard endpoint."""

from __future__ import annotations

import pytest
from fastapi import FastAPI
from fastapi.testclient import TestClient

from ldk.api.management import create_management_router
from ldk.runtime.orchestrator import Orchestrator

from ._helpers import FakeCompute, FakeProvider


@pytest.fixture
def management_app():
    """Create a FastAPI app with the management router."""
    orchestrator = Orchestrator()
    orchestrator._running = True
    compute_providers = {"myFunc": FakeCompute("myFunc")}
    providers = {"dynamodb": FakeProvider("dynamodb")}
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
    return TestClient(management_app)


class TestGuiEndpoint:
    """Tests for GET /_ldk/gui."""

    def test_gui_returns_200(self, client):
        resp = client.get("/_ldk/gui")
        assert resp.status_code == 200

    def test_gui_returns_html_content_type(self, client):
        resp = client.get("/_ldk/gui")
        assert "text/html" in resp.headers["content-type"]

    def test_gui_contains_dashboard_markup(self, client):
        resp = client.get("/_ldk/gui")
        body = resp.text
        assert "<title>LDK Dashboard</title>" in body
        assert "Logs" in body
        assert "Resources" in body
        assert "Invoke" in body

    def test_gui_contains_websocket_js(self, client):
        resp = client.get("/_ldk/gui")
        assert "/_ldk/ws/logs" in resp.text
