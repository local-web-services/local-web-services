"""Unit tests for the $regex operator."""

from __future__ import annotations

from lws.providers.mockserver.operators import evaluate_operator


class TestRegexOperator:
    def test_regex_match(self):
        # Arrange
        expected = True

        # Act
        actual = evaluate_operator("$regex", "pay_12345", r"pay_\d+")

        # Assert
        assert actual == expected

    def test_regex_no_match(self):
        # Arrange
        expected = False

        # Act
        actual = evaluate_operator("$regex", "order_abc", r"pay_\d+")

        # Assert
        assert actual == expected

    def test_regex_none_actual(self):
        # Arrange
        expected = False

        # Act
        actual = evaluate_operator("$regex", None, r".*")

        # Assert
        assert actual == expected
