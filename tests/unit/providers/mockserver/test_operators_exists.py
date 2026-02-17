"""Unit tests for the $exists operator."""

from __future__ import annotations

from lws.providers.mockserver.operators import evaluate_operator


class TestExistsOperator:
    def test_exists_true(self):
        # Arrange
        expected = True

        # Act
        actual = evaluate_operator("$exists", "value", True)

        # Assert
        assert actual == expected

    def test_exists_false(self):
        # Arrange
        expected = True

        # Act
        actual = evaluate_operator("$exists", None, False)

        # Assert
        assert actual == expected
