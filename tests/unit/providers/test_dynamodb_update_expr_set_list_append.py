"""Tests for DynamoDB UpdateExpression evaluator (P1-24)."""

from __future__ import annotations

from lws.providers.dynamodb.update_expression import (
    apply_update_expression,
)

# ---------------------------------------------------------------------------
# SET: regular assignment
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# SET: if_not_exists
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# SET: list_append
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# SET: arithmetic
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# REMOVE
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# ADD
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# DELETE (from set)
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Combined clauses
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Parser tests
# ---------------------------------------------------------------------------


class TestSetListAppend:
    """Test SET with list_append function."""

    def test_list_append_to_existing(self) -> None:
        # Arrange
        item = {"pk": "1", "tags": ["a", "b"]}
        expected_tags = ["a", "b", "c"]

        # Act
        result = apply_update_expression(
            item,
            "SET tags = list_append(tags, :new)",
            expression_values={":new": {"L": [{"S": "c"}]}},
        )

        # Assert
        actual_tags = result["tags"]
        assert actual_tags == expected_tags

    def test_list_append_prepend(self) -> None:
        # Arrange
        item = {"pk": "1", "tags": ["b", "c"]}
        expected_tags = ["a", "b", "c"]

        # Act
        result = apply_update_expression(
            item,
            "SET tags = list_append(:new, tags)",
            expression_values={":new": {"L": [{"S": "a"}]}},
        )

        # Assert
        actual_tags = result["tags"]
        assert actual_tags == expected_tags

    def test_list_append_to_missing(self) -> None:
        # Arrange
        item = {"pk": "1"}
        expected_tags = ["a"]

        # Act
        result = apply_update_expression(
            item,
            "SET tags = list_append(tags, :new)",
            expression_values={":new": {"L": [{"S": "a"}]}},
        )

        # Assert
        actual_tags = result["tags"]
        assert actual_tags == expected_tags
