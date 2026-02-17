"""Unit tests for the $in operator."""

from __future__ import annotations

from lws.providers.mockserver.operators import evaluate_operator


class TestInOperator:
    def test_in_match(self):
        # Arrange
        expected = True

        # Act
        actual = evaluate_operator("$in", "a", ["a", "b", "c"])

        # Assert
        assert actual == expected

    def test_in_no_match(self):
        # Arrange
        expected = False

        # Act
        actual = evaluate_operator("$in", "d", ["a", "b", "c"])

        # Assert
        assert actual == expected

    def test_in_non_list(self):
        # Arrange
        expected = False

        # Act
        actual = evaluate_operator("$in", "a", "abc")

        # Assert
        assert actual == expected
