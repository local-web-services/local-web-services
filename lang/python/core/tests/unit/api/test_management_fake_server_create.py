"""Unit tests for POST /_ldk/fake management endpoint."""

from __future__ import annotations

from unittest.mock import AsyncMock, MagicMock

import pytest
from fastapi import FastAPI
from fastapi.testclient import TestClient

from lws.api.management import create_management_router
from lws.runtime.orchestrator import Orchestrator


def _make_fake_provider(children: dict | None = None) -> MagicMock:
    provider = MagicMock()
    provider.children = children or {}
    provider.create_server_in_memory = AsyncMock(
        return_value={"name": "test-server", "port": 9100, "protocol": "rest"}
    )
    return provider


@pytest.fixture
def client():
    orchestrator = Orchestrator()
    fake_provider = _make_fake_provider()
    router = create_management_router(orchestrator=orchestrator, fake_provider=fake_provider)
    fast_app = FastAPI()
    fast_app.include_router(router)
    return TestClient(fast_app)


@pytest.fixture
def client_conflict():
    orchestrator = Orchestrator()
    provider = MagicMock()
    provider.children = {}
    provider.create_server_in_memory = AsyncMock(side_effect=ValueError("already exists"))
    router = create_management_router(orchestrator=orchestrator, fake_provider=provider)
    fast_app = FastAPI()
    fast_app.include_router(router)
    return TestClient(fast_app)


class TestManagementFakeServerCreate:
    """Tests for POST /_ldk/fake."""

    def test_create_returns_201_on_success(self, client):
        # Arrange
        expected_status_code = 201

        # Act
        resp = client.post("/_ldk/fake", json={"name": "test-server"})

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code

    def test_create_returns_server_name(self, client):
        # Arrange
        expected_name = "test-server"

        # Act
        resp = client.post("/_ldk/fake", json={"name": "test-server"})

        # Assert
        actual_name = resp.json()["name"]
        assert actual_name == expected_name

    def test_create_returns_400_when_name_missing(self, client):
        # Arrange
        expected_status_code = 400

        # Act
        resp = client.post("/_ldk/fake", json={})

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code

    def test_create_returns_409_when_server_already_exists(self, client_conflict):
        # Arrange
        expected_status_code = 409

        # Act
        resp = client_conflict.post("/_ldk/fake", json={"name": "existing-server"})

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
