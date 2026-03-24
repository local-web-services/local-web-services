"""Tests for Lambda async (Event-type) invocation state tracking."""

from __future__ import annotations

from lws.providers.lambda_runtime._lambda_state import (
    _INVOCATION_STATE_FAILED,
    _INVOCATION_STATE_IN_PROGRESS,
    _INVOCATION_STATE_SUCCESS,
    _LambdaState,
)


class TestLambdaAsyncInvocationState:
    """Test _LambdaState invocation tracking methods."""

    def test_record_invocation_sets_in_progress(self) -> None:
        # Arrange
        state = _LambdaState()
        expected_invocation_state = _INVOCATION_STATE_IN_PROGRESS
        expected_invocation_id = "test-uuid-1234"

        # Act
        state.record_invocation(expected_invocation_id)

        # Assert
        actual_invocation_state = state.get_invocation_state(expected_invocation_id)
        assert actual_invocation_state == expected_invocation_state, (
            f"Expected invocation state '{expected_invocation_state}' "
            f"but got '{actual_invocation_state}'"
        )

    def test_complete_invocation_success_transitions_to_success(self) -> None:
        # Arrange
        state = _LambdaState()
        expected_invocation_state = _INVOCATION_STATE_SUCCESS
        expected_invocation_id = "test-uuid-success"
        state.record_invocation(expected_invocation_id)

        # Act
        state.complete_invocation(expected_invocation_id, success=True)

        # Assert
        actual_invocation_state = state.get_invocation_state(expected_invocation_id)
        assert actual_invocation_state == expected_invocation_state, (
            f"Expected invocation state '{expected_invocation_state}' "
            f"but got '{actual_invocation_state}'"
        )

    def test_complete_invocation_failure_transitions_to_failed(self) -> None:
        # Arrange
        state = _LambdaState()
        expected_invocation_state = _INVOCATION_STATE_FAILED
        expected_invocation_id = "test-uuid-failed"
        state.record_invocation(expected_invocation_id)

        # Act
        state.complete_invocation(expected_invocation_id, success=False)

        # Assert
        actual_invocation_state = state.get_invocation_state(expected_invocation_id)
        assert actual_invocation_state == expected_invocation_state, (
            f"Expected invocation state '{expected_invocation_state}' "
            f"but got '{actual_invocation_state}'"
        )

    def test_get_invocation_state_returns_none_for_unknown(self) -> None:
        # Arrange
        state = _LambdaState()
        expected_result = None
        unknown_invocation_id = "no-such-invocation"

        # Act
        actual_result = state.get_invocation_state(unknown_invocation_id)

        # Assert
        assert (
            actual_result == expected_result
        ), f"Expected None for unknown invocation but got '{actual_result}'"

    def test_complete_invocation_noop_for_unknown_id(self) -> None:
        # Arrange
        state = _LambdaState()
        unknown_invocation_id = "ghost-invocation"

        # Act — must not raise
        state.complete_invocation(unknown_invocation_id, success=True)

        # Assert
        actual_result = state.get_invocation_state(unknown_invocation_id)
        assert (
            actual_result is None
        ), f"Expected None for ghost invocation but got '{actual_result}'"

    def test_multiple_invocations_tracked_independently(self) -> None:
        # Arrange
        state = _LambdaState()
        expected_id_a = "inv-a"
        expected_id_b = "inv-b"
        expected_state_a = _INVOCATION_STATE_SUCCESS
        expected_state_b = _INVOCATION_STATE_FAILED

        state.record_invocation(expected_id_a)
        state.record_invocation(expected_id_b)

        # Act
        state.complete_invocation(expected_id_a, success=True)
        state.complete_invocation(expected_id_b, success=False)

        # Assert
        actual_state_a = state.get_invocation_state(expected_id_a)
        actual_state_b = state.get_invocation_state(expected_id_b)
        assert (
            actual_state_a == expected_state_a
        ), f"Expected state '{expected_state_a}' for inv-a but got '{actual_state_a}'"
        assert (
            actual_state_b == expected_state_b
        ), f"Expected state '{expected_state_b}' for inv-b but got '{actual_state_b}'"
