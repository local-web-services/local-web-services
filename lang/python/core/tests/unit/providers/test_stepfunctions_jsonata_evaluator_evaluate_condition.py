"""Tests for evaluate_condition."""

from __future__ import annotations

from lws.providers.stepfunctions.jsonata_evaluator import evaluate_condition


class TestEvaluateCondition:
    def test_expression_returning_true(self) -> None:
        # Arrange
        expected_result = True
        condition = "{% $states.input.score > 50 %}"
        input_data = {"score": 75}

        # Act
        actual_result = evaluate_condition(condition, input_data)

        # Assert
        assert actual_result == expected_result

    def test_expression_returning_false(self) -> None:
        # Arrange
        expected_result = False
        condition = "{% $states.input.score > 50 %}"
        input_data = {"score": 30}

        # Act
        actual_result = evaluate_condition(condition, input_data)

        # Assert
        assert actual_result == expected_result

    def test_bare_expression_without_delimiters(self) -> None:
        # Arrange
        expected_result = True
        condition = "$states.input.active = true"
        input_data = {"active": True}

        # Act
        actual_result = evaluate_condition(condition, input_data)

        # Assert
        assert actual_result == expected_result

    def test_condition_with_variables(self) -> None:
        # Arrange
        expected_result = True
        condition = "{% $states.input.x > $states.context.variables.threshold %}"
        input_data = {"x": 100}
        variables = {"threshold": 50}

        # Act
        actual_result = evaluate_condition(condition, input_data, variables=variables)

        # Assert
        assert actual_result == expected_result
