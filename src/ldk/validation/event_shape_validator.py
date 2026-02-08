"""Event shape validator.

Defines expected event schemas per trigger type and validates constructed
events before handler invocation. Uses simple dict-based validation
(required keys and type checks) without Pydantic.
"""

from __future__ import annotations

from typing import Any

from ldk.validation.engine import (
    ValidationContext,
    ValidationIssue,
    ValidationLevel,
    Validator,
)

# ---------------------------------------------------------------------------
# Event schema definitions: list of (key_path, expected_type | None)
# A key_path is a dot-separated string for nested lookups.
# If expected_type is None, only presence is checked.
# ---------------------------------------------------------------------------

_API_GATEWAY_REQUIRED: list[tuple[str, type | None]] = [
    ("httpMethod", str),
    ("path", str),
    ("headers", dict),
    ("queryStringParameters", None),
    ("body", None),
    ("requestContext", dict),
]

_SQS_REQUIRED: list[tuple[str, type | None]] = [
    ("Records", list),
]

_SQS_RECORD_REQUIRED: list[tuple[str, type | None]] = [
    ("messageId", str),
    ("body", str),
    ("eventSource", str),
]

_S3_REQUIRED: list[tuple[str, type | None]] = [
    ("Records", list),
]

_S3_RECORD_REQUIRED: list[tuple[str, type | None]] = [
    ("eventSource", str),
    ("eventName", str),
    ("s3", dict),
]

_SNS_REQUIRED: list[tuple[str, type | None]] = [
    ("Records", list),
]

_SNS_RECORD_REQUIRED: list[tuple[str, type | None]] = [
    ("EventSource", str),
    ("Sns", dict),
]

_EVENTBRIDGE_REQUIRED: list[tuple[str, type | None]] = [
    ("source", str),
    ("detail-type", str),
    ("detail", dict),
]

# Maps trigger type to (top-level schema, optional record schema).
_TRIGGER_SCHEMAS: dict[str, tuple[list[tuple[str, type | None]], list[tuple[str, type | None]]]] = {
    "api_gateway": (_API_GATEWAY_REQUIRED, []),
    "sqs": (_SQS_REQUIRED, _SQS_RECORD_REQUIRED),
    "s3": (_S3_REQUIRED, _S3_RECORD_REQUIRED),
    "sns": (_SNS_REQUIRED, _SNS_RECORD_REQUIRED),
    "eventbridge": (_EVENTBRIDGE_REQUIRED, []),
}


class EventShapeValidator(Validator):
    """Validates event shapes against expected schemas for each trigger type."""

    @property
    def name(self) -> str:
        return "event_shape"

    def validate(self, context: ValidationContext) -> list[ValidationIssue]:
        """Validate the event in context.data against the trigger type schema."""
        trigger_type = context.data.get("trigger_type", "")
        event = context.data.get("event", {})

        if not trigger_type or not isinstance(event, dict):
            return []

        schema_pair = _TRIGGER_SCHEMAS.get(trigger_type.lower())
        if schema_pair is None:
            return []

        top_schema, record_schema = schema_pair
        issues = _validate_fields(event, top_schema, context)

        if record_schema:
            issues.extend(_validate_records(event, record_schema, context))

        return issues


def _validate_fields(
    data: dict[str, Any],
    schema: list[tuple[str, type | None]],
    context: ValidationContext,
) -> list[ValidationIssue]:
    """Validate that required fields exist and have correct types."""
    issues: list[ValidationIssue] = []
    for key_path, expected_type in schema:
        value = _get_nested(data, key_path)
        if value is None and key_path not in data:
            issues.append(_missing_field(key_path, context))
        elif expected_type is not None and value is not None:
            if not isinstance(value, expected_type):
                issues.append(_wrong_type(key_path, expected_type, value, context))
    return issues


def _validate_records(
    data: dict[str, Any],
    record_schema: list[tuple[str, type | None]],
    context: ValidationContext,
) -> list[ValidationIssue]:
    """Validate individual records within a Records array."""
    records = data.get("Records")
    if not isinstance(records, list):
        return []

    issues: list[ValidationIssue] = []
    for idx, record in enumerate(records):
        if not isinstance(record, dict):
            issues.append(
                ValidationIssue(
                    level=ValidationLevel.WARN,
                    message=f"Records[{idx}] is not a dict",
                    resource=context.resource_id,
                    operation=context.operation,
                )
            )
            continue
        for key_path, expected_type in record_schema:
            value = record.get(key_path)
            if value is None and key_path not in record:
                issues.append(_missing_field(f"Records[{idx}].{key_path}", context))
            elif expected_type is not None and value is not None:
                if not isinstance(value, expected_type):
                    issues.append(
                        _wrong_type(f"Records[{idx}].{key_path}", expected_type, value, context)
                    )
    return issues


def _get_nested(data: dict[str, Any], key_path: str) -> Any:
    """Retrieve a value from a dict using a dot-separated key path."""
    # For top-level keys containing dashes (e.g. "detail-type"), try direct lookup first.
    if key_path in data:
        return data[key_path]
    parts = key_path.split(".")
    current: Any = data
    for part in parts:
        if not isinstance(current, dict):
            return None
        current = current.get(part)
        if current is None:
            return None
    return current


def _missing_field(
    key_path: str,
    context: ValidationContext,
) -> ValidationIssue:
    """Create an issue for a missing required field."""
    return ValidationIssue(
        level=ValidationLevel.WARN,
        message=f"Missing required event field '{key_path}'",
        resource=context.resource_id,
        operation=context.operation,
    )


def _wrong_type(
    key_path: str,
    expected_type: type,
    actual_value: Any,
    context: ValidationContext,
) -> ValidationIssue:
    """Create an issue for a type mismatch."""
    return ValidationIssue(
        level=ValidationLevel.WARN,
        message=(
            f"Event field '{key_path}' expected type "
            f"'{expected_type.__name__}', got '{type(actual_value).__name__}'"
        ),
        resource=context.resource_id,
        operation=context.operation,
    )
