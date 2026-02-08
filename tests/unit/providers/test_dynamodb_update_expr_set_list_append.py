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


class TestSetListAppend:
    """Test SET with list_append function."""

    def test_list_append_to_existing(self) -> None:
        item = {"pk": "1", "tags": ["a", "b"]}
        result = apply_update_expression(
            item,
            "SET tags = list_append(tags, :new)",
            expression_values={":new": {"L": [{"S": "c"}]}},
        )
        assert result["tags"] == ["a", "b", "c"]

    def test_list_append_prepend(self) -> None:
        item = {"pk": "1", "tags": ["b", "c"]}
        result = apply_update_expression(
            item,
            "SET tags = list_append(:new, tags)",
            expression_values={":new": {"L": [{"S": "a"}]}},
        )
        assert result["tags"] == ["a", "b", "c"]

    def test_list_append_to_missing(self) -> None:
        item = {"pk": "1"}
        result = apply_update_expression(
            item,
            "SET tags = list_append(tags, :new)",
            expression_values={":new": {"L": [{"S": "a"}]}},
        )
        assert result["tags"] == ["a"]
