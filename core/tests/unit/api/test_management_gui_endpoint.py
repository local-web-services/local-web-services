"""Unit tests for the GUI dashboard endpoint."""

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
    providers = {"dynamodb": FakeProvider("dynamodb")}
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
    return TestClient(management_app)


class TestGuiEndpoint:
    """Tests for GET /_ldk/gui."""

    def test_gui_returns_200(self, client):
        # Arrange
        expected_status_code = 200

        # Act
        resp = client.get("/_ldk/gui")

        # Assert
        assert resp.status_code == expected_status_code

    def test_gui_returns_html_content_type(self, client):
        # Arrange
        expected_content_type = "text/html"

        # Act
        resp = client.get("/_ldk/gui")

        # Assert
        actual_content_type = resp.headers["content-type"]
        assert expected_content_type in actual_content_type

    def test_gui_contains_dashboard_markup(self, client):
        # Arrange
        expected_title = "<title>LDK Dashboard</title>"
        expected_logs_section = "Logs"
        expected_resources_section = "Resources"
        expected_invoke_section = "Invoke"

        # Act
        resp = client.get("/_ldk/gui")

        # Assert
        actual_body = resp.text
        assert expected_title in actual_body
        assert expected_logs_section in actual_body
        assert expected_resources_section in actual_body
        assert expected_invoke_section in actual_body

    def test_gui_contains_websocket_js(self, client):
        # Arrange
        expected_ws_path = "/_ldk/ws/logs"

        # Act
        resp = client.get("/_ldk/gui")

        # Assert
        actual_body = resp.text
        assert expected_ws_path in actual_body
