"""Unit tests: unfreeze() clears frozen flag and applies pending target."""

from __future__ import annotations

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, ResourceStateTracker


class TestUnfreezeAppliesTarget:
    """unfreeze() with apply=True transitions the resource to its pending target."""

    def test_unfreeze_transitions_to_pending_target(self) -> None:
        # Arrange
        config = ResourceLifecycleConfig()
        tracker = ResourceStateTracker(config)
        resource_id = "res-unfreeze-1"
        tracker.set_state(resource_id, "CREATING", frozen=True)
        tracker.schedule_transition(resource_id, "ACTIVE", delay_ms=0)
        expected_state = "ACTIVE"

        # Act
        tracker.unfreeze(resource_id, apply=True)
        actual_state = tracker.get_state(resource_id)

        # Assert
        assert (
            actual_state == expected_state
        ), f"Expected post-unfreeze state {expected_state!r} but got {actual_state!r}"

    def test_unfreeze_with_apply_false_does_not_transition(self) -> None:
        # Arrange
        config = ResourceLifecycleConfig()
        tracker = ResourceStateTracker(config)
        resource_id = "res-unfreeze-2"
        tracker.set_state(resource_id, "CREATING", frozen=True)
        tracker.schedule_transition(resource_id, "ACTIVE", delay_ms=0)
        expected_state = "CREATING"

        # Act
        tracker.unfreeze(resource_id, apply=False)
        actual_state = tracker.get_state(resource_id)

        # Assert
        assert actual_state == expected_state, (
            f"Expected state to remain {expected_state!r} when apply=False "
            f"but got {actual_state!r}"
        )

    def test_unfreeze_allows_subsequent_transitions(self) -> None:
        # Arrange
        config = ResourceLifecycleConfig()
        tracker = ResourceStateTracker(config)
        resource_id = "res-unfreeze-3"
        tracker.set_state(resource_id, "CREATING", frozen=True)
        tracker.unfreeze(resource_id, apply=False)
        expected_state = "ACTIVE"

        # Act
        tracker.schedule_transition(resource_id, expected_state, delay_ms=0)
        actual_state = tracker.get_state(resource_id)

        # Assert
        assert actual_state == expected_state, (
            f"Expected transition to {expected_state!r} after unfreeze " f"but got {actual_state!r}"
        )

    def test_unfreeze_with_no_pending_target_is_safe(self) -> None:
        # Arrange
        config = ResourceLifecycleConfig()
        tracker = ResourceStateTracker(config)
        resource_id = "res-unfreeze-4"
        tracker.set_state(resource_id, "CREATING", frozen=True)
        expected_state = "CREATING"

        # Act — unfreeze without any pending target stored
        tracker.unfreeze(resource_id, apply=True)
        actual_state = tracker.get_state(resource_id)

        # Assert
        assert actual_state == expected_state, (
            f"Expected state to remain {expected_state!r} when no pending target "
            f"but got {actual_state!r}"
        )
