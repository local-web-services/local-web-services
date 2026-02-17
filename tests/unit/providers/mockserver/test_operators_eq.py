"""Unit tests for the $eq operator."""

from __future__ import annotations

from lws.providers.mockserver.operators import evaluate_operator


class TestEqOperator:
    def test_eq_match(self):
        # Arrange
        expected = True

        # Act
        actual = evaluate_operator("$eq", "hello", "hello")

        # Assert
        assert actual == expected

    def test_eq_no_match(self):
        # Arrange
        expected = False

        # Act
        actual = evaluate_operator("$eq", "hello", "world")

        # Assert
        assert actual == expected
