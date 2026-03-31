"""Unit tests for TrackerRegistry dispatch — set_state path."""

from __future__ import annotations

from lws.providers._shared.async_state_store import AsyncStateStore
from lws.providers._shared.aws_lifecycle import (
    ResourceLifecycleConfig,
    ResourceStateTracker,
    TrackerRegistry,
)

from ._helpers import make_registry_client


class TestTrackerRegistryDispatchSetState:
    """inject_state with a registered tracker sets state on the tracker."""

    def test_inject_state_calls_set_state_on_tracker(self):
        # Arrange
        lc = ResourceLifecycleConfig()
        tracker = ResourceStateTracker(lc)
        resource_id = "my-cluster"
        tracker.set_state(resource_id, "CREATING")
        registry: TrackerRegistry = {("neptune", "cluster"): tracker}
        state_store = AsyncStateStore()
        client = make_registry_client(state_store, tracker_registry=registry)
        expected_state = "available"

        # Act
        client.put(
            f"/_ldk/state/neptune/cluster/{resource_id}",
            json={"state": expected_state},
        )

        # Assert
        actual_state = tracker.get_state(resource_id)
        assert (
            actual_state == expected_state
        ), f"Expected {expected_state!r} but got {actual_state!r}"

    def test_inject_state_also_writes_to_state_store(self):
        # Arrange
        lc = ResourceLifecycleConfig()
        tracker = ResourceStateTracker(lc)
        resource_id = "my-cluster"
        tracker.set_state(resource_id, "CREATING")
        registry: TrackerRegistry = {("neptune", "cluster"): tracker}
        state_store = AsyncStateStore()
        client = make_registry_client(state_store, tracker_registry=registry)
        expected_state = "available"

        # Act
        client.put(
            f"/_ldk/state/neptune/cluster/{resource_id}",
            json={"state": expected_state},
        )

        # Assert
        actual_state = state_store.get("neptune", "cluster", resource_id)
        assert (
            actual_state == expected_state
        ), f"Expected {expected_state!r} but got {actual_state!r}"
