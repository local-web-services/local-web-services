"""Unit tests for the $eq operator."""

from __future__ import annotations

from lws.providers.fakeserver.operators import evaluate_operator


class TestEqOperator:
    def test_eq_match(self):
        # Arrange
        expected = True

        # Act
        actual = evaluate_operator("$eq", "hello", "hello")

        # Assert
        assert actual == expected, f"Expected {expected!r} but got {actual!r}"

    def test_eq_no_match(self):
        # Arrange
        expected = False

        # Act
        actual = evaluate_operator("$eq", "hello", "world")

        # Assert
        assert actual == expected, f"Expected {expected!r} but got {actual!r}"
