"""Tests for extract_expression."""

from __future__ import annotations

from lws.providers.stepfunctions.jsonata_evaluator import extract_expression


class TestExtractExpression:
    def test_strips_delimiters(self) -> None:
        # Arrange
        expected_expression = "$.name"
        value = "{% $.name %}"

        # Act
        actual_expression = extract_expression(value)

        # Assert
        assert actual_expression == expected_expression

    def test_strips_surrounding_whitespace(self) -> None:
        # Arrange
        expected_expression = "$states.input.key"
        value = "{%   $states.input.key   %}"

        # Act
        actual_expression = extract_expression(value)

        # Assert
        assert actual_expression == expected_expression
