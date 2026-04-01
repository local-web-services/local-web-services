"""Integration tests for TrackerRegistry dispatch via the management state injection API."""

from __future__ import annotations

import httpx
import pytest
from fastapi import FastAPI

from lws.api.management import create_management_router
from lws.providers._shared.aws_lifecycle import (
    ResourceLifecycleConfig,
    ResourceStateTracker,
    TrackerRegistry,
)
from lws.runtime.orchestrator import Orchestrator


@pytest.fixture
def neptune_tracker():
    """A ResourceStateTracker for Neptune clusters."""
    lc = ResourceLifecycleConfig()
    return ResourceStateTracker(lc)


@pytest.fixture
def tracker_registry(neptune_tracker):
    """TrackerRegistry with Neptune cluster tracker pre-registered."""
    registry: TrackerRegistry = {("neptune", "cluster"): neptune_tracker}
    return registry


@pytest.fixture
def app(tracker_registry):
    """FastAPI app with management router wired to a TrackerRegistry."""
    orchestrator = Orchestrator()
    orchestrator._running = True
    router = create_management_router(
        orchestrator=orchestrator,
        tracker_registry=tracker_registry,
    )
    fastapi_app = FastAPI()
    fastapi_app.include_router(router)
    return fastapi_app


@pytest.fixture
async def client(app):
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as c:
        yield c


class TestInjectStateReachesClusterTracker:
    """PUT /state/neptune/cluster/{id} calls set_state on the registered tracker."""

    async def test_inject_available_state_sets_tracker_state(
        self, client: httpx.AsyncClient, neptune_tracker: ResourceStateTracker
    ):
        # Arrange
        resource_id = "my-neptune-cluster"
        neptune_tracker.set_state(resource_id, "CREATING")
        expected_state = "available"

        # Act
        response = await client.put(
            f"/_ldk/state/neptune/cluster/{resource_id}",
            json={"state": expected_state},
        )

        # Assert
        assert response.status_code == 200, f"Expected 200 but got {response.status_code}"
        actual_state = neptune_tracker.get_state(resource_id)
        assert (
            actual_state == expected_state
        ), f"Expected {expected_state!r} but got {actual_state!r}"

    async def test_inject_deleted_state_removes_from_tracker(
        self, client: httpx.AsyncClient, neptune_tracker: ResourceStateTracker
    ):
        # Arrange
        resource_id = "my-neptune-cluster"
        neptune_tracker.set_state(resource_id, "DELETING")

        # Act
        response = await client.put(
            f"/_ldk/state/neptune/cluster/{resource_id}",
            json={"state": "deleted"},
        )

        # Assert
        assert response.status_code == 200, f"Expected 200 but got {response.status_code}"
        actual_state = neptune_tracker.get_state(resource_id)
        assert actual_state is None, f"Expected None but got {actual_state!r}"
