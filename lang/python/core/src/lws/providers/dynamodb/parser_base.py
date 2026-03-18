"""Shared base classes for DynamoDB expression parsers."""

from __future__ import annotations

from dataclasses import dataclass


@dataclass
class Token:
    """A single lexical token."""

    type: str
    value: str
    pos: int


def scan_number_literal(expression: str, start: int) -> int:
    """Scan a numeric literal and return the end position.

    Handles integers and floats (single decimal point).
    Caller is responsible for checking that ``expression[start]`` is a digit
    (or minus followed by a digit).
    """
    end = start + 1
    has_dot = False
    while end < len(expression) and (expression[end].isdigit() or expression[end] == "."):
        if expression[end] == ".":
            if has_dot:
                break
            has_dot = True
        end += 1
    return end


class BaseParser:
    """Base class for DynamoDB recursive-descent parsers."""

    def __init__(self, tokens: list[Token]) -> None:
        self._tokens = tokens
        self._pos = 0

    def _peek(self) -> Token:
        """Return the current token without advancing."""
        return self._tokens[self._pos]

    def _advance(self) -> Token:
        """Return the current token and advance to the next."""
        tok = self._tokens[self._pos]
        self._pos += 1
        return tok

    def _expect(self, token_type: str) -> Token:
        """Advance and return the next token, raising if it doesn't match."""
        tok = self._advance()
        if tok.type != token_type:
            raise ValueError(
                f"Expected {token_type} at pos {tok.pos}, got {tok.type} ({tok.value!r})"
            )
        return tok

    def _next_is(self, token_type: str) -> bool:
        """Check if the token after the current one has the given type."""
        next_pos = self._pos + 1
        if next_pos < len(self._tokens):
            return self._tokens[next_pos].type == token_type
        return False
