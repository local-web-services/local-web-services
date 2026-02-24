"""Recursive-descent FilterExpression evaluator for DynamoDB expressions.

Supports:
- Comparison operators: =, <>, <, >, <=, >=
- Logical operators: AND, OR, NOT (with proper precedence)
- BETWEEN, IN operators
- Functions: attribute_exists(), attribute_not_exists(), begins_with(), contains(), size()
- ExpressionAttributeNames (#attr) and ExpressionAttributeValues (:val) resolution
"""

from __future__ import annotations

import re
from typing import Any

from lws.providers.dynamodb.parser_base import BaseParser, Token, scan_number_literal

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


# ---------------------------------------------------------------------------
# Parser (recursive descent)
# ---------------------------------------------------------------------------


class _Parser(BaseParser):
    """Recursive descent parser for DynamoDB filter expressions.

    Grammar (simplified):
        expr       -> or_expr
        or_expr    -> and_expr (OR and_expr)*
        and_expr   -> not_expr (AND not_expr)*
        not_expr   -> NOT not_expr | comparison
        comparison -> operand (comp_op operand | BETWEEN operand AND operand | IN (list))?
        operand    -> function_call | atom
        atom       -> VALUE_REF | NAME_REF | IDENT | NUMBER | '(' expr ')'
    """

    def parse(self) -> dict:
        """Parse the full expression and return an AST dict."""
        result = self._or_expr()
        if self._peek().type != TOKEN_EOF:
            tok = self._peek()
            raise ValueError(f"Unexpected token at pos {tok.pos}: {tok.value!r}")
        return result

    def _or_expr(self) -> dict:
        left = self._and_expr()
        while self._peek().type == TOKEN_OR:
            self._advance()
            right = self._and_expr()
            left = {"op": "OR", "left": left, "right": right}
        return left

    def _and_expr(self) -> dict:
        left = self._not_expr()
        while self._peek().type == TOKEN_AND:
            self._advance()
            right = self._not_expr()
            left = {"op": "AND", "left": left, "right": right}
        return left

    def _not_expr(self) -> dict:
        if self._peek().type == TOKEN_NOT:
            self._advance()
            operand = self._not_expr()
            return {"op": "NOT", "operand": operand}
        return self._comparison()

    def _comparison(self) -> dict:
        left = self._operand()
        return self._comparison_tail(left)

    def _comparison_tail(self, left: dict) -> dict:
        """Parse the optional tail of a comparison (operator, BETWEEN, IN)."""
        tok = self._peek()

        if tok.type == TOKEN_OP:
            self._advance()
            right = self._operand()
            return {"op": "compare", "comparator": tok.value, "left": left, "right": right}

        if tok.type == TOKEN_BETWEEN:
            return self._parse_between(left)

        if tok.type == TOKEN_IN:
            return self._parse_in(left)

        return left

    def _parse_between(self, left: dict) -> dict:
        """Parse BETWEEN low AND high."""
        self._advance()  # consume BETWEEN
        low = self._operand()
        self._expect(TOKEN_AND)
        high = self._operand()
        return {"op": "BETWEEN", "operand": left, "low": low, "high": high}

    def _parse_in(self, left: dict) -> dict:
        """Parse IN (val1, val2, ...)."""
        self._advance()  # consume IN
        self._expect(TOKEN_LPAREN)
        values: list[dict] = []
        if self._peek().type != TOKEN_RPAREN:
            values.append(self._operand())
            while self._peek().type == TOKEN_COMMA:
                self._advance()
                values.append(self._operand())
        self._expect(TOKEN_RPAREN)
        return {"op": "IN", "operand": left, "values": values}

    def _operand(self) -> dict:
        """Parse an operand: function call, atom, or parenthesized expr."""
        tok = self._peek()

        if tok.type == TOKEN_IDENT and self._is_function_name(tok.value):
            return self._function_call()

        if tok.type == TOKEN_LPAREN:
            self._advance()
            inner = self._or_expr()
            self._expect(TOKEN_RPAREN)
            return inner

        return self._atom()

    def _is_function_name(self, name: str) -> bool:
        """Check if the identifier is a known function and followed by '('."""
        known = {"attribute_exists", "attribute_not_exists", "begins_with", "contains", "size"}
        if name.lower() not in known:
            return False
        return self._next_is(TOKEN_LPAREN)

    def _function_call(self) -> dict:
        """Parse a function call: func_name(arg1, arg2, ...)."""
        name_tok = self._advance()
        self._expect(TOKEN_LPAREN)
        args: list[dict] = []
        if self._peek().type != TOKEN_RPAREN:
            args.append(self._or_expr())
            while self._peek().type == TOKEN_COMMA:
                self._advance()
                args.append(self._or_expr())
        self._expect(TOKEN_RPAREN)
        return {"op": "function", "name": name_tok.value.lower(), "args": args}

    def _atom(self) -> dict:
        """Parse an atomic value: value ref, name ref, identifier, or number."""
        tok = self._advance()
        if tok.type == TOKEN_VALUE_REF:
            return {"op": "value_ref", "ref": tok.value}
        if tok.type == TOKEN_NAME_REF:
            return {"op": "name_ref", "ref": tok.value}
        if tok.type == TOKEN_IDENT:
            return {"op": "path", "path": tok.value}
        if tok.type == TOKEN_NUMBER:
            return {"op": "literal", "value": _parse_number(tok.value)}
        raise ValueError(f"Unexpected token at pos {tok.pos}: {tok.type} ({tok.value!r})")


def _parse_number(s: str) -> int | float:
    """Parse a numeric string to int or float."""
    return int(s) if "." not in s else float(s)


# ---------------------------------------------------------------------------
# AST Evaluator
# ---------------------------------------------------------------------------


def _resolve_path(item: dict, path: str) -> tuple[bool, Any]:
    """Resolve a dotted attribute path against an item. Returns (found, value)."""
    parts = path.split(".")
    current: Any = item
    for part in parts:
        if isinstance(current, dict) and part in current:
            current = current[part]
        else:
            return False, None
    return True, current


class ExpressionEvaluator:
    """Evaluates a parsed DynamoDB filter expression AST against an item.

    Parameters
    ----------
    expression_names : dict | None
        Mapping of ``#name`` placeholders to real attribute names.
    expression_values : dict | None
        Mapping of ``:value`` placeholders to DynamoDB-typed values.
    """

    def __init__(
        self,
        expression_names: dict[str, str] | None = None,
        expression_values: dict[str, Any] | None = None,
    ) -> None:
        self._names = expression_names or {}
        self._values = expression_values or {}

    def evaluate(self, ast: dict, item: dict) -> bool:
        """Evaluate the AST against a single item. Returns True if the item matches."""
        result = self._eval_node(ast, item)
        return bool(result)

    def _eval_node(self, node: dict, item: dict) -> Any:
        """Dispatch evaluation based on node op type."""
        op = node["op"]
        dispatch = {
            "AND": self._eval_and,
            "OR": self._eval_or,
            "NOT": self._eval_not,
            "compare": self._eval_compare,
            "BETWEEN": self._eval_between,
            "IN": self._eval_in,
            "function": self._eval_function,
            "value_ref": self._eval_value_ref,
            "name_ref": self._eval_name_ref,
            "path": self._eval_path,
            "literal": self._eval_literal,
        }
        handler = dispatch.get(op)
        if handler is None:
            raise ValueError(f"Unknown AST node op: {op}")
        return handler(node, item)

    def _eval_and(self, node: dict, item: dict) -> bool:
        return bool(self._eval_node(node["left"], item) and self._eval_node(node["right"], item))

    def _eval_or(self, node: dict, item: dict) -> bool:
        return bool(self._eval_node(node["left"], item) or self._eval_node(node["right"], item))

    def _eval_not(self, node: dict, item: dict) -> bool:
        return not self._eval_node(node["operand"], item)

    def _eval_compare(self, node: dict, item: dict) -> bool:
        left = self._eval_node(node["left"], item)
        right = self._eval_node(node["right"], item)
        if left is None or right is None:
            return False
        left, right = _coerce_for_comparison(left, right)
        return _apply_comparator(node["comparator"], left, right)

    def _eval_between(self, node: dict, item: dict) -> bool:
        val = self._eval_node(node["operand"], item)
        low = self._eval_node(node["low"], item)
        high = self._eval_node(node["high"], item)
        if val is None or low is None or high is None:
            return False
        val, low = _coerce_for_comparison(val, low)
        val, high = _coerce_for_comparison(val, high)
        return low <= val <= high

    def _eval_in(self, node: dict, item: dict) -> bool:
        val = self._eval_node(node["operand"], item)
        if val is None:
            return False
        for v_node in node["values"]:
            candidate = self._eval_node(v_node, item)
            coerced_val, coerced_candidate = _coerce_for_comparison(val, candidate)
            if coerced_val == coerced_candidate:
                return True
        return False

    def _eval_function(self, node: dict, item: dict) -> Any:
        name = node["name"]
        func_map = {
            "attribute_exists": self._func_attribute_exists,
            "attribute_not_exists": self._func_attribute_not_exists,
            "begins_with": self._func_begins_with,
            "contains": self._func_contains,
            "size": self._func_size,
        }
        func = func_map.get(name)
        if func is None:
            raise ValueError(f"Unknown function: {name}")
        return func(node["args"], item)

    def _eval_value_ref(self, node: dict, _item: dict) -> Any:
        ref = node["ref"]
        raw = self._values.get(ref)
        return _unwrap_dynamo_value(raw)

    def _eval_name_ref(self, node: dict, item: dict) -> Any:
        ref = node["ref"]
        real_name = self._names.get(ref, ref)
        found, val = _resolve_path(item, real_name)
        return val if found else None

    def _eval_path(self, node: dict, item: dict) -> Any:
        found, val = _resolve_path(item, node["path"])
        return val if found else None

    def _eval_literal(self, node: dict, _item: dict) -> Any:
        return node["value"]

    # -- Built-in functions ---

    def _func_attribute_exists(self, args: list[dict], item: dict) -> bool:
        path = self._resolve_attr_path(args[0])
        found, _ = _resolve_path(item, path)
        return found

    def _func_attribute_not_exists(self, args: list[dict], item: dict) -> bool:
        path = self._resolve_attr_path(args[0])
        found, _ = _resolve_path(item, path)
        return not found

    def _func_begins_with(self, args: list[dict], item: dict) -> bool:
        val = self._eval_node(args[0], item)
        prefix = self._eval_node(args[1], item)
        if not isinstance(val, str) or not isinstance(prefix, str):
            return False
        return val.startswith(prefix)

    def _func_contains(self, args: list[dict], item: dict) -> bool:
        val = self._eval_node(args[0], item)
        operand = self._eval_node(args[1], item)
        if isinstance(val, str) and isinstance(operand, str):
            return operand in val
        if isinstance(val, (list, set)):
            return operand in val
        return False

    def _func_size(self, args: list[dict], item: dict) -> int:
        val = self._eval_node(args[0], item)
        if val is None:
            return 0
        if isinstance(val, (str, list, dict, set)):
            return len(val)
        return 0

    def _resolve_attr_path(self, node: dict) -> str:
        """Resolve an AST node to an attribute path string."""
        if node["op"] == "name_ref":
            return self._names.get(node["ref"], node["ref"])
        if node["op"] == "path":
            return node["path"]
        return str(node.get("ref", node.get("path", "")))


# ---------------------------------------------------------------------------
# Helper functions
# ---------------------------------------------------------------------------


def _unwrap_dynamo_value(raw: Any) -> Any:
    """Unwrap a DynamoDB typed value to a plain Python value."""
    if raw is None:
        return None
    if not isinstance(raw, dict):
        return raw
    type_converters = {
        "S": lambda v: v,
        "N": lambda v: int(v) if "." not in str(v) else float(v),
        "B": lambda v: v,
        "BOOL": lambda v: v,
        "NULL": lambda v: None,
        "L": lambda v: [_unwrap_dynamo_value(item) for item in v],
        "M": lambda v: {k: _unwrap_dynamo_value(val) for k, val in v.items()},
        "SS": set,
        "NS": lambda v: {int(n) if "." not in str(n) else float(n) for n in v},
        "BS": set,
    }
    for type_key, converter in type_converters.items():
        if type_key in raw:
            return converter(raw[type_key])
    return raw


def _coerce_for_comparison(a: Any, b: Any) -> tuple[Any, Any]:
    """Coerce two values to comparable types."""
    if isinstance(a, str) and isinstance(b, (int, float)):
        try:
            a = type(b)(a)
        except (ValueError, TypeError):
            pass
    if isinstance(b, str) and isinstance(a, (int, float)):
        try:
            b = type(a)(b)
        except (ValueError, TypeError):
            pass
    return a, b


_COMPARATORS: dict[str, Any] = {
    "=": lambda a, b: a == b,
    "<>": lambda a, b: a != b,
    "<": lambda a, b: a < b,
    ">": lambda a, b: a > b,
    "<=": lambda a, b: a <= b,
    ">=": lambda a, b: a >= b,
}


def _apply_comparator(op: str, left: Any, right: Any) -> bool:
    """Apply a comparison operator to two values."""
    cmp_fn = _COMPARATORS.get(op)
    if cmp_fn is None:
        raise ValueError(f"Unknown comparator: {op}")
    try:
        return bool(cmp_fn(left, right))
    except TypeError:
        return False


# ---------------------------------------------------------------------------
# Public API
# ---------------------------------------------------------------------------


def parse_filter_expression(expression: str) -> dict:
    """Parse a DynamoDB FilterExpression string into an AST.

    Returns a dict representing the abstract syntax tree.
    """
    tokens = tokenize(expression)
    parser = _Parser(tokens)
    return parser.parse()


def evaluate_filter_expression(
    item: dict,
    expression: str,
    expression_names: dict[str, str] | None = None,
    expression_values: dict[str, Any] | None = None,
) -> bool:
    """Evaluate a DynamoDB FilterExpression against a single item.

    Parameters
    ----------
    item : dict
        The item to evaluate (plain Python dict, not DynamoDB JSON).
    expression : str
        The DynamoDB FilterExpression string.
    expression_names : dict | None
        Mapping of #name placeholders to real attribute names.
    expression_values : dict | None
        Mapping of :value placeholders to DynamoDB-typed values.

    Returns
    -------
    bool
        True if the item matches the expression.
    """
    ast = parse_filter_expression(expression)
    evaluator = ExpressionEvaluator(expression_names, expression_values)
    return evaluator.evaluate(ast, item)


def apply_filter_expression(
    items: list[dict],
    expression: str | None,
    expression_names: dict[str, str] | None = None,
    expression_values: dict[str, Any] | None = None,
) -> list[dict]:
    """Filter a list of items using a DynamoDB FilterExpression.

    If expression is None or empty, returns all items unchanged.
    """
    if not expression:
        return items
    ast = parse_filter_expression(expression)
    evaluator = ExpressionEvaluator(expression_names, expression_values)
    return [item for item in items if evaluator.evaluate(ast, item)]
