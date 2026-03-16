"""Tests for DynamoDB UpdateExpression evaluator (P1-24)."""

from __future__ import annotations

from lws.providers.dynamodb.update_expression import (
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
        # Arrange
        expected_set_count = 1
        expected_path = "name"

        # Act
        actions = parse_update_expression("SET name = :v")

        # Assert
        assert len(actions.set_actions) == expected_set_count
        actual_path = actions.set_actions[0].path
        assert actual_path == expected_path

    def test_parse_set_multiple(self) -> None:
        # Arrange
        expected_set_count = 2

        # Act
        actions = parse_update_expression("SET a = :a, b = :b")

        # Assert
        assert len(actions.set_actions) == expected_set_count

    def test_parse_remove(self) -> None:
        # Arrange
        expected_remove_count = 2

        # Act
        actions = parse_update_expression("REMOVE a, b")

        # Assert
        assert len(actions.remove_actions) == expected_remove_count

    def test_parse_add(self) -> None:
        # Arrange
        expected_add_count = 1

        # Act
        actions = parse_update_expression("ADD count :v")

        # Assert
        assert len(actions.add_actions) == expected_add_count

    def test_parse_delete(self) -> None:
        # Arrange
        expected_delete_count = 1

        # Act
        actions = parse_update_expression("DELETE tags :v")

        # Assert
        assert len(actions.delete_actions) == expected_delete_count

    def test_parse_combined(self) -> None:
        # Arrange
        expected_set_count = 1
        expected_remove_count = 1
        expected_add_count = 1
        expected_delete_count = 1

        # Act
        actions = parse_update_expression("SET a = :a REMOVE b ADD c :c DELETE d :d")

        # Assert
        assert len(actions.set_actions) == expected_set_count
        assert len(actions.remove_actions) == expected_remove_count
        assert len(actions.add_actions) == expected_add_count
        assert len(actions.delete_actions) == expected_delete_count
