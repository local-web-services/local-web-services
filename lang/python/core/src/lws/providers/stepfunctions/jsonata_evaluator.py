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


def evaluate_expression(
    expression: str,
    input_data: Any,
    result: Any = None,
    variables: dict[str, Any] | None = None,
) -> Any:
    """Evaluate a JSONata expression with $states bindings including context variables."""
    if not _JSONATA_AVAILABLE:
        raise RuntimeError(
            "jsonata-python is required for JSONata support. "
            "Install with: pip install jsonata-python"
        )
    expr = _jsonata_lib.Jsonata(expression)
    context: dict[str, Any] = {"variables": variables or {}}
    expr.assign("states", {"input": input_data, "result": result, "context": context})
    return expr.evaluate(input_data if input_data is not None else {})


def expand_arguments(
    arguments: dict[str, Any],
    input_data: Any,
    variables: dict[str, Any] | None = None,
) -> dict[str, Any]:
    """Expand {%...%} JSONata expressions in an Arguments template dict.

    Non-expression values are returned as-is.
    """
    return {key: _expand_value(value, input_data, variables) for key, value in arguments.items()}


def _expand_value(
    value: Any,
    input_data: Any,
    variables: dict[str, Any] | None = None,
    result: Any = None,
) -> Any:
    """Evaluate if value is a {%...%} expression; recurse into dicts; else return as-is."""
    if isinstance(value, str) and is_jsonata_expression(value):
        return evaluate_expression(
            extract_expression(value), input_data, result=result, variables=variables
        )
    if isinstance(value, dict):
        return {k: _expand_value(v, input_data, variables, result) for k, v in value.items()}
    return value


def evaluate_output(
    output: Any,
    input_data: Any,
    result: Any = None,
    variables: dict[str, Any] | None = None,
) -> Any:
    """Evaluate the Output field of a JSONata-mode state.

    If output is a {%...%} expression string, evaluate it as a full expression with
    $states.input and $states.result bound. If output is a dict, recursively expand
    {%...%} values within it. Otherwise return the value unchanged.
    """
    if isinstance(output, str) and is_jsonata_expression(output):
        return evaluate_expression(
            extract_expression(output), input_data, result=result, variables=variables
        )
    if isinstance(output, dict):
        return {k: _expand_value(v, input_data, variables, result) for k, v in output.items()}
    return output


def evaluate_assign(
    assign: dict[str, Any],
    input_data: Any,
    variables: dict[str, Any] | None = None,
) -> dict[str, Any]:
    """Evaluate an Assign dict, expanding {%...%} expressions into resolved key-value pairs."""
    return {key: _expand_value(value, input_data, variables) for key, value in assign.items()}


def evaluate_condition(
    condition: str,
    input_data: Any,
    variables: dict[str, Any] | None = None,
) -> bool:
    """Evaluate a JSONata Condition expression and return its boolean result."""
    if is_jsonata_expression(condition):
        result = evaluate_expression(extract_expression(condition), input_data, variables=variables)
    else:
        result = evaluate_expression(condition, input_data, variables=variables)
    return bool(result)


def resolve_credentials(
    credentials: dict[str, Any],
    input_data: Any,
    variables: dict[str, Any] | None = None,
) -> dict[str, Any]:
    """Resolve Credentials dict by evaluating any {%...%} expressions in values."""
    return {key: _expand_value(value, input_data, variables) for key, value in credentials.items()}
