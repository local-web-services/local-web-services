"""Tests for evaluate_expression variable binding ($varName vs $states.context.variables)."""

from __future__ import annotations

from lws.providers.stepfunctions.jsonata_evaluator import evaluate_expression


class TestEvaluateExpressionVariableBinding:
    def test_variable_accessible_as_dollar_name(self) -> None:
        # Arrange
        expected_value = 42
        variables = {"myVar": 42}

        # Act
        actual_value = evaluate_expression("$myVar", {}, variables=variables)

        # Assert
        assert actual_value == expected_value

    def test_dollar_name_equals_states_context_variables_path(self) -> None:
        # Arrange
        expected_value = "hello"
        variables = {"greeting": "hello"}

        # Act
        actual_via_dollar = evaluate_expression("$greeting", {}, variables=variables)
        actual_via_context = evaluate_expression(
            "$states.context.variables.greeting", {}, variables=variables
        )

        # Assert
        assert actual_via_dollar == expected_value
        assert actual_via_context == expected_value
        assert actual_via_dollar == actual_via_context
