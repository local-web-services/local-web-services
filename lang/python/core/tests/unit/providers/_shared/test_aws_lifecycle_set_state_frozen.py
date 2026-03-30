"""Unit tests: set_state(frozen=True) freezes a resource and cancels in-flight task."""

from __future__ import annotations

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker


class TestSetStateFrozen:
    """set_state with frozen=True writes state and marks resource as frozen."""

    def test_frozen_state_is_written(self) -> None:
        # Arrange
        config = ResourceLifecycleConfig()
        tracker = ResourceStateTracker(config)
        resource_id = "res-frozen-1"
        expected_state = "CREATING"

        # Act
        tracker.set_state(resource_id, expected_state, frozen=True)
        actual_state = tracker.get_state(resource_id)

        # Assert
        assert (
            actual_state == expected_state
        ), f"Expected state {expected_state!r} but got {actual_state!r}"

    def test_frozen_resource_blocks_schedule_transition(self) -> None:
        # Arrange
        config = ResourceLifecycleConfig()
        tracker = ResourceStateTracker(config)
        resource_id = "res-frozen-2"
        tracker.set_state(resource_id, "CREATING", frozen=True)
        expected_state = "CREATING"

        # Act
        tracker.schedule_transition(resource_id, "ACTIVE", delay_ms=0)
        actual_state = tracker.get_state(resource_id)

        # Assert
        assert actual_state == expected_state, (
            f"Expected frozen state {expected_state!r} to remain unchanged "
            f"but got {actual_state!r}"
        )

    def test_frozen_resource_stores_pending_target(self) -> None:
        # Arrange
        config = ResourceLifecycleConfig()
        tracker = ResourceStateTracker(config)
        resource_id = "res-frozen-3"
        tracker.set_state(resource_id, "CREATING", frozen=True)
        expected_pending_target = "ACTIVE"

        # Act
        tracker.schedule_transition(resource_id, expected_pending_target, delay_ms=0)
        actual_pending = tracker._pending_target.get(resource_id)

        # Assert
        assert (
            actual_pending == expected_pending_target
        ), f"Expected pending target {expected_pending_target!r} but got {actual_pending!r}"

    def test_non_frozen_set_state_does_not_affect_frozen_flag(self) -> None:
        # Arrange
        config = ResourceLifecycleConfig()
        tracker = ResourceStateTracker(config)
        resource_id = "res-not-frozen"
        expected_state = "ACTIVE"

        # Act
        tracker.set_state(resource_id, expected_state)
        tracker.schedule_transition(resource_id, "DELETING", delay_ms=0)
        actual_state = tracker.get_state(resource_id)

        # Assert
        expected_final = "DELETING"
        assert actual_state == expected_final, (
            f"Expected non-frozen resource to transition to {expected_final!r} "
            f"but got {actual_state!r}"
        )
