"""Unit tests for ResourceStateTracker.get_state."""

from __future__ import annotations

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker


class TestResourceStateTrackerGetState:
    def test_get_state_returns_none_for_unknown_resource(self):
        # Arrange
        config = ResourceLifecycleConfig()
        tracker = ResourceStateTracker(config)
        resource_id = "unknown-resource-id"

        # Act
        actual_state = tracker.get_state(resource_id)

        # Assert
        assert actual_state is None, f"Expected None but got {actual_state!r}"
