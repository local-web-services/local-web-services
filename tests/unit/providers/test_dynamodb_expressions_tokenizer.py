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
