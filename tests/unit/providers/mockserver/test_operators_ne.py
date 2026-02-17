"""Unit tests for the $ne operator."""

from __future__ import annotations

from lws.providers.mockserver.operators import evaluate_operator


class TestNeOperator:
    def test_ne_match(self):
        # Arrange
        expected = True

        # Act
        actual = evaluate_operator("$ne", "hello", "world")

        # Assert
        assert actual == expected

    def test_ne_no_match(self):
        # Arrange
        expected = False

        # Act
        actual = evaluate_operator("$ne", "hello", "hello")

        # Assert
        assert actual == expected
