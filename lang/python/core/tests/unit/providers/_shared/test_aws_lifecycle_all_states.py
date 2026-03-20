"""Unit tests for ResourceStateTracker.all_states."""

from __future__ import annotations

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker


class TestResourceStateTrackerAllStates:
    def test_all_states_returns_copy(self):
        # Arrange
        config = ResourceLifecycleConfig()
        tracker = ResourceStateTracker(config)
        tracker.set_state("resource-a", "ACTIVE")
        tracker.set_state("resource-b", "DELETING")
        expected_states = {"resource-a": "ACTIVE", "resource-b": "DELETING"}

        # Act
        actual_states = tracker.all_states()

        # Assert
        assert (
            actual_states == expected_states
        ), f"Expected {expected_states!r} but got {actual_states!r}"
        # Verify it is a copy — mutations do not affect internal state
        actual_states["resource-a"] = "DELETED"
        expected_preserved_state = "ACTIVE"
        actual_preserved_state = tracker.get_state("resource-a")
        assert (
            actual_preserved_state == expected_preserved_state
        ), f"Expected {expected_preserved_state!r} but got {actual_preserved_state!r}"
