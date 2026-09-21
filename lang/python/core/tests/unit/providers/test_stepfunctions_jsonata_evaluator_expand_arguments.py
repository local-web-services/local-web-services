"""Tests for expand_arguments."""

from __future__ import annotations

from lws.providers.stepfunctions.jsonata_evaluator import expand_arguments


class TestExpandArguments:
    def test_expands_expression_value(self) -> None:
        # Arrange
        expected_name = "Alice"
        arguments = {"name": "{% $states.input.name %}"}
        input_data = {"name": expected_name}

        # Act
        actual_result = expand_arguments(arguments, input_data)

        # Assert
        assert actual_result["name"] == expected_name

    def test_preserves_literal_string(self) -> None:
        # Arrange
        expected_value = "literal"
        arguments = {"key": expected_value}
        input_data = {"anything": 1}

        # Act
        actual_result = expand_arguments(arguments, input_data)

        # Assert
        assert actual_result["key"] == expected_value

    def test_mixed_literal_and_expression(self) -> None:
        # Arrange
        expected_label = "fixed"
        expected_name = "Alice"
        arguments = {"label": expected_label, "name": "{% $states.input.raw %}"}
        input_data = {"raw": expected_name}

        # Act
        actual_result = expand_arguments(arguments, input_data)

        # Assert
        assert actual_result["label"] == expected_label
        assert actual_result["name"] == expected_name
