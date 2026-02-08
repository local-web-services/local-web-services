"""Choice state evaluation logic.

Implements all ASL comparison operators and logical combinators
for evaluating Choice state rules.
"""

from __future__ import annotations

from typing import Any

from ldk.providers.stepfunctions.asl_parser import ChoiceRule
from ldk.providers.stepfunctions.path_utils import resolve_path


def evaluate_choice_rules(rules: list[ChoiceRule], input_data: Any) -> str | None:
    """Evaluate choice rules in order and return the next state name.

    Returns None if no rule matches (caller should use Default).
    """
    for rule in rules:
        if evaluate_rule(rule, input_data):
            return rule.next_state
    return None


def evaluate_rule(rule: ChoiceRule, input_data: Any) -> bool:
    """Evaluate a single choice rule against input data."""
    if rule.and_rules is not None:
        return all(evaluate_rule(r, input_data) for r in rule.and_rules)
    if rule.or_rules is not None:
        return any(evaluate_rule(r, input_data) for r in rule.or_rules)
    if rule.not_rule is not None:
        return not evaluate_rule(rule.not_rule, input_data)

    if rule.variable is None or rule.comparison_operator is None:
        return False

    return _evaluate_comparison(
        rule.variable, rule.comparison_operator, rule.comparison_value, input_data
    )


def _evaluate_comparison(variable: str, operator: str, expected: Any, input_data: Any) -> bool:
    """Evaluate a comparison operator against a variable value."""
    try:
        actual = resolve_path(input_data, variable)
    except (KeyError, IndexError, TypeError):
        return _handle_missing_variable(operator, expected)

    return _dispatch_operator(operator, actual, expected)


def _handle_missing_variable(operator: str, expected: Any) -> bool:
    """Handle the case where the variable path does not exist."""
    if operator == "IsPresent":
        return not expected
    return False


def _dispatch_operator(operator: str, actual: Any, expected: Any) -> bool:
    """Dispatch to the correct comparison function based on operator name."""
    dispatch: dict[str, Any] = {
        "StringEquals": lambda a, e: isinstance(a, str) and a == e,
        "StringGreaterThan": lambda a, e: isinstance(a, str) and a > e,
        "StringLessThan": lambda a, e: isinstance(a, str) and a < e,
        "StringGreaterThanEquals": lambda a, e: isinstance(a, str) and a >= e,
        "StringLessThanEquals": lambda a, e: isinstance(a, str) and a <= e,
        "BooleanEquals": lambda a, e: isinstance(a, bool) and a == e,
        "IsPresent": lambda a, e: e is True,
        "IsNull": lambda a, e: (a is None) == e,
        "IsString": lambda a, e: isinstance(a, str) == e,
        "IsNumeric": lambda a, e: _is_numeric(a) == e,
        "IsBoolean": lambda a, e: isinstance(a, bool) == e,
    }

    handler = dispatch.get(operator)
    if handler is not None:
        return handler(actual, expected)

    if operator.startswith("Numeric"):
        return _evaluate_numeric(operator, actual, expected)

    if operator.startswith("Timestamp"):
        return _evaluate_timestamp(operator, actual, expected)

    return False


def _is_numeric(value: Any) -> bool:
    """Check if a value is numeric (int or float but not bool)."""
    return isinstance(value, (int, float)) and not isinstance(value, bool)


def _evaluate_numeric(operator: str, actual: Any, expected: Any) -> bool:
    """Evaluate numeric comparison operators."""
    if not _is_numeric(actual):
        return False
    try:
        expected_num = float(expected) if not isinstance(expected, (int, float)) else expected
    except (TypeError, ValueError):
        return False

    numeric_ops: dict[str, Any] = {
        "NumericEquals": lambda a, e: a == e,
        "NumericGreaterThan": lambda a, e: a > e,
        "NumericLessThan": lambda a, e: a < e,
        "NumericGreaterThanEquals": lambda a, e: a >= e,
        "NumericLessThanEquals": lambda a, e: a <= e,
    }
    handler = numeric_ops.get(operator)
    if handler is None:
        return False
    return handler(actual, expected_num)


def _evaluate_timestamp(operator: str, actual: Any, expected: Any) -> bool:
    """Evaluate timestamp comparison operators using string comparison."""
    if not isinstance(actual, str) or not isinstance(expected, str):
        return False
    timestamp_ops: dict[str, Any] = {
        "TimestampEquals": lambda a, e: a == e,
        "TimestampGreaterThan": lambda a, e: a > e,
        "TimestampLessThan": lambda a, e: a < e,
        "TimestampGreaterThanEquals": lambda a, e: a >= e,
        "TimestampLessThanEquals": lambda a, e: a <= e,
    }
    handler = timestamp_ops.get(operator)
    if handler is None:
        return False
    return handler(actual, expected)
