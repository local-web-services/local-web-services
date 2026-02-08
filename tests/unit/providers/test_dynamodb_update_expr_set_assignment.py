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


class TestSetAssignment:
    """Test basic SET assignments."""

    def test_set_simple_string(self) -> None:
        item = {"pk": "1", "name": "Alice"}
        result = apply_update_expression(
            item,
            "SET name = :v",
            expression_values={":v": {"S": "Bob"}},
        )
        assert result["name"] == "Bob"

    def test_set_number(self) -> None:
        item = {"pk": "1", "count": 5}
        result = apply_update_expression(
            item,
            "SET count = :v",
            expression_values={":v": {"N": "10"}},
        )
        assert result["count"] == 10

    def test_set_new_attribute(self) -> None:
        item = {"pk": "1"}
        result = apply_update_expression(
            item,
            "SET color = :v",
            expression_values={":v": {"S": "red"}},
        )
        assert result["color"] == "red"

    def test_set_multiple_attributes(self) -> None:
        item = {"pk": "1"}
        result = apply_update_expression(
            item,
            "SET a = :a, b = :b",
            expression_values={":a": {"S": "alpha"}, ":b": {"S": "beta"}},
        )
        assert result["a"] == "alpha"
        assert result["b"] == "beta"

    def test_set_with_name_ref(self) -> None:
        item = {"pk": "1", "reserved": "old"}
        result = apply_update_expression(
            item,
            "SET #r = :v",
            expression_names={"#r": "reserved"},
            expression_values={":v": {"S": "new"}},
        )
        assert result["reserved"] == "new"
