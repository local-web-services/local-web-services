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
        assert "IDENT" in types
        assert "OP" in types
        assert "VALUE_REF" in types
        assert types[-1] == expected_last_type

    def test_name_ref(self) -> None:
        # Arrange
        expected_type = "NAME_REF"
        expected_value = "#status"

        # Act
        tokens = tokenize("#status = :val")

        # Assert
        actual_type = tokens[0].type
        actual_value = tokens[0].value
        assert actual_type == expected_type
        assert actual_value == expected_value

    def test_logical_keywords(self) -> None:
        # Act
        tokens = tokenize("a = :x AND b = :y OR NOT c = :z")

        # Assert
        types = [t.type for t in tokens if t.type not in ("EOF",)]
        assert "AND" in types
        assert "OR" in types
        assert "NOT" in types

    def test_between_keyword(self) -> None:
        # Act
        tokens = tokenize("age BETWEEN :lo AND :hi")

        # Assert
        types = [t.type for t in tokens]
        assert "BETWEEN" in types

    def test_in_keyword(self) -> None:
        # Act
        tokens = tokenize("status IN (:a, :b, :c)")

        # Assert
        types = [t.type for t in tokens]
        assert "IN" in types
        assert "LPAREN" in types
        assert "RPAREN" in types
        assert "COMMA" in types

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
        assert actual_first_type == expected_first_type
        assert actual_first_value == expected_first_value
        assert actual_second_type == expected_second_type
