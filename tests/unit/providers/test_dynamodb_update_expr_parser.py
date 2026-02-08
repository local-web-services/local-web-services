"""Tests for DynamoDB UpdateExpression evaluator (P1-24)."""

from __future__ import annotations

from ldk.providers.dynamodb.update_expression import (
    parse_update_expression,
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


class TestParser:
    """Test the parser produces correct action structures."""

    def test_parse_set_single(self) -> None:
        actions = parse_update_expression("SET name = :v")
        assert len(actions.set_actions) == 1
        assert actions.set_actions[0].path == "name"

    def test_parse_set_multiple(self) -> None:
        actions = parse_update_expression("SET a = :a, b = :b")
        assert len(actions.set_actions) == 2

    def test_parse_remove(self) -> None:
        actions = parse_update_expression("REMOVE a, b")
        assert len(actions.remove_actions) == 2

    def test_parse_add(self) -> None:
        actions = parse_update_expression("ADD count :v")
        assert len(actions.add_actions) == 1

    def test_parse_delete(self) -> None:
        actions = parse_update_expression("DELETE tags :v")
        assert len(actions.delete_actions) == 1

    def test_parse_combined(self) -> None:
        actions = parse_update_expression("SET a = :a REMOVE b ADD c :c DELETE d :d")
        assert len(actions.set_actions) == 1
        assert len(actions.remove_actions) == 1
        assert len(actions.add_actions) == 1
        assert len(actions.delete_actions) == 1
