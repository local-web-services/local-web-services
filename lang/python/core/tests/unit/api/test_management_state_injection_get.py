"""Unit tests for the state injection management API — GET endpoint."""

from __future__ import annotations

from fastapi import FastAPI
from fastapi.testclient import TestClient

from lws.api.management import create_management_router
from lws.providers._shared.async_state_store import AsyncStateStore
from lws.runtime.orchestrator import Orchestrator

from ._helpers import FakeProvider


def _make_client(state_store: AsyncStateStore) -> TestClient:
    orchestrator = Orchestrator()
    orchestrator._running = True
    providers: dict = {"dynamodb": FakeProvider("dynamodb")}
    orchestrator._providers = providers
    router = create_management_router(
        orchestrator=orchestrator,
        providers=providers,
        state_store=state_store,
    )
    app = FastAPI()
    app.include_router(router)
    return TestClient(app)


class TestStateInjectionGet:
    """Tests for GET /_ldk/state/{service}/{resource_type}/{resource_id}."""

    def test_get_state_returns_ok(self):
        # Arrange
        expected_status_code = 200
        state_store = AsyncStateStore()
        state_store.set("stepfunctions", "execution", "my-exec", "RUNNING")
        client = _make_client(state_store)

        # Act
        resp = client.get("/_ldk/state/stepfunctions/execution/my-exec")

        # Assert
        assert (
            resp.status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {resp.status_code!r}"

    def test_get_state_returns_state_in_response(self):
        # Arrange
        expected_state = "RUNNING"
        state_store = AsyncStateStore()
        state_store.set("stepfunctions", "execution", "my-exec", expected_state)
        client = _make_client(state_store)

        # Act
        resp = client.get("/_ldk/state/stepfunctions/execution/my-exec")

        # Assert
        actual_state = resp.json()["state"]
        assert (
            actual_state == expected_state
        ), f"Expected {expected_state!r} but got {actual_state!r}"

    def test_get_nonexistent_state_returns_404(self):
        # Arrange
        expected_status_code = 404
        state_store = AsyncStateStore()
        client = _make_client(state_store)

        # Act
        resp = client.get("/_ldk/state/stepfunctions/execution/nonexistent")

        # Assert
        assert (
            resp.status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {resp.status_code!r}"
