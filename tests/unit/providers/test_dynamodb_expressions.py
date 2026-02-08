"""Tests for DynamoDB FilterExpression evaluator (P1-23)."""

from __future__ import annotations

from ldk.providers.dynamodb.expressions import (
    apply_filter_expression,
    evaluate_filter_expression,
    tokenize,
)

# ---------------------------------------------------------------------------
# Tokenizer tests
# ---------------------------------------------------------------------------


class TestTokenizer:
    """Tokenizer produces correct tokens for various expression parts."""

    def test_simple_comparison(self) -> None:
        tokens = tokenize("age = :val")
        types = [t.type for t in tokens]
        assert "IDENT" in types
        assert "OP" in types
        assert "VALUE_REF" in types
        assert types[-1] == "EOF"

    def test_name_ref(self) -> None:
        tokens = tokenize("#status = :val")
        assert tokens[0].type == "NAME_REF"
        assert tokens[0].value == "#status"

    def test_logical_keywords(self) -> None:
        tokens = tokenize("a = :x AND b = :y OR NOT c = :z")
        types = [t.type for t in tokens if t.type not in ("EOF",)]
        assert "AND" in types
        assert "OR" in types
        assert "NOT" in types

    def test_between_keyword(self) -> None:
        tokens = tokenize("age BETWEEN :lo AND :hi")
        types = [t.type for t in tokens]
        assert "BETWEEN" in types

    def test_in_keyword(self) -> None:
        tokens = tokenize("status IN (:a, :b, :c)")
        types = [t.type for t in tokens]
        assert "IN" in types
        assert "LPAREN" in types
        assert "RPAREN" in types
        assert "COMMA" in types

    def test_function_call(self) -> None:
        tokens = tokenize("attribute_exists(#name)")
        assert tokens[0].type == "IDENT"
        assert tokens[0].value == "attribute_exists"
        assert tokens[1].type == "LPAREN"


# ---------------------------------------------------------------------------
# Comparison operator tests
# ---------------------------------------------------------------------------


class TestComparisonOperators:
    """Test all comparison operators: =, <>, <, >, <=, >=."""

    def test_equals(self) -> None:
        item = {"age": 30}
        assert evaluate_filter_expression(item, "age = :v", expression_values={":v": {"N": "30"}})

    def test_not_equals(self) -> None:
        item = {"age": 30}
        assert evaluate_filter_expression(item, "age <> :v", expression_values={":v": {"N": "25"}})

    def test_less_than(self) -> None:
        item = {"age": 20}
        assert evaluate_filter_expression(item, "age < :v", expression_values={":v": {"N": "30"}})

    def test_less_than_false(self) -> None:
        item = {"age": 40}
        assert not evaluate_filter_expression(
            item, "age < :v", expression_values={":v": {"N": "30"}}
        )

    def test_greater_than(self) -> None:
        item = {"age": 40}
        assert evaluate_filter_expression(item, "age > :v", expression_values={":v": {"N": "30"}})

    def test_less_than_or_equal(self) -> None:
        item = {"age": 30}
        assert evaluate_filter_expression(item, "age <= :v", expression_values={":v": {"N": "30"}})

    def test_greater_than_or_equal(self) -> None:
        item = {"age": 30}
        assert evaluate_filter_expression(item, "age >= :v", expression_values={":v": {"N": "30"}})

    def test_string_equals(self) -> None:
        item = {"name": "Alice"}
        assert evaluate_filter_expression(
            item, "name = :v", expression_values={":v": {"S": "Alice"}}
        )

    def test_string_not_equals(self) -> None:
        item = {"name": "Alice"}
        assert evaluate_filter_expression(
            item, "name <> :v", expression_values={":v": {"S": "Bob"}}
        )

    def test_missing_attribute_returns_false(self) -> None:
        item = {"name": "Alice"}
        assert not evaluate_filter_expression(
            item, "age = :v", expression_values={":v": {"N": "30"}}
        )


# ---------------------------------------------------------------------------
# Logical operator tests
# ---------------------------------------------------------------------------


class TestLogicalOperators:
    """Test AND, OR, NOT with proper precedence."""

    def test_and_both_true(self) -> None:
        item = {"age": 30, "name": "Alice"}
        assert evaluate_filter_expression(
            item,
            "age = :age AND name = :name",
            expression_values={":age": {"N": "30"}, ":name": {"S": "Alice"}},
        )

    def test_and_one_false(self) -> None:
        item = {"age": 30, "name": "Alice"}
        assert not evaluate_filter_expression(
            item,
            "age = :age AND name = :name",
            expression_values={":age": {"N": "30"}, ":name": {"S": "Bob"}},
        )

    def test_or_one_true(self) -> None:
        item = {"age": 30, "name": "Alice"}
        assert evaluate_filter_expression(
            item,
            "age = :age OR name = :name",
            expression_values={":age": {"N": "99"}, ":name": {"S": "Alice"}},
        )

    def test_or_both_false(self) -> None:
        item = {"age": 30, "name": "Alice"}
        assert not evaluate_filter_expression(
            item,
            "age = :age OR name = :name",
            expression_values={":age": {"N": "99"}, ":name": {"S": "Bob"}},
        )

    def test_not(self) -> None:
        item = {"active": True}
        # NOT (active = :false) should be True since active != false
        assert evaluate_filter_expression(
            item,
            "NOT active = :v",
            expression_values={":v": {"BOOL": False}},
        )

    def test_not_negation(self) -> None:
        item = {"active": True}
        assert not evaluate_filter_expression(
            item,
            "NOT active = :v",
            expression_values={":v": {"BOOL": True}},
        )

    def test_precedence_and_before_or(self) -> None:
        """AND binds tighter than OR: a OR (b AND c)."""
        item = {"x": 1, "y": 2, "z": 3}
        # x=99 is false, y=2 AND z=3 is true, so OR yields true
        assert evaluate_filter_expression(
            item,
            "x = :a OR y = :b AND z = :c",
            expression_values={":a": {"N": "99"}, ":b": {"N": "2"}, ":c": {"N": "3"}},
        )

    def test_precedence_and_before_or_both_false(self) -> None:
        """x=99 false OR (y=2 AND z=99) false => false."""
        item = {"x": 1, "y": 2, "z": 3}
        assert not evaluate_filter_expression(
            item,
            "x = :a OR y = :b AND z = :c",
            expression_values={":a": {"N": "99"}, ":b": {"N": "2"}, ":c": {"N": "99"}},
        )


# ---------------------------------------------------------------------------
# BETWEEN and IN tests
# ---------------------------------------------------------------------------


class TestBetweenAndIn:
    """Test BETWEEN and IN operators."""

    def test_between_in_range(self) -> None:
        item = {"age": 25}
        assert evaluate_filter_expression(
            item,
            "age BETWEEN :lo AND :hi",
            expression_values={":lo": {"N": "20"}, ":hi": {"N": "30"}},
        )

    def test_between_at_boundary(self) -> None:
        item = {"age": 20}
        assert evaluate_filter_expression(
            item,
            "age BETWEEN :lo AND :hi",
            expression_values={":lo": {"N": "20"}, ":hi": {"N": "30"}},
        )

    def test_between_out_of_range(self) -> None:
        item = {"age": 35}
        assert not evaluate_filter_expression(
            item,
            "age BETWEEN :lo AND :hi",
            expression_values={":lo": {"N": "20"}, ":hi": {"N": "30"}},
        )

    def test_in_found(self) -> None:
        item = {"status": "active"}
        assert evaluate_filter_expression(
            item,
            "status IN (:a, :b, :c)",
            expression_values={":a": {"S": "active"}, ":b": {"S": "pending"}, ":c": {"S": "done"}},
        )

    def test_in_not_found(self) -> None:
        item = {"status": "deleted"}
        assert not evaluate_filter_expression(
            item,
            "status IN (:a, :b)",
            expression_values={":a": {"S": "active"}, ":b": {"S": "pending"}},
        )


# ---------------------------------------------------------------------------
# Function tests
# ---------------------------------------------------------------------------


class TestFunctions:
    """Test attribute_exists, attribute_not_exists, begins_with, contains, size."""

    def test_attribute_exists_true(self) -> None:
        item = {"name": "Alice"}
        assert evaluate_filter_expression(item, "attribute_exists(name)")

    def test_attribute_exists_false(self) -> None:
        item = {"name": "Alice"}
        assert not evaluate_filter_expression(item, "attribute_exists(age)")

    def test_attribute_not_exists_true(self) -> None:
        item = {"name": "Alice"}
        assert evaluate_filter_expression(item, "attribute_not_exists(age)")

    def test_attribute_not_exists_false(self) -> None:
        item = {"name": "Alice"}
        assert not evaluate_filter_expression(item, "attribute_not_exists(name)")

    def test_attribute_exists_with_name_ref(self) -> None:
        item = {"status": "active"}
        assert evaluate_filter_expression(
            item,
            "attribute_exists(#s)",
            expression_names={"#s": "status"},
        )

    def test_begins_with_true(self) -> None:
        item = {"name": "Alice"}
        assert evaluate_filter_expression(
            item,
            "begins_with(name, :prefix)",
            expression_values={":prefix": {"S": "Al"}},
        )

    def test_begins_with_false(self) -> None:
        item = {"name": "Alice"}
        assert not evaluate_filter_expression(
            item,
            "begins_with(name, :prefix)",
            expression_values={":prefix": {"S": "Bo"}},
        )

    def test_contains_string(self) -> None:
        item = {"name": "Alice in Wonderland"}
        assert evaluate_filter_expression(
            item,
            "contains(name, :sub)",
            expression_values={":sub": {"S": "Wonder"}},
        )

    def test_contains_string_false(self) -> None:
        item = {"name": "Alice"}
        assert not evaluate_filter_expression(
            item,
            "contains(name, :sub)",
            expression_values={":sub": {"S": "Bob"}},
        )

    def test_contains_list(self) -> None:
        item = {"tags": ["python", "aws", "dynamodb"]}
        assert evaluate_filter_expression(
            item,
            "contains(tags, :tag)",
            expression_values={":tag": {"S": "aws"}},
        )

    def test_size_string(self) -> None:
        item = {"name": "Alice"}
        assert evaluate_filter_expression(
            item,
            "size(name) = :v",
            expression_values={":v": {"N": "5"}},
        )

    def test_size_list(self) -> None:
        item = {"tags": ["a", "b", "c"]}
        assert evaluate_filter_expression(
            item,
            "size(tags) > :v",
            expression_values={":v": {"N": "2"}},
        )

    def test_size_missing_attr(self) -> None:
        item = {"name": "Alice"}
        # size of missing attribute is 0
        assert evaluate_filter_expression(
            item,
            "size(tags) = :v",
            expression_values={":v": {"N": "0"}},
        )


# ---------------------------------------------------------------------------
# Expression name/value resolution tests
# ---------------------------------------------------------------------------


class TestExpressionResolution:
    """Test #name and :value resolution."""

    def test_name_ref_resolution(self) -> None:
        item = {"reserved_word": "hello"}
        assert evaluate_filter_expression(
            item,
            "#rw = :v",
            expression_names={"#rw": "reserved_word"},
            expression_values={":v": {"S": "hello"}},
        )

    def test_value_ref_resolution_number(self) -> None:
        item = {"count": 42}
        assert evaluate_filter_expression(
            item,
            "count = :c",
            expression_values={":c": {"N": "42"}},
        )

    def test_value_ref_resolution_bool(self) -> None:
        item = {"active": True}
        assert evaluate_filter_expression(
            item,
            "active = :v",
            expression_values={":v": {"BOOL": True}},
        )

    def test_combined_names_and_values(self) -> None:
        item = {"status": "active", "age": 30}
        assert evaluate_filter_expression(
            item,
            "#s = :sv AND #a > :av",
            expression_names={"#s": "status", "#a": "age"},
            expression_values={":sv": {"S": "active"}, ":av": {"N": "20"}},
        )


# ---------------------------------------------------------------------------
# apply_filter_expression tests
# ---------------------------------------------------------------------------


class TestApplyFilterExpression:
    """Test the batch filtering function."""

    def test_none_expression_returns_all(self) -> None:
        items = [{"a": 1}, {"a": 2}]
        assert apply_filter_expression(items, None) == items

    def test_empty_expression_returns_all(self) -> None:
        items = [{"a": 1}, {"a": 2}]
        assert apply_filter_expression(items, "") == items

    def test_filters_items(self) -> None:
        items = [
            {"name": "Alice", "age": 30},
            {"name": "Bob", "age": 25},
            {"name": "Charlie", "age": 35},
        ]
        result = apply_filter_expression(
            items,
            "age > :min",
            expression_values={":min": {"N": "28"}},
        )
        assert len(result) == 2
        names = {r["name"] for r in result}
        assert names == {"Alice", "Charlie"}

    def test_complex_filter(self) -> None:
        items = [
            {"name": "Alice", "age": 30, "active": True},
            {"name": "Bob", "age": 25, "active": False},
            {"name": "Charlie", "age": 35, "active": True},
        ]
        result = apply_filter_expression(
            items,
            "active = :t AND age >= :min",
            expression_values={":t": {"BOOL": True}, ":min": {"N": "30"}},
        )
        assert len(result) == 2
        names = {r["name"] for r in result}
        assert names == {"Alice", "Charlie"}
