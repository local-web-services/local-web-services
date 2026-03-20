"""Unit tests for ResourceStateTracker.reset."""

from __future__ import annotations

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker


class TestResourceStateTrackerReset:
    def test_reset_clears_all_states(self):
        # Arrange
        config = ResourceLifecycleConfig()
        tracker = ResourceStateTracker(config)
        tracker.set_state("resource-a", "ACTIVE")
        tracker.set_state("resource-b", "CREATING")
        expected_states: dict[str, str] = {}

        # Act
        tracker.reset()
        actual_states = tracker.all_states()

        # Assert
        assert (
            actual_states == expected_states
        ), f"Expected {expected_states!r} but got {actual_states!r}"
