"""Unit tests: apply_modify_lifecycle() helper."""

from __future__ import annotations

from unittest.mock import MagicMock

from lws.providers._shared.aws_lifecycle import (
    ResourceLifecycleConfig,
    ResourceStateTracker,
    apply_modify_lifecycle,
)


def _make_response(status_code: int) -> MagicMock:
    resp = MagicMock()
    resp.status_code = status_code
    return resp


class TestApplyModifyLifecycle:
    """apply_modify_lifecycle sets ACTIVE immediately when modify_dwell_ms is zero."""

    def test_sets_active_state_on_200_with_zero_dwell(self) -> None:
        # Arrange
        config = ResourceLifecycleConfig(modify_dwell_ms=0)
        tracker = ResourceStateTracker(config)
        resource_id = "mod-res-1"
        tracker.set_state(resource_id, "AVAILABLE")
        resp = _make_response(200)
        expected_state = "ACTIVE"

        # Act
        apply_modify_lifecycle(resp, resource_id, config, tracker)
        actual_state = tracker.get_state(resource_id)

        # Assert
        assert actual_state == expected_state, (
            f"Expected state {expected_state!r} after modify with zero dwell "
            f"but got {actual_state!r}"
        )

    async def test_sets_modifying_state_when_dwell_positive(self) -> None:
        # Arrange
        config = ResourceLifecycleConfig(modify_dwell_ms=500)
        tracker = ResourceStateTracker(config)
        resource_id = "mod-res-2"
        tracker.set_state(resource_id, "ACTIVE")
        resp = _make_response(200)
        expected_state = "MODIFYING"

        # Act
        apply_modify_lifecycle(resp, resource_id, config, tracker)
        actual_state = tracker.get_state(resource_id)

        # Assert
        assert actual_state == expected_state, (
            f"Expected intermediate state {expected_state!r} when modify_dwell_ms > 0 "
            f"but got {actual_state!r}"
        )

    def test_does_not_change_state_on_non_200(self) -> None:
        # Arrange
        config = ResourceLifecycleConfig(modify_dwell_ms=0)
        tracker = ResourceStateTracker(config)
        resource_id = "mod-res-3"
        tracker.set_state(resource_id, "ACTIVE")
        resp = _make_response(400)
        expected_state = "ACTIVE"

        # Act
        apply_modify_lifecycle(resp, resource_id, config, tracker)
        actual_state = tracker.get_state(resource_id)

        # Assert
        assert actual_state == expected_state, (
            f"Expected state to remain {expected_state!r} on non-200 response "
            f"but got {actual_state!r}"
        )

    def test_returns_resp_unchanged(self) -> None:
        # Arrange
        config = ResourceLifecycleConfig(modify_dwell_ms=0)
        tracker = ResourceStateTracker(config)
        resource_id = "mod-res-4"
        resp = _make_response(200)
        expected_resp = resp

        # Act
        actual_resp = apply_modify_lifecycle(resp, resource_id, config, tracker)

        # Assert
        assert actual_resp is expected_resp, (
            "Expected apply_modify_lifecycle to return the original response object "
            "but got a different object"
        )
