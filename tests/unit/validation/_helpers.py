from __future__ import annotations

from lws.validation.engine import (
    ValidationContext,
    ValidationIssue,
    ValidationLevel,
    Validator,
)


class _AlwaysWarnValidator(Validator):
    """A validator that always returns a WARN-level issue."""

    @property
    def name(self) -> str:
        return "always_warn"

    def validate(self, context: ValidationContext) -> list[ValidationIssue]:
        return [
            ValidationIssue(
                level=ValidationLevel.WARN,
                message="Something looks off",
                resource=context.resource_id,
                operation=context.operation,
            )
        ]


class _AlwaysErrorValidator(Validator):
    """A validator that always returns an ERROR-level issue."""

    @property
    def name(self) -> str:
        return "always_error"

    def validate(self, context: ValidationContext) -> list[ValidationIssue]:
        return [
            ValidationIssue(
                level=ValidationLevel.ERROR,
                message="Something is wrong",
                resource=context.resource_id,
                operation=context.operation,
            )
        ]


class _NoIssueValidator(Validator):
    """A validator that never returns issues."""

    @property
    def name(self) -> str:
        return "no_issue"

    def validate(self, context: ValidationContext) -> list[ValidationIssue]:
        return []
