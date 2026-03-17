"""Lexer for DynamoDB UpdateExpression strings."""

from __future__ import annotations

from lws.providers.dynamodb.parser_base import Token, scan_number_literal

# ---------------------------------------------------------------------------
# Token types
# ---------------------------------------------------------------------------

TOKEN_IDENT = "IDENT"
TOKEN_VALUE_REF = "VALUE_REF"
TOKEN_NAME_REF = "NAME_REF"
TOKEN_NUMBER = "NUMBER"
TOKEN_COMMA = "COMMA"
TOKEN_LPAREN = "LPAREN"
TOKEN_RPAREN = "RPAREN"
TOKEN_EQUALS = "EQUALS"
TOKEN_PLUS = "PLUS"
TOKEN_MINUS = "MINUS"
TOKEN_SET = "SET"
TOKEN_REMOVE = "REMOVE"
TOKEN_ADD = "ADD"
TOKEN_DELETE = "DELETE"
TOKEN_EOF = "EOF"

_ACTION_KEYWORDS = {"SET", "REMOVE", "ADD", "DELETE"}


# ---------------------------------------------------------------------------
# Lexer — tokenizes SET/REMOVE/ADD/DELETE update expressions
# ---------------------------------------------------------------------------


def tokenize(expression: str) -> list[Token]:
    """Tokenize a DynamoDB UpdateExpression into a list of tokens."""
    tokens: list[Token] = []
    pos = 0
    end = len(expression)
    while pos < end:
        if expression[pos].isspace():
            pos += 1
        else:
            pos = _scan_next_token(expression, pos, end, tokens)
    tokens.append(Token(TOKEN_EOF, "", end))
    return tokens


def _scan_next_token(expression: str, i: int, length: int, tokens: list[Token]) -> int:
    """Scan the next token starting at position i. Returns the new position."""
    ch = expression[i]

    new_i = _scan_single_char(ch, i, tokens)
    if new_i != i:
        return new_i

    if ch == ":":
        return _scan_value_ref(expression, i, tokens)

    if ch == "#":
        return _scan_name_ref(expression, i, tokens)

    if _is_number_start(ch, expression, i, length):
        return _scan_number(expression, i, tokens)

    if ch.isalpha() or ch == "_":
        return _scan_word(expression, i, tokens)

    raise ValueError(f"Unexpected character at position {i}: {ch!r}")


def _is_number_start(ch: str, expression: str, i: int, length: int) -> bool:
    """Check if position i starts a numeric literal."""
    if ch.isdigit():
        return True
    return ch == "-" and i + 1 < length and expression[i + 1].isdigit()


def _scan_single_char(ch: str, i: int, tokens: list[Token]) -> int:
    """Scan single-character tokens like comma, parens, operators."""
    mapping = {
        ",": TOKEN_COMMA,
        "(": TOKEN_LPAREN,
        ")": TOKEN_RPAREN,
        "=": TOKEN_EQUALS,
        "+": TOKEN_PLUS,
        "-": TOKEN_MINUS,
    }
    if ch in mapping:
        tokens.append(Token(mapping[ch], ch, i))
        return i + 1
    return i


def _scan_value_ref(expression: str, i: int, tokens: list[Token]) -> int:
    """Scan a :valueRef token."""
    end = i + 1
    while end < len(expression) and (expression[end].isalnum() or expression[end] == "_"):
        end += 1
    tokens.append(Token(TOKEN_VALUE_REF, expression[i:end], i))
    return end


def _scan_name_ref(expression: str, i: int, tokens: list[Token]) -> int:
    """Scan a #nameRef token."""
    end = i + 1
    while end < len(expression) and (expression[end].isalnum() or expression[end] == "_"):
        end += 1
    tokens.append(Token(TOKEN_NAME_REF, expression[i:end], i))
    return end


def _scan_number(expression: str, i: int, tokens: list[Token]) -> int:
    """Scan a numeric literal."""
    end = scan_number_literal(expression, i)
    tokens.append(Token(TOKEN_NUMBER, expression[i:end], i))
    return end


def _scan_word(expression: str, i: int, tokens: list[Token]) -> int:
    """Scan an identifier or keyword."""
    end = i
    while end < len(expression) and (
        expression[end].isalnum() or expression[end] in ("_", ".", "[", "]")
    ):
        end += 1
    word = expression[i:end]
    upper = word.upper()
    if upper in _ACTION_KEYWORDS:
        type_map = {
            "SET": TOKEN_SET,
            "REMOVE": TOKEN_REMOVE,
            "ADD": TOKEN_ADD,
            "DELETE": TOKEN_DELETE,
        }
        tokens.append(Token(type_map[upper], word, i))
    else:
        tokens.append(Token(TOKEN_IDENT, word, i))
    return end
