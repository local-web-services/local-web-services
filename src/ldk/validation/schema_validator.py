"""DynamoDB schema validator.

Validates that write operations (putItem, updateItem, deleteItem) include
the required partition key and sort key, and that key values match the
expected DynamoDB type (S, N, B).
"""

from __future__ import annotations

from typing import Any

from ldk.interfaces import KeySchema, TableConfig
from ldk.validation.engine import (
    ValidationContext,
    ValidationIssue,
    ValidationLevel,
    Validator,
)

# Operations that require key validation.
_KEY_OPERATIONS = frozenset({"put_item", "update_item", "delete_item", "get_item"})

# DynamoDB type descriptors mapped to expected Python types.
_TYPE_VALIDATORS: dict[str, type] = {
    "S": str,
    "N": (str, int, float),  # type: ignore[assignment]
    "B": (str, bytes),  # type: ignore[assignment]
}


class SchemaValidator(Validator):
    """Validates DynamoDB item data against a table's key schema."""

    def __init__(self, table_configs: dict[str, TableConfig]) -> None:
        self._table_configs = table_configs

    @property
    def name(self) -> str:
        return "schema"

    def validate(self, context: ValidationContext) -> list[ValidationIssue]:
        """Check that key attributes are present and correctly typed."""
        operation = context.operation.lower()
        if operation not in _KEY_OPERATIONS:
            return []

        config = self._table_configs.get(context.resource_id)
        if config is None:
            return []

        return _validate_keys(context, config.key_schema)


def _validate_keys(
    context: ValidationContext,
    key_schema: KeySchema,
) -> list[ValidationIssue]:
    """Validate partition key and optional sort key in context data."""
    issues: list[ValidationIssue] = []
    data = context.data

    # Partition key is always required.
    pk = key_schema.partition_key
    issues.extend(_check_key_attr(pk.name, pk.type, data, context))

    # Sort key is required only if defined.
    if key_schema.sort_key is not None:
        sk = key_schema.sort_key
        issues.extend(_check_key_attr(sk.name, sk.type, data, context))

    return issues


def _check_key_attr(
    attr_name: str,
    expected_type: str,
    data: dict[str, Any],
    context: ValidationContext,
) -> list[ValidationIssue]:
    """Check a single key attribute for presence and type correctness."""
    issues: list[ValidationIssue] = []

    value = data.get(attr_name)
    if value is None:
        issues.append(
            ValidationIssue(
                level=ValidationLevel.ERROR,
                message=f"Missing required key attribute '{attr_name}'",
                resource=context.resource_id,
                operation=context.operation,
            )
        )
        return issues

    # Handle DynamoDB JSON format: {"S": "value"}
    if isinstance(value, dict) and len(value) == 1:
        type_key = next(iter(value))
        if type_key in ("S", "N", "B"):
            if type_key != expected_type:
                issues.append(_type_mismatch(attr_name, expected_type, type_key, context))
            return issues

    # Handle plain values
    type_check = _TYPE_VALIDATORS.get(expected_type)
    if type_check is not None and not isinstance(value, type_check):
        actual = type(value).__name__
        issues.append(_type_mismatch(attr_name, expected_type, actual, context))

    return issues


def _type_mismatch(
    attr_name: str,
    expected: str,
    actual: str,
    context: ValidationContext,
) -> ValidationIssue:
    """Create a type mismatch issue."""
    return ValidationIssue(
        level=ValidationLevel.ERROR,
        message=(
            f"Key attribute '{attr_name}' type mismatch: " f"expected '{expected}', got '{actual}'"
        ),
        resource=context.resource_id,
        operation=context.operation,
    )
