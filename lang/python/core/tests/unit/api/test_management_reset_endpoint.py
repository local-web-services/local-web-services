"""Unit tests for the LDK management API."""

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

    providers = {
        "lambda:myFunc": FakeProvider("lambda:myFunc"),
        "dynamodb": FakeProvider("dynamodb"),
    }
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
    """Create a test client for the management API."""
    return TestClient(management_app)


class TestResetEndpoint:
    """Tests for POST /_ldk/reset."""

    def test_reset_returns_ok(self, client):
        # Arrange
        expected_status_code = 200
        expected_status = "ok"

        # Act
        resp = client.post("/_ldk/reset")

        # Assert
        assert (
            resp.status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {resp.status_code!r}"
        data = resp.json()
        actual_status = data["status"]
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"

    def test_reset_returns_provider_count(self, client):
        # Arrange
        expected_providers_reset = 0

        # Act
        resp = client.post("/_ldk/reset")

        # Assert
        data = resp.json()
        assert "providers_reset" in data, f'Expected {"providers_reset"!r} to be in {data!r}'
        # No providers have a reset() method, so count should be 0
        actual_providers_reset = data["providers_reset"]
        assert (
            actual_providers_reset == expected_providers_reset
        ), f"Expected {expected_providers_reset!r} but got {actual_providers_reset!r}"
