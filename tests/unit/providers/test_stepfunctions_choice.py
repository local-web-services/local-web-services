"""Tests for the Step Functions choice evaluator and path utilities.

Covers all comparison operators, logical combinators (And/Or/Not),
type-checking operators, and JSONPath-like path processing.
"""

from __future__ import annotations

import pytest

from ldk.providers.stepfunctions.asl_parser import ChoiceRule
from ldk.providers.stepfunctions.choice_evaluator import (
    evaluate_choice_rules,
    evaluate_rule,
)
from ldk.providers.stepfunctions.path_utils import (
    apply_context_parameters,
    apply_input_path,
    apply_output_path,
    apply_parameters,
    apply_result_path,
    resolve_path,
)

# ---------------------------------------------------------------------------
# Path utilities
# ---------------------------------------------------------------------------


class TestResolvePath:
    """JSONPath-like path resolution."""

    def test_root_path(self) -> None:
        assert resolve_path({"a": 1}, "$") == {"a": 1}

    def test_simple_key(self) -> None:
        assert resolve_path({"a": 1, "b": 2}, "$.a") == 1

    def test_nested_key(self) -> None:
        data = {"a": {"b": {"c": 3}}}
        assert resolve_path(data, "$.a.b.c") == 3

    def test_array_index(self) -> None:
        data = {"items": [10, 20, 30]}
        assert resolve_path(data, "$.items[0]") == 10
        assert resolve_path(data, "$.items[2]") == 30

    def test_missing_key_raises(self) -> None:
        with pytest.raises(KeyError):
            resolve_path({"a": 1}, "$.b")


class TestApplyInputPath:
    """InputPath processing."""

    def test_null_returns_empty(self) -> None:
        assert apply_input_path({"x": 1}, None) == {}

    def test_root_returns_data(self) -> None:
        data = {"x": 1}
        assert apply_input_path(data, "$") == data

    def test_nested_path(self) -> None:
        data = {"a": {"b": 42}}
        assert apply_input_path(data, "$.a") == {"b": 42}


class TestApplyOutputPath:
    """OutputPath processing."""

    def test_null_returns_empty(self) -> None:
        assert apply_output_path({"x": 1}, None) == {}

    def test_root_returns_data(self) -> None:
        data = {"x": 1}
        assert apply_output_path(data, "$") == data

    def test_nested_path(self) -> None:
        data = {"a": 1, "b": 2}
        assert apply_output_path(data, "$.a") == 1


class TestApplyResultPath:
    """ResultPath processing."""

    def test_null_discards_result(self) -> None:
        original = {"x": 1}
        result = apply_result_path(original, "discarded", None)
        assert result == {"x": 1}

    def test_root_replaces_input(self) -> None:
        result = apply_result_path({"x": 1}, {"y": 2}, "$")
        assert result == {"y": 2}

    def test_nested_path_sets_value(self) -> None:
        result = apply_result_path({"x": 1}, "hello", "$.greeting")
        assert result == {"x": 1, "greeting": "hello"}

    def test_deep_nested_path(self) -> None:
        result = apply_result_path({"x": 1}, "val", "$.a.b")
        assert result["a"]["b"] == "val"
        assert result["x"] == 1


class TestApplyParameters:
    """Parameters template processing."""

    def test_static_values(self) -> None:
        result = apply_parameters({"key": "value"}, {})
        assert result == {"key": "value"}

    def test_jsonpath_reference(self) -> None:
        result = apply_parameters({"name.$": "$.user"}, {"user": "Alice"})
        assert result == {"name": "Alice"}

    def test_mixed_static_and_dynamic(self) -> None:
        params = {"greeting": "hello", "name.$": "$.user"}
        result = apply_parameters(params, {"user": "Bob"})
        assert result == {"greeting": "hello", "name": "Bob"}

    def test_nested_parameters(self) -> None:
        params = {"outer": {"inner.$": "$.val"}}
        result = apply_parameters(params, {"val": 42})
        assert result == {"outer": {"inner": 42}}


class TestApplyContextParameters:
    """Parameters template with context object ($$ references)."""

    def test_context_reference(self) -> None:
        params = {"index.$": "$$.Map.Item.Index"}
        context = {"Map": {"Item": {"Index": 0}}}
        result = apply_context_parameters(params, {}, context)
        assert result == {"index": 0}

    def test_mixed_input_and_context(self) -> None:
        params = {
            "val.$": "$.data",
            "idx.$": "$$.Map.Item.Index",
        }
        context = {"Map": {"Item": {"Index": 3}}}
        result = apply_context_parameters(params, {"data": "hello"}, context)
        assert result == {"val": "hello", "idx": 3}


# ---------------------------------------------------------------------------
# Choice evaluator - String operators
# ---------------------------------------------------------------------------


class TestStringOperators:
    """String comparison operators."""

    def test_string_equals_true(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.s",
            comparison_operator="StringEquals",
            comparison_value="hello",
        )
        assert evaluate_rule(rule, {"s": "hello"}) is True

    def test_string_equals_false(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.s",
            comparison_operator="StringEquals",
            comparison_value="hello",
        )
        assert evaluate_rule(rule, {"s": "world"}) is False

    def test_string_greater_than(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.s",
            comparison_operator="StringGreaterThan",
            comparison_value="abc",
        )
        assert evaluate_rule(rule, {"s": "xyz"}) is True
        assert evaluate_rule(rule, {"s": "aaa"}) is False

    def test_string_less_than(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.s",
            comparison_operator="StringLessThan",
            comparison_value="m",
        )
        assert evaluate_rule(rule, {"s": "a"}) is True
        assert evaluate_rule(rule, {"s": "z"}) is False

    def test_string_greater_than_equals(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.s",
            comparison_operator="StringGreaterThanEquals",
            comparison_value="hello",
        )
        assert evaluate_rule(rule, {"s": "hello"}) is True
        assert evaluate_rule(rule, {"s": "world"}) is True
        assert evaluate_rule(rule, {"s": "abc"}) is False

    def test_string_less_than_equals(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.s",
            comparison_operator="StringLessThanEquals",
            comparison_value="hello",
        )
        assert evaluate_rule(rule, {"s": "hello"}) is True
        assert evaluate_rule(rule, {"s": "abc"}) is True
        assert evaluate_rule(rule, {"s": "world"}) is False

    def test_string_operator_with_non_string(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.s",
            comparison_operator="StringEquals",
            comparison_value="hello",
        )
        assert evaluate_rule(rule, {"s": 123}) is False


# ---------------------------------------------------------------------------
# Numeric operators
# ---------------------------------------------------------------------------


class TestNumericOperators:
    """Numeric comparison operators."""

    def test_numeric_equals(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.n",
            comparison_operator="NumericEquals",
            comparison_value=42,
        )
        assert evaluate_rule(rule, {"n": 42}) is True
        assert evaluate_rule(rule, {"n": 43}) is False

    def test_numeric_greater_than(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.n",
            comparison_operator="NumericGreaterThan",
            comparison_value=10,
        )
        assert evaluate_rule(rule, {"n": 20}) is True
        assert evaluate_rule(rule, {"n": 5}) is False

    def test_numeric_less_than(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.n",
            comparison_operator="NumericLessThan",
            comparison_value=10,
        )
        assert evaluate_rule(rule, {"n": 5}) is True
        assert evaluate_rule(rule, {"n": 15}) is False

    def test_numeric_greater_than_equals(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.n",
            comparison_operator="NumericGreaterThanEquals",
            comparison_value=10,
        )
        assert evaluate_rule(rule, {"n": 10}) is True
        assert evaluate_rule(rule, {"n": 11}) is True
        assert evaluate_rule(rule, {"n": 9}) is False

    def test_numeric_less_than_equals(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.n",
            comparison_operator="NumericLessThanEquals",
            comparison_value=10,
        )
        assert evaluate_rule(rule, {"n": 10}) is True
        assert evaluate_rule(rule, {"n": 9}) is True
        assert evaluate_rule(rule, {"n": 11}) is False

    def test_numeric_with_float(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.n",
            comparison_operator="NumericGreaterThan",
            comparison_value=1.5,
        )
        assert evaluate_rule(rule, {"n": 2.0}) is True
        assert evaluate_rule(rule, {"n": 1.0}) is False

    def test_numeric_with_non_number(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.n",
            comparison_operator="NumericEquals",
            comparison_value=42,
        )
        assert evaluate_rule(rule, {"n": "42"}) is False


# ---------------------------------------------------------------------------
# Boolean operator
# ---------------------------------------------------------------------------


class TestBooleanOperator:
    """BooleanEquals operator."""

    def test_boolean_equals_true(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.b",
            comparison_operator="BooleanEquals",
            comparison_value=True,
        )
        assert evaluate_rule(rule, {"b": True}) is True
        assert evaluate_rule(rule, {"b": False}) is False

    def test_boolean_equals_false(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.b",
            comparison_operator="BooleanEquals",
            comparison_value=False,
        )
        assert evaluate_rule(rule, {"b": False}) is True
        assert evaluate_rule(rule, {"b": True}) is False

    def test_boolean_with_non_bool(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.b",
            comparison_operator="BooleanEquals",
            comparison_value=True,
        )
        assert evaluate_rule(rule, {"b": 1}) is False


# ---------------------------------------------------------------------------
# Type-checking operators
# ---------------------------------------------------------------------------


class TestTypeCheckOperators:
    """IsPresent, IsNull, IsString, IsNumeric, IsBoolean operators."""

    def test_is_present_true(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.x",
            comparison_operator="IsPresent",
            comparison_value=True,
        )
        assert evaluate_rule(rule, {"x": 1}) is True

    def test_is_present_false_when_missing(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.x",
            comparison_operator="IsPresent",
            comparison_value=True,
        )
        assert evaluate_rule(rule, {"y": 1}) is False

    def test_is_present_inverted(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.x",
            comparison_operator="IsPresent",
            comparison_value=False,
        )
        assert evaluate_rule(rule, {"y": 1}) is True

    def test_is_null_true(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.x",
            comparison_operator="IsNull",
            comparison_value=True,
        )
        assert evaluate_rule(rule, {"x": None}) is True
        assert evaluate_rule(rule, {"x": 1}) is False

    def test_is_string(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.x",
            comparison_operator="IsString",
            comparison_value=True,
        )
        assert evaluate_rule(rule, {"x": "hello"}) is True
        assert evaluate_rule(rule, {"x": 123}) is False

    def test_is_numeric(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.x",
            comparison_operator="IsNumeric",
            comparison_value=True,
        )
        assert evaluate_rule(rule, {"x": 42}) is True
        assert evaluate_rule(rule, {"x": 3.14}) is True
        assert evaluate_rule(rule, {"x": "42"}) is False
        assert evaluate_rule(rule, {"x": True}) is False

    def test_is_boolean(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.x",
            comparison_operator="IsBoolean",
            comparison_value=True,
        )
        assert evaluate_rule(rule, {"x": True}) is True
        assert evaluate_rule(rule, {"x": False}) is True
        assert evaluate_rule(rule, {"x": 1}) is False


# ---------------------------------------------------------------------------
# Logical combinators
# ---------------------------------------------------------------------------


class TestLogicalCombinators:
    """And, Or, Not combinators."""

    def test_and_all_true(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            and_rules=[
                ChoiceRule(
                    next_state="",
                    variable="$.a",
                    comparison_operator="NumericGreaterThan",
                    comparison_value=0,
                ),
                ChoiceRule(
                    next_state="",
                    variable="$.b",
                    comparison_operator="NumericGreaterThan",
                    comparison_value=0,
                ),
            ],
        )
        assert evaluate_rule(rule, {"a": 1, "b": 2}) is True

    def test_and_one_false(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            and_rules=[
                ChoiceRule(
                    next_state="",
                    variable="$.a",
                    comparison_operator="NumericGreaterThan",
                    comparison_value=0,
                ),
                ChoiceRule(
                    next_state="",
                    variable="$.b",
                    comparison_operator="NumericGreaterThan",
                    comparison_value=0,
                ),
            ],
        )
        assert evaluate_rule(rule, {"a": 1, "b": -1}) is False

    def test_or_one_true(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            or_rules=[
                ChoiceRule(
                    next_state="",
                    variable="$.a",
                    comparison_operator="StringEquals",
                    comparison_value="yes",
                ),
                ChoiceRule(
                    next_state="",
                    variable="$.b",
                    comparison_operator="StringEquals",
                    comparison_value="yes",
                ),
            ],
        )
        assert evaluate_rule(rule, {"a": "no", "b": "yes"}) is True

    def test_or_none_true(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            or_rules=[
                ChoiceRule(
                    next_state="",
                    variable="$.a",
                    comparison_operator="StringEquals",
                    comparison_value="yes",
                ),
                ChoiceRule(
                    next_state="",
                    variable="$.b",
                    comparison_operator="StringEquals",
                    comparison_value="yes",
                ),
            ],
        )
        assert evaluate_rule(rule, {"a": "no", "b": "no"}) is False

    def test_not_inverts(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            not_rule=ChoiceRule(
                next_state="",
                variable="$.x",
                comparison_operator="NumericEquals",
                comparison_value=0,
            ),
        )
        assert evaluate_rule(rule, {"x": 5}) is True
        assert evaluate_rule(rule, {"x": 0}) is False


# ---------------------------------------------------------------------------
# evaluate_choice_rules
# ---------------------------------------------------------------------------


class TestEvaluateChoiceRules:
    """Evaluating a list of choice rules."""

    def test_first_matching_rule_wins(self) -> None:
        rules = [
            ChoiceRule(
                next_state="First",
                variable="$.x",
                comparison_operator="NumericGreaterThan",
                comparison_value=0,
            ),
            ChoiceRule(
                next_state="Second",
                variable="$.x",
                comparison_operator="NumericGreaterThan",
                comparison_value=-10,
            ),
        ]
        result = evaluate_choice_rules(rules, {"x": 5})
        assert result == "First"

    def test_no_match_returns_none(self) -> None:
        rules = [
            ChoiceRule(
                next_state="Match",
                variable="$.x",
                comparison_operator="StringEquals",
                comparison_value="nope",
            ),
        ]
        result = evaluate_choice_rules(rules, {"x": "different"})
        assert result is None

    def test_empty_rules_returns_none(self) -> None:
        result = evaluate_choice_rules([], {"x": 1})
        assert result is None

    def test_missing_variable_returns_false(self) -> None:
        rule = ChoiceRule(
            next_state="N",
            variable="$.missing",
            comparison_operator="NumericEquals",
            comparison_value=1,
        )
        assert evaluate_rule(rule, {"x": 1}) is False
