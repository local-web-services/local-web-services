"""Robust UpdateExpression parser and evaluator for DynamoDB.

Supports:
- SET: regular assignment, if_not_exists(path, value), list_append(list1, list2),
  arithmetic (+, -)
- REMOVE: remove attributes
- ADD: add to number or set
- DELETE: delete from set
- Combined clauses: SET ... REMOVE ... ADD ... DELETE ...
"""

from __future__ import annotations

from dataclasses import dataclass, field
from typing import Any

from lws.providers.dynamodb.expressions import _resolve_path, _unwrap_dynamo_value
from lws.providers.dynamodb.parser_base import BaseParser, Token, scan_number_literal

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


# ---------------------------------------------------------------------------
# AST node types
# ---------------------------------------------------------------------------


@dataclass
class SetAction:
    """SET path = value_expr."""

    path: str
    value_expr: dict


@dataclass
class RemoveAction:
    """REMOVE path."""

    path: str


@dataclass
class AddAction:
    """ADD path value."""

    path: str
    value_expr: dict


@dataclass
class DeleteAction:
    """DELETE path value."""

    path: str
    value_expr: dict


@dataclass
class UpdateActions:
    """Parsed update expression containing all action clauses."""

    set_actions: list[SetAction] = field(default_factory=list)
    remove_actions: list[RemoveAction] = field(default_factory=list)
    add_actions: list[AddAction] = field(default_factory=list)
    delete_actions: list[DeleteAction] = field(default_factory=list)


# ---------------------------------------------------------------------------
# Parser
# ---------------------------------------------------------------------------


class _Parser(BaseParser):
    """Parse a DynamoDB UpdateExpression into UpdateActions."""

    def parse(self) -> UpdateActions:
        """Parse the full update expression."""
        actions = UpdateActions()
        while self._peek().type != TOKEN_EOF:
            tok = self._peek()
            if tok.type == TOKEN_SET:
                self._advance()
                self._parse_set_clause(actions)
            elif tok.type == TOKEN_REMOVE:
                self._advance()
                self._parse_remove_clause(actions)
            elif tok.type == TOKEN_ADD:
                self._advance()
                self._parse_add_clause(actions)
            elif tok.type == TOKEN_DELETE:
                self._advance()
                self._parse_delete_clause(actions)
            else:
                raise ValueError(f"Expected action keyword at pos {tok.pos}, got {tok.value!r}")
        return actions

    def _parse_set_clause(self, actions: UpdateActions) -> None:
        """Parse one or more SET actions separated by commas."""
        actions.set_actions.append(self._parse_one_set())
        while self._peek().type == TOKEN_COMMA:
            self._advance()
            actions.set_actions.append(self._parse_one_set())

    def _parse_one_set(self) -> SetAction:
        """Parse a single SET action: path = value_expr."""
        path = self._parse_path()
        self._expect(TOKEN_EQUALS)
        value_expr = self._parse_value_expr()
        return SetAction(path=path, value_expr=value_expr)

    def _parse_value_expr(self) -> dict:
        """Parse a value expression for SET clause.

        Handles: plain values, if_not_exists(), list_append(), arithmetic.
        """
        left = self._parse_value_atom()
        return self._parse_arithmetic_tail(left)

    def _parse_arithmetic_tail(self, left: dict) -> dict:
        """Parse optional arithmetic tail (+ or -)."""
        tok = self._peek()
        if tok.type == TOKEN_PLUS:
            self._advance()
            right = self._parse_value_atom()
            return {"op": "add", "left": left, "right": right}
        if tok.type == TOKEN_MINUS:
            self._advance()
            right = self._parse_value_atom()
            return {"op": "subtract", "left": left, "right": right}
        return left

    def _parse_value_atom(self) -> dict:
        """Parse a single value atom: function call, ref, or path."""
        tok = self._peek()

        if tok.type == TOKEN_IDENT and self._is_function():
            return self._parse_function_call()

        if tok.type == TOKEN_VALUE_REF:
            self._advance()
            return {"op": "value_ref", "ref": tok.value}

        if tok.type == TOKEN_NAME_REF:
            self._advance()
            return {"op": "name_ref", "ref": tok.value}

        if tok.type == TOKEN_IDENT:
            self._advance()
            return {"op": "path", "path": tok.value}

        if tok.type == TOKEN_NUMBER:
            self._advance()
            return {"op": "literal", "value": _parse_number(tok.value)}

        raise ValueError(f"Unexpected token at pos {tok.pos}: {tok.value!r}")

    def _is_function(self) -> bool:
        """Check if current IDENT is followed by LPAREN (function call)."""
        return self._next_is(TOKEN_LPAREN)

    def _parse_function_call(self) -> dict:
        """Parse a function call like if_not_exists(path, value) or list_append(a, b)."""
        name_tok = self._advance()
        self._expect(TOKEN_LPAREN)
        args: list[dict] = []
        if self._peek().type != TOKEN_RPAREN:
            args.append(self._parse_value_expr())
            while self._peek().type == TOKEN_COMMA:
                self._advance()
                args.append(self._parse_value_expr())
        self._expect(TOKEN_RPAREN)
        return {"op": "function", "name": name_tok.value.lower(), "args": args}

    def _parse_remove_clause(self, actions: UpdateActions) -> None:
        """Parse one or more REMOVE actions separated by commas."""
        actions.remove_actions.append(RemoveAction(path=self._parse_path()))
        while self._peek().type == TOKEN_COMMA:
            self._advance()
            actions.remove_actions.append(RemoveAction(path=self._parse_path()))

    def _parse_add_clause(self, actions: UpdateActions) -> None:
        """Parse one or more ADD actions: path value."""
        action = self._parse_one_add()
        actions.add_actions.append(action)
        while self._peek().type == TOKEN_COMMA:
            self._advance()
            actions.add_actions.append(self._parse_one_add())

    def _parse_one_add(self) -> AddAction:
        """Parse a single ADD action: path value."""
        path = self._parse_path()
        value_expr = self._parse_value_atom()
        return AddAction(path=path, value_expr=value_expr)

    def _parse_delete_clause(self, actions: UpdateActions) -> None:
        """Parse one or more DELETE actions: path value."""
        action = self._parse_one_delete()
        actions.delete_actions.append(action)
        while self._peek().type == TOKEN_COMMA:
            self._advance()
            actions.delete_actions.append(self._parse_one_delete())

    def _parse_one_delete(self) -> DeleteAction:
        """Parse a single DELETE action: path value."""
        path = self._parse_path()
        value_expr = self._parse_value_atom()
        return DeleteAction(path=path, value_expr=value_expr)

    def _parse_path(self) -> str:
        """Parse an attribute path (possibly with #name refs)."""
        tok = self._peek()
        if tok.type == TOKEN_NAME_REF:
            self._advance()
            return tok.value
        if tok.type == TOKEN_IDENT:
            self._advance()
            return tok.value
        raise ValueError(f"Expected path at pos {tok.pos}, got {tok.value!r}")


def _parse_number(s: str) -> int | float:
    """Parse a numeric string to int or float."""
    return int(s) if "." not in s else float(s)


# ---------------------------------------------------------------------------
# Evaluator
# ---------------------------------------------------------------------------


def _set_path(item: dict, path: str, value: Any) -> None:
    """Set a value at a dotted path in item, creating intermediate dicts as needed."""
    parts = path.split(".")
    current = item
    for part in parts[:-1]:
        if part not in current or not isinstance(current[part], dict):
            current[part] = {}
        current = current[part]
    current[parts[-1]] = value


def _remove_path(item: dict, path: str) -> None:
    """Remove a value at a dotted path in item."""
    parts = path.split(".")
    current = item
    for part in parts[:-1]:
        if isinstance(current, dict) and part in current:
            current = current[part]
        else:
            return
    if isinstance(current, dict):
        current.pop(parts[-1], None)


class UpdateExpressionEvaluator:
    """Evaluate a parsed UpdateExpression against an item.

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

    def apply(self, actions: UpdateActions, item: dict) -> dict:
        """Apply all update actions to item (mutates in-place). Returns the item."""
        for action in actions.set_actions:
            self._apply_set(action, item)
        for action in actions.remove_actions:
            self._apply_remove(action, item)
        for action in actions.add_actions:
            self._apply_add(action, item)
        for action in actions.delete_actions:
            self._apply_delete(action, item)
        return item

    def _resolve_name(self, token: str) -> str:
        """Resolve a #name ref or return the token as-is."""
        if token.startswith("#"):
            return self._names.get(token, token)
        return token

    def _eval_value_expr(self, expr: dict, item: dict) -> Any:
        """Evaluate a value expression to a concrete Python value."""
        op = expr["op"]
        dispatch = {
            "value_ref": self._eval_value_ref,
            "name_ref": self._eval_name_ref,
            "path": self._eval_path,
            "literal": self._eval_literal,
            "function": self._eval_function,
            "add": self._eval_add,
            "subtract": self._eval_subtract,
        }
        handler = dispatch.get(op)
        if handler is None:
            raise ValueError(f"Unknown value expression op: {op}")
        return handler(expr, item)

    def _eval_value_ref(self, expr: dict, _item: dict) -> Any:
        raw = self._values.get(expr["ref"])
        return _unwrap_dynamo_value(raw)

    def _eval_name_ref(self, expr: dict, item: dict) -> Any:
        real_name = self._names.get(expr["ref"], expr["ref"])
        found, val = _resolve_path(item, real_name)
        return val if found else None

    def _eval_path(self, expr: dict, item: dict) -> Any:
        found, val = _resolve_path(item, expr["path"])
        return val if found else None

    def _eval_literal(self, expr: dict, _item: dict) -> Any:
        return expr["value"]

    def _eval_function(self, expr: dict, item: dict) -> Any:
        name = expr["name"]
        if name == "if_not_exists":
            return self._func_if_not_exists(expr["args"], item)
        if name == "list_append":
            return self._func_list_append(expr["args"], item)
        raise ValueError(f"Unknown function in SET: {name}")

    def _eval_add(self, expr: dict, item: dict) -> Any:
        left = self._eval_value_expr(expr["left"], item)
        right = self._eval_value_expr(expr["right"], item)
        return _numeric_op(left, right, operator="add")

    def _eval_subtract(self, expr: dict, item: dict) -> Any:
        left = self._eval_value_expr(expr["left"], item)
        right = self._eval_value_expr(expr["right"], item)
        return _numeric_op(left, right, operator="subtract")

    def _func_if_not_exists(self, args: list[dict], item: dict) -> Any:
        """if_not_exists(path, value): return current value if exists, else default."""
        path_expr = args[0]
        default_expr = args[1]
        path = self._resolve_path_from_expr(path_expr)
        found, val = _resolve_path(item, path)
        if found:
            return val
        return self._eval_value_expr(default_expr, item)

    def _func_list_append(self, args: list[dict], item: dict) -> list:
        """list_append(list1, list2): concatenate two lists."""
        list1 = self._eval_value_expr(args[0], item)
        list2 = self._eval_value_expr(args[1], item)
        result1 = list1 if isinstance(list1, list) else [list1] if list1 is not None else []
        result2 = list2 if isinstance(list2, list) else [list2] if list2 is not None else []
        return result1 + result2

    def _resolve_path_from_expr(self, expr: dict) -> str:
        """Resolve an expression node to an attribute path string."""
        if expr["op"] == "name_ref":
            return self._names.get(expr["ref"], expr["ref"])
        if expr["op"] == "path":
            return expr["path"]
        return str(expr.get("ref", expr.get("path", "")))

    def _apply_set(self, action: SetAction, item: dict) -> None:
        """Apply a single SET action."""
        path = self._resolve_name(action.path)
        value = self._eval_value_expr(action.value_expr, item)
        _set_path(item, path, value)

    def _apply_remove(self, action: RemoveAction, item: dict) -> None:
        """Apply a single REMOVE action."""
        path = self._resolve_name(action.path)
        _remove_path(item, path)

    def _apply_add(self, action: AddAction, item: dict) -> None:
        """Apply a single ADD action: add to number or set."""
        path = self._resolve_name(action.path)
        value = self._eval_value_expr(action.value_expr, item)
        found, current = _resolve_path(item, path)
        if not found:
            _set_path(item, path, value)
            return
        new_val = _add_values(current, value)
        _set_path(item, path, new_val)

    def _apply_delete(self, action: DeleteAction, item: dict) -> None:
        """Apply a single DELETE action: remove elements from a set."""
        path = self._resolve_name(action.path)
        value = self._eval_value_expr(action.value_expr, item)
        found, current = _resolve_path(item, path)
        if not found or not isinstance(current, set):
            return
        if isinstance(value, set):
            _set_path(item, path, current - value)
        else:
            current.discard(value)
            _set_path(item, path, current)


def _numeric_op(left: Any, right: Any, operator: str) -> Any:
    """Perform arithmetic on two values."""
    left_num = _to_number(left)
    right_num = _to_number(right)
    if operator == "add":
        return left_num + right_num
    return left_num - right_num


def _to_number(val: Any) -> int | float:
    """Convert a value to a number."""
    if isinstance(val, (int, float)):
        return val
    if isinstance(val, str):
        return int(val) if "." not in val else float(val)
    return 0


def _add_values(current: Any, value: Any) -> Any:
    """ADD operation: add to number or union with set."""
    if isinstance(current, (int, float)) and isinstance(value, (int, float)):
        return current + value
    if isinstance(current, set):
        if isinstance(value, set):
            return current | value
        return current | {value}
    if isinstance(current, (int, float)):
        return current + _to_number(value)
    return value


# ---------------------------------------------------------------------------
# Public API
# ---------------------------------------------------------------------------


def parse_update_expression(expression: str) -> UpdateActions:
    """Parse a DynamoDB UpdateExpression string into UpdateActions."""
    tokens = tokenize(expression)
    parser = _Parser(tokens)
    return parser.parse()


def apply_update_expression(
    item: dict,
    expression: str,
    expression_names: dict[str, str] | None = None,
    expression_values: dict[str, Any] | None = None,
) -> dict:
    """Apply a DynamoDB UpdateExpression to an item (mutates in-place).

    Parameters
    ----------
    item : dict
        The item to update.
    expression : str
        The DynamoDB UpdateExpression string.
    expression_names : dict | None
        Mapping of #name placeholders to real attribute names.
    expression_values : dict | None
        Mapping of :value placeholders to DynamoDB-typed values.

    Returns
    -------
    dict
        The updated item.
    """
    actions = parse_update_expression(expression)
    evaluator = UpdateExpressionEvaluator(expression_names, expression_values)
    return evaluator.apply(actions, item)
