"""Unit tests for cluster service state injection via the management API."""

from __future__ import annotations

import pytest
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


@pytest.mark.parametrize(
    "service,resource_type,resource_id,state",
    [
        ("elasticache", "cluster", "e2e-test-cluster-1", "modifying"),
        ("elasticache", "replication_group", "e2e-test-rg-1", "modifying"),
        ("neptune", "cluster", "e2e-test-cluster-1", "modifying"),
        ("neptune", "instance", "e2e-test-instance-1", "modifying"),
        ("rds", "instance", "e2e-test-db-1", "modifying"),
        ("docdb", "cluster", "e2e-test-cluster-1", "modifying"),
        ("docdb", "instance", "e2e-test-instance-1", "modifying"),
        ("memorydb", "cluster", "e2e-test-cluster-1", "modifying"),
        ("memorydb", "user", "e2e-test-user-1", "modifying"),
        ("memorydb", "acl", "e2e-test-acl-1", "modifying"),
    ],
)
class TestClusterStateInjection:
    def test_inject_cluster_state_stores_in_store(self, service, resource_type, resource_id, state):
        # Arrange
        state_store = AsyncStateStore()
        client = _make_client(state_store)
        expected_state = state

        # Act
        client.put(
            f"/_ldk/state/{service}/{resource_type}/{resource_id}",
            json={"state": expected_state},
        )

        # Assert
        actual_state = state_store.get(service, resource_type, resource_id)
        assert (
            actual_state == expected_state
        ), f"Expected {expected_state!r} but got {actual_state!r}"

    def test_inject_cluster_state_returns_200(self, service, resource_type, resource_id, state):
        # Arrange
        state_store = AsyncStateStore()
        client = _make_client(state_store)
        expected_status_code = 200

        # Act
        resp = client.put(
            f"/_ldk/state/{service}/{resource_type}/{resource_id}",
            json={"state": state},
        )

        # Assert
        assert (
            resp.status_code == expected_status_code
        ), f"Expected {expected_status_code!r} but got {resp.status_code!r}"

    def test_get_cluster_state_returns_injected_state(
        self, service, resource_type, resource_id, state
    ):
        # Arrange
        state_store = AsyncStateStore()
        state_store.set(service, resource_type, resource_id, state)
        client = _make_client(state_store)
        expected_state = state

        # Act
        resp = client.get(f"/_ldk/state/{service}/{resource_type}/{resource_id}")

        # Assert
        actual_state = resp.json()["state"]
        assert (
            actual_state == expected_state
        ), f"Expected {expected_state!r} but got {actual_state!r}"
