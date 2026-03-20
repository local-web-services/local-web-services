"""Unit tests for ResourceStateTracker.set_state."""

from __future__ import annotations

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker


class TestResourceStateTrackerSetAndGetState:
    def test_set_and_get_state(self):
        # Arrange
        config = ResourceLifecycleConfig()
        tracker = ResourceStateTracker(config)
        resource_id = "my-resource-id"
        expected_state = "ACTIVE"

        # Act
        tracker.set_state(resource_id, expected_state)
        actual_state = tracker.get_state(resource_id)

        # Assert
        assert (
            actual_state == expected_state
        ), f"Expected {expected_state!r} but got {actual_state!r}"
