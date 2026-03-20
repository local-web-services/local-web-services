"""Tests for DynamoDB FilterExpression evaluator (P1-23)."""

from __future__ import annotations

from lws.providers.dynamodb.expressions import (
    tokenize,
)

# ---------------------------------------------------------------------------
# Tokenizer tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Comparison operator tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Logical operator tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# BETWEEN and IN tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Function tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Expression name/value resolution tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# apply_filter_expression tests
# ---------------------------------------------------------------------------


class TestTokenizer:
    """Tokenizer produces correct tokens for various expression parts."""

    def test_simple_comparison(self) -> None:
        # Arrange
        expected_last_type = "EOF"

        # Act
        tokens = tokenize("age = :val")

        # Assert
        types = [t.type for t in tokens]
        assert "IDENT" in types, f'Expected {"IDENT"!r} to be in {types!r}'
        assert "OP" in types, f'Expected {"OP"!r} to be in {types!r}'
        assert "VALUE_REF" in types, f'Expected {"VALUE_REF"!r} to be in {types!r}'
        assert types[-1] == expected_last_type, f"Expected {expected_last_type!r} but got {types[-1]!r}"

    def test_name_ref(self) -> None:
        # Arrange
        expected_type = "NAME_REF"
        expected_value = "#status"

        # Act
        tokens = tokenize("#status = :val")

        # Assert
        actual_type = tokens[0].type
        actual_value = tokens[0].value
        assert actual_type == expected_type, f"Expected {expected_type!r} but got {actual_type!r}"
        assert actual_value == expected_value, f"Expected {expected_value!r} but got {actual_value!r}"

    def test_logical_keywords(self) -> None:
        # Act
        tokens = tokenize("a = :x AND b = :y OR NOT c = :z")

        # Assert
        types = [t.type for t in tokens if t.type not in ("EOF",)]
        assert "AND" in types, f'Expected {"AND"!r} to be in {types!r}'
        assert "OR" in types, f'Expected {"OR"!r} to be in {types!r}'
        assert "NOT" in types, f'Expected {"NOT"!r} to be in {types!r}'

    def test_between_keyword(self) -> None:
        # Act
        tokens = tokenize("age BETWEEN :lo AND :hi")

        # Assert
        types = [t.type for t in tokens]
        assert "BETWEEN" in types, f'Expected {"BETWEEN"!r} to be in {types!r}'

    def test_in_keyword(self) -> None:
        # Act
        tokens = tokenize("status IN (:a, :b, :c)")

        # Assert
        types = [t.type for t in tokens]
        assert "IN" in types, f'Expected {"IN"!r} to be in {types!r}'
        assert "LPAREN" in types, f'Expected {"LPAREN"!r} to be in {types!r}'
        assert "RPAREN" in types, f'Expected {"RPAREN"!r} to be in {types!r}'
        assert "COMMA" in types, f'Expected {"COMMA"!r} to be in {types!r}'

    def test_function_call(self) -> None:
        # Arrange
        expected_first_type = "IDENT"
        expected_first_value = "attribute_exists"
        expected_second_type = "LPAREN"

        # Act
        tokens = tokenize("attribute_exists(#name)")

        # Assert
        actual_first_type = tokens[0].type
        actual_first_value = tokens[0].value
        actual_second_type = tokens[1].type
        assert actual_first_type == expected_first_type, f"Expected {expected_first_type!r} but got {actual_first_type!r}"
        assert actual_first_value == expected_first_value, f"Expected {expected_first_value!r} but got {actual_first_value!r}"
        assert actual_second_type == expected_second_type, f"Expected {expected_second_type!r} but got {actual_second_type!r}"
