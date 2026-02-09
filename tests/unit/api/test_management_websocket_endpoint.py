"""Unit tests for the WebSocket log streaming endpoint."""

from __future__ import annotations

from unittest.mock import patch

import pytest
from fastapi import FastAPI
from fastapi.testclient import TestClient

from lws.api.management import create_management_router
from lws.logging.logger import WebSocketLogHandler
from lws.runtime.orchestrator import Orchestrator

from ._helpers import FakeCompute, FakeProvider


@pytest.fixture
def ws_handler():
    """Create a WebSocketLogHandler with some buffered entries."""
    handler = WebSocketLogHandler(max_buffer=100)
    handler.emit({"timestamp": "10:00:00", "level": "INFO", "message": "backlog entry"})
    return handler


@pytest.fixture
def management_app(ws_handler):
    """Create a FastAPI app with management router and ws handler."""
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


class TestWebSocketLogEndpoint:
    """Tests for WS /_ldk/ws/logs."""

    def test_ws_receives_backlog(self, client, ws_handler):
        with patch("lws.api.management.get_ws_handler", return_value=ws_handler):
            with client.websocket_connect("/_ldk/ws/logs") as ws:
                data = ws.receive_json()
                assert data["message"] == "backlog entry"
                assert data["level"] == "INFO"

    def test_ws_receives_live_entry(self, client, ws_handler):
        with patch("lws.api.management.get_ws_handler", return_value=ws_handler):
            with client.websocket_connect("/_ldk/ws/logs") as ws:
                # Consume backlog
                ws.receive_json()
                # Emit a live entry
                ws_handler.emit(
                    {"timestamp": "10:00:01", "level": "ERROR", "message": "live error"}
                )
                data = ws.receive_json()
                assert data["message"] == "live error"
                assert data["level"] == "ERROR"

    def test_ws_closes_when_no_handler(self, client):
        with patch("lws.api.management.get_ws_handler", return_value=None):
            with pytest.raises(Exception):
                with client.websocket_connect("/_ldk/ws/logs") as ws:
                    ws.receive_json()
