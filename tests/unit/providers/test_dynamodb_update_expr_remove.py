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


class TestRemove:
    """Test REMOVE clause."""

    def test_remove_existing_attribute(self) -> None:
        # Arrange
        item = {"pk": "1", "temp": "value", "keep": "yes"}
        expected_keep = "yes"

        # Act
        result = apply_update_expression(item, "REMOVE temp")

        # Assert
        assert "temp" not in result
        actual_keep = result["keep"]
        assert actual_keep == expected_keep

    def test_remove_multiple_attributes(self) -> None:
        # Arrange
        item = {"pk": "1", "a": 1, "b": 2, "c": 3}
        expected_c = 3

        # Act
        result = apply_update_expression(item, "REMOVE a, b")

        # Assert
        assert "a" not in result
        assert "b" not in result
        actual_c = result["c"]
        assert actual_c == expected_c

    def test_remove_nonexistent_no_error(self) -> None:
        # Arrange
        item = {"pk": "1", "a": 1}
        expected_result = {"pk": "1", "a": 1}

        # Act
        result = apply_update_expression(item, "REMOVE missing")

        # Assert
        assert result == expected_result

    def test_remove_with_name_ref(self) -> None:
        item = {"pk": "1", "reserved": "value"}
        result = apply_update_expression(
            item,
            "REMOVE #r",
            expression_names={"#r": "reserved"},
        )
        assert "reserved" not in result
