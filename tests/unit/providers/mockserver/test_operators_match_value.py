"""Unit tests for the match_value function."""

from __future__ import annotations

from lws.providers.mockserver.operators import evaluate_operator, match_value


class TestMatchValue:
    def test_exact_match(self):
        # Arrange
        expected = True

        # Act
        actual = match_value("hello", "hello")

        # Assert
        assert actual == expected

    def test_operator_dict(self):
        # Arrange
        expected = True

        # Act
        actual = match_value(10, {"$gt": 5, "$lt": 20})

        # Assert
        assert actual == expected

    def test_operator_dict_partial_fail(self):
        # Arrange
        expected = False

        # Act
        actual = match_value(10, {"$gt": 5, "$lt": 8})

        # Assert
        assert actual == expected

    def test_unknown_operator(self):
        # Arrange
        expected = False

        # Act
        actual = evaluate_operator("$unknown", "a", "b")

        # Assert
        assert actual == expected
