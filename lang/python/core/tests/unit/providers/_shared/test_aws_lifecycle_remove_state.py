"""Unit tests for ResourceStateTracker.remove."""

from __future__ import annotations

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker


class TestResourceStateTrackerRemoveState:
    def test_remove_state(self):
        # Arrange
        config = ResourceLifecycleConfig()
        tracker = ResourceStateTracker(config)
        resource_id = "my-resource-id"
        tracker.set_state(resource_id, "CREATING")

        # Act
        tracker.remove(resource_id)
        actual_state = tracker.get_state(resource_id)

        # Assert
        assert actual_state is None, f"Expected None but got {actual_state!r}"
