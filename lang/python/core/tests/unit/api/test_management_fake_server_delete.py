"""Unit tests for DELETE /_ldk/fake/{name} management endpoint."""

from __future__ import annotations

from unittest.mock import AsyncMock, MagicMock

import pytest
from fastapi import FastAPI
from fastapi.testclient import TestClient

from lws.api.management import create_management_router
from lws.runtime.orchestrator import Orchestrator


def _make_fake_provider_success() -> MagicMock:
    provider = MagicMock()
    provider.children = {}
    provider.delete_server_in_memory = AsyncMock(return_value=None)
    return provider


def _make_fake_provider_not_found() -> MagicMock:
    provider = MagicMock()
    provider.children = {}
    provider.delete_server_in_memory = AsyncMock(side_effect=KeyError("missing-server"))
    return provider


@pytest.fixture
def client_success():
    orchestrator = Orchestrator()
    fake_provider = _make_fake_provider_success()
    router = create_management_router(orchestrator=orchestrator, fake_provider=fake_provider)
    fast_app = FastAPI()
    fast_app.include_router(router)
    return TestClient(fast_app)


@pytest.fixture
def client_not_found():
    orchestrator = Orchestrator()
    fake_provider = _make_fake_provider_not_found()
    router = create_management_router(orchestrator=orchestrator, fake_provider=fake_provider)
    fast_app = FastAPI()
    fast_app.include_router(router)
    return TestClient(fast_app)


class TestManagementFakeServerDelete:
    """Tests for DELETE /_ldk/fake/{name}."""

    def test_delete_returns_200_on_success(self, client_success):
        # Arrange
        expected_status_code = 200

        # Act
        resp = client_success.delete("/_ldk/fake/test-server")

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code

    def test_delete_returns_deleted_name(self, client_success):
        # Arrange
        expected_deleted = "test-server"

        # Act
        resp = client_success.delete("/_ldk/fake/test-server")

        # Assert
        actual_deleted = resp.json()["deleted"]
        assert actual_deleted == expected_deleted

    def test_delete_returns_404_when_server_not_found(self, client_not_found):
        # Arrange
        expected_status_code = 404

        # Act
        resp = client_not_found.delete("/_ldk/fake/missing-server")

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
