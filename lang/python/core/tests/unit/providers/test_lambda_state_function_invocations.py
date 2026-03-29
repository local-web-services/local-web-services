"""Tests for _LambdaState per-function invocation tracking."""

from __future__ import annotations

from lws.providers.lambda_runtime._lambda_state import _LambdaState


class TestLambdaStateFunctionInvocations:
    """Tests for tracking invocations by function name."""

    def test_record_invocation_adds_to_function_list(self) -> None:
        # Arrange
        state = _LambdaState()
        expected_function = "my-function"
        expected_invocation_id = "inv-001"

        # Act
        state.record_invocation(expected_invocation_id, expected_function)

        # Assert
        actual_records = state.get_function_invocations(expected_function)
        actual_count = len(actual_records)
        expected_count = 1
        assert (
            actual_count == expected_count
        ), f"Expected {expected_count!r} but got {actual_count!r}"
        actual_id = actual_records[0]["InvocationId"]
        assert (
            actual_id == expected_invocation_id
        ), f"Expected {expected_invocation_id!r} but got {actual_id!r}"

    def test_record_invocation_initial_state_is_in_progress(self) -> None:
        # Arrange
        state = _LambdaState()
        expected_state = "IN_PROGRESS"

        # Act
        state.record_invocation("inv-002", "fn")

        # Assert
        records = state.get_function_invocations("fn")
        actual_state = records[0]["State"]
        assert (
            actual_state == expected_state
        ), f"Expected {expected_state!r} but got {actual_state!r}"

    def test_complete_invocation_updates_function_record(self) -> None:
        # Arrange
        state = _LambdaState()
        invocation_id = "inv-003"
        state.record_invocation(invocation_id, "fn-complete")
        expected_state = "SUCCESS"

        # Act
        state.complete_invocation(invocation_id, success=True)

        # Assert
        records = state.get_function_invocations("fn-complete")
        actual_state = records[0]["State"]
        assert (
            actual_state == expected_state
        ), f"Expected {expected_state!r} but got {actual_state!r}"

    def test_complete_invocation_failed_updates_function_record(self) -> None:
        # Arrange
        state = _LambdaState()
        invocation_id = "inv-004"
        state.record_invocation(invocation_id, "fn-fail")
        expected_state = "FAILED"

        # Act
        state.complete_invocation(invocation_id, success=False)

        # Assert
        records = state.get_function_invocations("fn-fail")
        actual_state = records[0]["State"]
        assert (
            actual_state == expected_state
        ), f"Expected {expected_state!r} but got {actual_state!r}"

    def test_get_function_invocations_unknown_function_returns_empty(self) -> None:
        # Arrange
        state = _LambdaState()
        expected_result: list = []

        # Act
        actual_result = state.get_function_invocations("nonexistent-function")

        # Assert
        assert (
            actual_result == expected_result
        ), f"Expected {expected_result!r} but got {actual_result!r}"

    def test_record_invocation_without_function_name_not_tracked_by_function(self) -> None:
        # Arrange
        state = _LambdaState()
        expected_count = 0

        # Act
        state.record_invocation("inv-005")

        # Assert
        actual_count = len(state.function_invocations)
        assert (
            actual_count == expected_count
        ), f"Expected {expected_count!r} but got {actual_count!r}"

    def test_multiple_invocations_for_same_function(self) -> None:
        # Arrange
        state = _LambdaState()
        expected_count = 3
        function_name = "multi-fn"

        # Act
        for i in range(expected_count):
            state.record_invocation(f"inv-{i}", function_name)

        # Assert
        actual_count = len(state.get_function_invocations(function_name))
        assert (
            actual_count == expected_count
        ), f"Expected {expected_count!r} but got {actual_count!r}"
