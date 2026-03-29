"""Unit tests for the state injection management API — DELETE endpoint."""

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


class TestStateInjectionClear:
    """Tests for DELETE /_ldk/state/{service}/{resource_type}/{resource_id}."""

    def test_clear_state_returns_ok(self):
        # Arrange
        expected_status_code = 200
        state_store = AsyncStateStore()
        state_store.set("stepfunctions", "execution", "my-exec", "RUNNING")
        client = _make_client(state_store)

        # Act
        resp = client.delete("/_ldk/state/stepfunctions/execution/my-exec")

        # Assert
        assert (
            resp.status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {resp.status_code!r}"

    def test_clear_state_removes_from_store(self):
        # Arrange
        state_store = AsyncStateStore()
        state_store.set("stepfunctions", "execution", "my-exec", "RUNNING")
        client = _make_client(state_store)

        # Act
        client.delete("/_ldk/state/stepfunctions/execution/my-exec")

        # Assert
        actual_state = state_store.get("stepfunctions", "execution", "my-exec")
        assert actual_state is None, f"Expected None but got {actual_state!r}"

    def test_clear_nonexistent_state_returns_ok(self):
        # Arrange
        expected_status_code = 200
        state_store = AsyncStateStore()
        client = _make_client(state_store)

        # Act
        resp = client.delete("/_ldk/state/stepfunctions/execution/nonexistent")

        # Assert
        assert (
            resp.status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {resp.status_code!r}"
