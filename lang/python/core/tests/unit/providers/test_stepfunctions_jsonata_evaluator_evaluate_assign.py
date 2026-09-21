"""Tests for evaluate_assign."""

from __future__ import annotations

from lws.providers.stepfunctions.jsonata_evaluator import evaluate_assign


class TestEvaluateAssign:
    def test_expression_value_is_evaluated(self) -> None:
        # Arrange
        expected_var = 42
        assign = {"myVar": "{% $states.input.x %}"}
        input_data = {"x": 42}

        # Act
        actual_result = evaluate_assign(assign, input_data)

        # Assert
        assert actual_result["myVar"] == expected_var

    def test_literal_value_is_stored_as_is(self) -> None:
        # Arrange
        expected_value = "fixed"
        assign = {"label": expected_value}
        input_data = {}

        # Act
        actual_result = evaluate_assign(assign, input_data)

        # Assert
        assert actual_result["label"] == expected_value

    def test_multiple_keys_evaluated_independently(self) -> None:
        # Arrange
        expected_a = "hello"
        expected_b = 99
        assign = {"a": "{% $states.input.name %}", "b": "{% $states.input.count %}"}
        input_data = {"name": "hello", "count": 99}

        # Act
        actual_result = evaluate_assign(assign, input_data)

        # Assert
        assert actual_result["a"] == expected_a
        assert actual_result["b"] == expected_b

    def test_assign_with_existing_variables_in_context(self) -> None:
        # Arrange
        expected_sum = 15
        assign = {"total": "{% $states.input.x + $states.context.variables.base %}"}
        input_data = {"x": 10}
        variables = {"base": 5}

        # Act
        actual_result = evaluate_assign(assign, input_data, variables=variables)

        # Assert
        assert actual_result["total"] == expected_sum
