"""Unit tests for the WebSocket log streaming endpoint."""

from __future__ import annotations

from unittest.mock import patch

import pytest
from fastapi import FastAPI
from fastapi.testclient import TestClient

from lws.api.management import create_management_router
from lws.logging.logger import WebSocketLogHandler
from lws.runtime.orchestrator import Orchestrator

from ._helpers import FakeProvider


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


class TestWebSocketLogEndpoint:
    """Tests for WS /_ldk/ws/logs."""

    def test_ws_receives_backlog(self, client, ws_handler):
        # Arrange
        expected_message = "backlog entry"
        expected_level = "INFO"

        # Act
        with patch("lws.api.management.get_ws_handler", return_value=ws_handler):
            with client.websocket_connect("/_ldk/ws/logs") as ws:
                data = ws.receive_json()

                # Assert
                actual_message = data["message"]
                assert actual_message == expected_message
                actual_level = data["level"]
                assert actual_level == expected_level

    def test_ws_receives_live_entry(self, client, ws_handler):
        # Arrange
        expected_message = "live error"
        expected_level = "ERROR"

        # Act
        with patch("lws.api.management.get_ws_handler", return_value=ws_handler):
            with client.websocket_connect("/_ldk/ws/logs") as ws:
                # Consume backlog
                ws.receive_json()
                # Emit a live entry
                ws_handler.emit(
                    {"timestamp": "10:00:01", "level": expected_level, "message": expected_message}
                )
                data = ws.receive_json()

                # Assert
                actual_message = data["message"]
                assert actual_message == expected_message
                actual_level = data["level"]
                assert actual_level == expected_level

    def test_ws_closes_when_no_handler(self, client):
        with patch("lws.api.management.get_ws_handler", return_value=None):
            with pytest.raises(Exception):
                with client.websocket_connect("/_ldk/ws/logs") as ws:
                    ws.receive_json()
