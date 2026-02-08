"""Tests for DynamoDB UpdateExpression evaluator (P1-24)."""

from __future__ import annotations

from ldk.providers.dynamodb.update_expression import (
    apply_update_expression,
    parse_update_expression,
)

# ---------------------------------------------------------------------------
# SET: regular assignment
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


# ---------------------------------------------------------------------------
# SET: if_not_exists
# ---------------------------------------------------------------------------


class TestSetIfNotExists:
    """Test SET with if_not_exists function."""

    def test_if_not_exists_attribute_missing(self) -> None:
        item = {"pk": "1"}
        result = apply_update_expression(
            item,
            "SET count = if_not_exists(count, :default)",
            expression_values={":default": {"N": "0"}},
        )
        assert result["count"] == 0

    def test_if_not_exists_attribute_present(self) -> None:
        item = {"pk": "1", "count": 5}
        result = apply_update_expression(
            item,
            "SET count = if_not_exists(count, :default)",
            expression_values={":default": {"N": "0"}},
        )
        assert result["count"] == 5

    def test_if_not_exists_with_arithmetic(self) -> None:
        item = {"pk": "1"}
        result = apply_update_expression(
            item,
            "SET count = if_not_exists(count, :zero) + :inc",
            expression_values={":zero": {"N": "0"}, ":inc": {"N": "1"}},
        )
        assert result["count"] == 1


# ---------------------------------------------------------------------------
# SET: list_append
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


# ---------------------------------------------------------------------------
# SET: arithmetic
# ---------------------------------------------------------------------------


class TestSetArithmetic:
    """Test SET with arithmetic (+, -)."""

    def test_add_to_number(self) -> None:
        item = {"pk": "1", "count": 10}
        result = apply_update_expression(
            item,
            "SET count = count + :inc",
            expression_values={":inc": {"N": "5"}},
        )
        assert result["count"] == 15

    def test_subtract_from_number(self) -> None:
        item = {"pk": "1", "count": 10}
        result = apply_update_expression(
            item,
            "SET count = count - :dec",
            expression_values={":dec": {"N": "3"}},
        )
        assert result["count"] == 7

    def test_add_with_value_refs(self) -> None:
        item = {"pk": "1", "price": 100}
        result = apply_update_expression(
            item,
            "SET price = price + :tax",
            expression_values={":tax": {"N": "15"}},
        )
        assert result["price"] == 115


# ---------------------------------------------------------------------------
# REMOVE
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


# ---------------------------------------------------------------------------
# ADD
# ---------------------------------------------------------------------------


class TestAdd:
    """Test ADD clause: add to number or set."""

    def test_add_to_number(self) -> None:
        item = {"pk": "1", "count": 10}
        result = apply_update_expression(
            item,
            "ADD count :inc",
            expression_values={":inc": {"N": "5"}},
        )
        assert result["count"] == 15

    def test_add_creates_number_if_missing(self) -> None:
        item = {"pk": "1"}
        result = apply_update_expression(
            item,
            "ADD count :v",
            expression_values={":v": {"N": "1"}},
        )
        assert result["count"] == 1

    def test_add_to_set(self) -> None:
        item = {"pk": "1", "tags": {"python", "aws"}}
        result = apply_update_expression(
            item,
            "ADD tags :new",
            expression_values={":new": {"SS": ["dynamodb"]}},
        )
        assert result["tags"] == {"python", "aws", "dynamodb"}

    def test_add_creates_set_if_missing(self) -> None:
        item = {"pk": "1"}
        result = apply_update_expression(
            item,
            "ADD tags :new",
            expression_values={":new": {"SS": ["hello"]}},
        )
        assert result["tags"] == {"hello"}

    def test_add_number_set(self) -> None:
        item = {"pk": "1", "numbers": {1, 2, 3}}
        result = apply_update_expression(
            item,
            "ADD numbers :new",
            expression_values={":new": {"NS": ["4", "5"]}},
        )
        assert result["numbers"] == {1, 2, 3, 4, 5}


# ---------------------------------------------------------------------------
# DELETE (from set)
# ---------------------------------------------------------------------------


class TestDelete:
    """Test DELETE clause: remove elements from a set."""

    def test_delete_from_string_set(self) -> None:
        item = {"pk": "1", "tags": {"python", "aws", "dynamodb"}}
        result = apply_update_expression(
            item,
            "DELETE tags :rem",
            expression_values={":rem": {"SS": ["aws"]}},
        )
        assert result["tags"] == {"python", "dynamodb"}

    def test_delete_from_number_set(self) -> None:
        item = {"pk": "1", "numbers": {1, 2, 3, 4, 5}}
        result = apply_update_expression(
            item,
            "DELETE numbers :rem",
            expression_values={":rem": {"NS": ["2", "4"]}},
        )
        assert result["numbers"] == {1, 3, 5}

    def test_delete_nonexistent_elements(self) -> None:
        item = {"pk": "1", "tags": {"python", "aws"}}
        result = apply_update_expression(
            item,
            "DELETE tags :rem",
            expression_values={":rem": {"SS": ["nonexistent"]}},
        )
        assert result["tags"] == {"python", "aws"}

    def test_delete_from_missing_attribute(self) -> None:
        item = {"pk": "1"}
        result = apply_update_expression(
            item,
            "DELETE tags :rem",
            expression_values={":rem": {"SS": ["a"]}},
        )
        # No error, attribute just not there
        assert "tags" not in result


# ---------------------------------------------------------------------------
# Combined clauses
# ---------------------------------------------------------------------------


class TestCombinedClauses:
    """Test combined SET, REMOVE, ADD, DELETE in a single expression."""

    def test_set_and_remove(self) -> None:
        item = {"pk": "1", "a": 1, "b": 2}
        result = apply_update_expression(
            item,
            "SET a = :v REMOVE b",
            expression_values={":v": {"N": "99"}},
        )
        assert result["a"] == 99
        assert "b" not in result

    def test_set_remove_add(self) -> None:
        item = {"pk": "1", "name": "old", "temp": "gone", "count": 5}
        result = apply_update_expression(
            item,
            "SET name = :n REMOVE temp ADD count :inc",
            expression_values={":n": {"S": "new"}, ":inc": {"N": "1"}},
        )
        assert result["name"] == "new"
        assert "temp" not in result
        assert result["count"] == 6

    def test_all_four_clauses(self) -> None:
        item = {
            "pk": "1",
            "name": "old",
            "temp": "gone",
            "count": 10,
            "tags": {"a", "b", "c"},
        }
        result = apply_update_expression(
            item,
            "SET name = :n REMOVE temp ADD count :inc DELETE tags :rem",
            expression_values={
                ":n": {"S": "new"},
                ":inc": {"N": "5"},
                ":rem": {"SS": ["b"]},
            },
        )
        assert result["name"] == "new"
        assert "temp" not in result
        assert result["count"] == 15
        assert result["tags"] == {"a", "c"}


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
