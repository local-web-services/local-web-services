"""JSONata expression evaluator for Step Functions state machine execution.

Provides expression evaluation using the jsonata-python library. Handles
the {%...%} expression syntax used in the Arguments and Output fields of
JSONata-mode state machine states.
"""

from __future__ import annotations

from typing import Any

try:
    import jsonata as _jsonata_lib

    _JSONATA_AVAILABLE = True
except ImportError:
    _JSONATA_AVAILABLE = False

_EXPR_OPEN = "{%"
_EXPR_CLOSE = "%}"


def is_jsonata_expression(value: str) -> bool:
    """Return True if a string value is a {%...%} JSONata expression template."""
    return value.startswith(_EXPR_OPEN) and value.endswith(_EXPR_CLOSE)


def extract_expression(value: str) -> str:
    """Strip {%...%} delimiters and surrounding whitespace from an expression."""
    return value[len(_EXPR_OPEN) : -len(_EXPR_CLOSE)].strip()


def evaluate_expression(expression: str, input_data: Any, result: Any = None) -> Any:
    """Evaluate a JSONata expression with $states.input and $states.result bound."""
    if not _JSONATA_AVAILABLE:
        raise RuntimeError(
            "jsonata-python is required for JSONata support. "
            "Install with: pip install jsonata-python"
        )
    expr = _jsonata_lib.Jsonata(expression)
    expr.assign("states", {"input": input_data, "result": result})
    return expr.evaluate(input_data if input_data is not None else {})


def expand_arguments(arguments: dict[str, Any], input_data: Any) -> dict[str, Any]:
    """Expand {%...%} JSONata expressions in an Arguments template dict.

    Non-expression values are returned as-is.
    """
    return {key: _expand_value(value, input_data) for key, value in arguments.items()}


def _expand_value(value: Any, input_data: Any) -> Any:
    """Evaluate if value is a {%...%} expression; recurse into dicts; else return as-is."""
    if isinstance(value, str) and is_jsonata_expression(value):
        return evaluate_expression(extract_expression(value), input_data)
    if isinstance(value, dict):
        return {k: _expand_value(v, input_data) for k, v in value.items()}
    return value


def evaluate_output(output: Any, input_data: Any, result: Any = None) -> Any:
    """Evaluate the Output field of a JSONata-mode state.

    If output is a {%...%} expression string, evaluate it with $states.input and
    $states.result bound. Otherwise return the value unchanged.
    """
    if isinstance(output, str) and is_jsonata_expression(output):
        return evaluate_expression(extract_expression(output), input_data, result=result)
    return output
