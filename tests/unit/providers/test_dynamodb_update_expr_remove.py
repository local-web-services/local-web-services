"""Tests for DynamoDB UpdateExpression evaluator (P1-24)."""

from __future__ import annotations

from ldk.providers.dynamodb.update_expression import (
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
        item = {"pk": "1", "temp": "value", "keep": "yes"}
        result = apply_update_expression(item, "REMOVE temp")
        assert "temp" not in result
        assert result["keep"] == "yes"

    def test_remove_multiple_attributes(self) -> None:
        item = {"pk": "1", "a": 1, "b": 2, "c": 3}
        result = apply_update_expression(item, "REMOVE a, b")
        assert "a" not in result
        assert "b" not in result
        assert result["c"] == 3

    def test_remove_nonexistent_no_error(self) -> None:
        item = {"pk": "1", "a": 1}
        result = apply_update_expression(item, "REMOVE missing")
        assert result == {"pk": "1", "a": 1}

    def test_remove_with_name_ref(self) -> None:
        item = {"pk": "1", "reserved": "value"}
        result = apply_update_expression(
            item,
            "REMOVE #r",
            expression_names={"#r": "reserved"},
        )
        assert "reserved" not in result
