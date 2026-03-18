"""Lexer for DynamoDB filter expressions."""

from __future__ import annotations

import re

from lws.providers.dynamodb.parser_base import Token, scan_number_literal

# ---------------------------------------------------------------------------
# Token types
# ---------------------------------------------------------------------------

TOKEN_IDENT = "IDENT"
TOKEN_VALUE_REF = "VALUE_REF"
TOKEN_NAME_REF = "NAME_REF"
TOKEN_NUMBER = "NUMBER"
TOKEN_STRING = "STRING"
TOKEN_COMMA = "COMMA"
TOKEN_LPAREN = "LPAREN"
TOKEN_RPAREN = "RPAREN"
TOKEN_OP = "OP"
TOKEN_AND = "AND"
TOKEN_OR = "OR"
TOKEN_NOT = "NOT"
TOKEN_BETWEEN = "BETWEEN"
TOKEN_IN = "IN"
TOKEN_EOF = "EOF"

_KEYWORDS = {"AND", "OR", "NOT", "BETWEEN", "IN"}

_OPERATOR_RE = re.compile(r"<>|<=|>=|[=<>]")


# ---------------------------------------------------------------------------
# Lexer
# ---------------------------------------------------------------------------


def tokenize(expression: str) -> list[Token]:
    """Tokenize a DynamoDB filter expression into a list of tokens."""
    tokens: list[Token] = []
    i = 0
    length = len(expression)

    while i < length:
        ch = expression[i]

        if ch.isspace():
            i += 1
            continue

        if ch == ",":
            tokens.append(Token(TOKEN_COMMA, ",", i))
            i += 1
            continue

        if ch == "(":
            tokens.append(Token(TOKEN_LPAREN, "(", i))
            i += 1
            continue

        if ch == ")":
            tokens.append(Token(TOKEN_RPAREN, ")", i))
            i += 1
            continue

        token, i = _try_operator(expression, i, tokens)
        if token:
            continue

        token, i = _try_value_ref(expression, i, tokens)
        if token:
            continue

        token, i = _try_name_ref(expression, i, tokens)
        if token:
            continue

        token, i = _try_number_literal(expression, i, tokens)
        if token:
            continue

        # Identifier or keyword
        i = _scan_identifier(expression, i, tokens)

    tokens.append(Token(TOKEN_EOF, "", length))
    return tokens


def _try_operator(expression: str, i: int, tokens: list[Token]) -> tuple[Token | None, int]:
    """Try to scan a comparison operator at position i."""
    m = _OPERATOR_RE.match(expression, i)
    if m:
        tok = Token(TOKEN_OP, m.group(), i)
        tokens.append(tok)
        return tok, m.end()
    return None, i


def _try_value_ref(expression: str, i: int, tokens: list[Token]) -> tuple[Token | None, int]:
    """Try to scan a :valueRef at position i."""
    if expression[i] == ":":
        end = i + 1
        while end < len(expression) and (expression[end].isalnum() or expression[end] == "_"):
            end += 1
        tok = Token(TOKEN_VALUE_REF, expression[i:end], i)
        tokens.append(tok)
        return tok, end
    return None, i


def _try_name_ref(expression: str, i: int, tokens: list[Token]) -> tuple[Token | None, int]:
    """Try to scan a #nameRef at position i."""
    if expression[i] == "#":
        end = i + 1
        while end < len(expression) and (expression[end].isalnum() or expression[end] == "_"):
            end += 1
        tok = Token(TOKEN_NAME_REF, expression[i:end], i)
        tokens.append(tok)
        return tok, end
    return None, i


def _try_number_literal(expression: str, i: int, tokens: list[Token]) -> tuple[Token | None, int]:
    """Try to scan a numeric literal at position i."""
    if expression[i].isdigit() or (
        expression[i] == "-" and i + 1 < len(expression) and expression[i + 1].isdigit()
    ):
        end = scan_number_literal(expression, i)
        tok = Token(TOKEN_NUMBER, expression[i:end], i)
        tokens.append(tok)
        return tok, end
    return None, i


def _scan_identifier(expression: str, i: int, tokens: list[Token]) -> int:
    """Scan an identifier or keyword at position i."""
    end = i
    while end < len(expression) and (expression[end].isalnum() or expression[end] in ("_", ".")):
        end += 1
    if end == i:
        raise ValueError(f"Unexpected character at position {i}: {expression[i]!r}")
    word = expression[i:end]
    upper = word.upper()
    if upper in _KEYWORDS:
        type_map = {
            "AND": TOKEN_AND,
            "OR": TOKEN_OR,
            "NOT": TOKEN_NOT,
            "BETWEEN": TOKEN_BETWEEN,
            "IN": TOKEN_IN,
        }
        tokens.append(Token(type_map[upper], word, i))
    else:
        tokens.append(Token(TOKEN_IDENT, word, i))
    return end
