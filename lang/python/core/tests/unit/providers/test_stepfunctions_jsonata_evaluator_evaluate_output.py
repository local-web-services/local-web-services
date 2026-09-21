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

    def test_dict_output_evaluates_expression_values(self) -> None:
        # Arrange
        expected_output = {"key": 42, "label": "fixed"}
        output = {"key": "{% $states.input.x %}", "label": "fixed"}
        input_data = {"x": 42}

        # Act
        actual_result = evaluate_output(output, input_data)

        # Assert
        assert actual_result == expected_output

    def test_dict_output_evaluates_task_result_expressions(self) -> None:
        # Arrange
        expected_output = {"value": "done"}
        output = {"value": "{% $states.result.v %}"}
        input_data = {}
        task_result = {"v": "done"}

        # Act
        actual_result = evaluate_output(output, input_data, result=task_result)

        # Assert
        assert actual_result == expected_output

    def test_dict_output_mixed_literal_and_expression(self) -> None:
        # Arrange
        expected_name = "Alice"
        expected_status = "active"
        output = {"name": "{% $states.input.name %}", "status": expected_status}
        input_data = {"name": expected_name}

        # Act
        actual_result = evaluate_output(output, input_data)

        # Assert
        assert actual_result["name"] == expected_name
        assert actual_result["status"] == expected_status
