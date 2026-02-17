"""Unit tests for numeric comparison operators ($gt, $gte, $lt, $lte)."""

from __future__ import annotations

from lws.providers.mockserver.operators import evaluate_operator


class TestNumericOperators:
    def test_gt_match(self):
        # Arrange
        expected = True

        # Act
        actual = evaluate_operator("$gt", 10, 5)

        # Assert
        assert actual == expected

    def test_gt_no_match(self):
        # Arrange
        expected = False

        # Act
        actual = evaluate_operator("$gt", 5, 10)

        # Assert
        assert actual == expected

    def test_gte_equal(self):
        # Arrange
        expected = True

        # Act
        actual = evaluate_operator("$gte", 5, 5)

        # Assert
        assert actual == expected

    def test_lt_match(self):
        # Arrange
        expected = True

        # Act
        actual = evaluate_operator("$lt", 3, 10)

        # Assert
        assert actual == expected

    def test_lte_equal(self):
        # Arrange
        expected = True

        # Act
        actual = evaluate_operator("$lte", 10, 10)

        # Assert
        assert actual == expected

    def test_numeric_with_non_numeric(self):
        # Arrange
        expected = False

        # Act
        actual = evaluate_operator("$gt", "abc", 5)

        # Assert
        assert actual == expected
