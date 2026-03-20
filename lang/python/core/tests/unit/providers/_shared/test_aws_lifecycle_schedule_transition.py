"""Unit tests for ResourceStateTracker.schedule_transition."""

from __future__ import annotations

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker


class TestResourceStateTrackerScheduleTransitionZeroDelay:
    def test_schedule_transition_zero_delay_applies_synchronously(self):
        # Arrange
        config = ResourceLifecycleConfig()
        tracker = ResourceStateTracker(config)
        resource_id = "resource-sync"
        tracker.set_state(resource_id, "CREATING")
        expected_state = "ACTIVE"

        # Act
        tracker.schedule_transition(resource_id, expected_state, delay_ms=0)
        actual_state = tracker.get_state(resource_id)

        # Assert
        assert actual_state == expected_state, f"Expected {expected_state!r} but got {actual_state!r}"

    def test_schedule_transition_zero_delay_none_target_removes_resource(self):
        # Arrange
        config = ResourceLifecycleConfig()
        tracker = ResourceStateTracker(config)
        resource_id = "resource-to-remove"
        tracker.set_state(resource_id, "DELETING")

        # Act
        tracker.schedule_transition(resource_id, None, delay_ms=0)
        actual_state = tracker.get_state(resource_id)

        # Assert
        assert actual_state is None, f"Expected None but got {actual_state!r}"
