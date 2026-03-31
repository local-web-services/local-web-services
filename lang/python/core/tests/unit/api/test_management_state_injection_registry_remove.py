"""Unit tests for TrackerRegistry dispatch — remove path."""

from __future__ import annotations

import pytest

from lws.providers._shared.async_state_store import AsyncStateStore
from lws.providers._shared.aws_lifecycle import (
    ResourceLifecycleConfig,
    ResourceStateTracker,
    TrackerRegistry,
)

from ._helpers import make_registry_client


@pytest.mark.parametrize("deleted_state", ["deleted", "removed"])
class TestTrackerRegistryDispatchRemove:
    """inject_state with a deleted/removed state calls remove on the tracker."""

    def test_inject_deleted_state_removes_from_tracker(self, deleted_state):
        # Arrange
        lc = ResourceLifecycleConfig()
        tracker = ResourceStateTracker(lc)
        resource_id = "my-cluster"
        tracker.set_state(resource_id, "DELETING")
        registry: TrackerRegistry = {("opensearch", "domain"): tracker}
        state_store = AsyncStateStore()
        client = make_registry_client(state_store, tracker_registry=registry)

        # Act
        client.put(
            f"/_ldk/state/opensearch/domain/{resource_id}",
            json={"state": deleted_state},
        )

        # Assert
        actual_state = tracker.get_state(resource_id)
        assert actual_state is None, f"Expected None but got {actual_state!r}"
