"""Unit tests for GET /_ldk/fake/{name} management endpoint."""

from __future__ import annotations

from unittest.mock import MagicMock

import pytest
from fastapi import FastAPI
from fastapi.testclient import TestClient

from lws.api.management import create_management_router
from lws.runtime.orchestrator import Orchestrator


def _make_child(name: str = "test-server", port: int = 9100) -> MagicMock:
    child = MagicMock()
    child.config.name = name
    child.port = port
    child.config.protocol = "rest"
    child.config.description = ""
    child.config.routes = []
    child.config.chaos.enabled = False
    return child


def _make_fake_provider_with_server() -> MagicMock:
    child = _make_child()
    provider = MagicMock()
    provider.children = {"test-server": child}
    return provider


def _make_fake_provider_empty() -> MagicMock:
    provider = MagicMock()
    provider.children = {}
    return provider


@pytest.fixture
def client_with_server():
    orchestrator = Orchestrator()
    fake_provider = _make_fake_provider_with_server()
    router = create_management_router(orchestrator=orchestrator, fake_provider=fake_provider)
    fast_app = FastAPI()
    fast_app.include_router(router)
    return TestClient(fast_app)


@pytest.fixture
def client_empty():
    orchestrator = Orchestrator()
    fake_provider = _make_fake_provider_empty()
    router = create_management_router(orchestrator=orchestrator, fake_provider=fake_provider)
    fast_app = FastAPI()
    fast_app.include_router(router)
    return TestClient(fast_app)


class TestManagementFakeServerGet:
    """Tests for GET /_ldk/fake/{name}."""

    def test_get_returns_200_for_existing_server(self, client_with_server):
        # Arrange
        expected_status_code = 200

        # Act
        resp = client_with_server.get("/_ldk/fake/test-server")

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code

    def test_get_returns_server_name(self, client_with_server):
        # Arrange
        expected_name = "test-server"

        # Act
        resp = client_with_server.get("/_ldk/fake/test-server")

        # Assert
        actual_name = resp.json()["name"]
        assert actual_name == expected_name

    def test_get_returns_server_port(self, client_with_server):
        # Arrange
        expected_port = 9100

        # Act
        resp = client_with_server.get("/_ldk/fake/test-server")

        # Assert
        actual_port = resp.json()["port"]
        assert actual_port == expected_port

    def test_get_returns_404_for_unknown_server(self, client_empty):
        # Arrange
        expected_status_code = 404

        # Act
        resp = client_empty.get("/_ldk/fake/missing-server")

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
