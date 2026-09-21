"""Tests for is_jsonata_expression."""

from __future__ import annotations

from lws.providers.stepfunctions.jsonata_evaluator import is_jsonata_expression


class TestIsJsonataExpression:
    def test_detects_expression_syntax(self) -> None:
        # Arrange
        expected_result = True
        value = "{% $.name %}"

        # Act
        actual_result = is_jsonata_expression(value)

        # Assert
        assert actual_result == expected_result

    def test_rejects_plain_string(self) -> None:
        # Arrange
        expected_result = False
        value = "plain string"

        # Act
        actual_result = is_jsonata_expression(value)

        # Assert
        assert actual_result == expected_result

    def test_rejects_partial_open_only(self) -> None:
        # Arrange
        expected_result = False
        value = "{% not closed"

        # Act
        actual_result = is_jsonata_expression(value)

        # Assert
        assert actual_result == expected_result
