"""Tests for evaluate_output."""

from __future__ import annotations

from lws.providers.stepfunctions.jsonata_evaluator import evaluate_output


class TestEvaluateOutput:
    def test_evaluates_expression(self) -> None:
        # Arrange
        expected_name = "Alice"
        output = "{% $states.input.name %}"
        input_data = {"name": expected_name}

        # Act
        actual_result = evaluate_output(output, input_data)

        # Assert
        assert actual_result == expected_name

    def test_returns_literal_unchanged(self) -> None:
        # Arrange
        expected_result = "plain"
        output = expected_result
        input_data = {"name": "Alice"}

        # Act
        actual_result = evaluate_output(output, input_data)

        # Assert
        assert actual_result == expected_result

    def test_accesses_task_result_via_states_result(self) -> None:
        # Arrange
        expected_value = "task-done"
        output = "{% $states.result.value %}"
        input_data = {"name": "Alice"}
        task_result = {"value": expected_value}

        # Act
        actual_result = evaluate_output(output, input_data, result=task_result)

        # Assert
        assert actual_result == expected_value
