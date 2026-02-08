"""Tests for ldk.validation.engine."""

from __future__ import annotations

from ldk.validation.engine import (
    ValidationContext,
    ValidationIssue,
    ValidationLevel,
)

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _make_context(
    handler_id: str = "handler1",
    resource_id: str = "table1",
    operation: str = "put_item",
) -> ValidationContext:
    return ValidationContext(
        handler_id=handler_id,
        resource_id=resource_id,
        operation=operation,
    )


# ---------------------------------------------------------------------------
# ValidationIssue
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# ValidationError
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# ValidationEngine - warn mode
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# ValidationEngine - strict mode
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Per-validator overrides
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# StrictnessMode
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# ValidationLevel
# ---------------------------------------------------------------------------


class TestValidationIssue:
    def test_issue_fields(self) -> None:
        issue = ValidationIssue(
            level=ValidationLevel.ERROR,
            message="bad thing",
            resource="tbl",
            operation="put",
        )
        assert issue.level == ValidationLevel.ERROR
        assert issue.message == "bad thing"
        assert issue.resource == "tbl"
        assert issue.operation == "put"

    def test_issue_defaults(self) -> None:
        issue = ValidationIssue(level=ValidationLevel.WARN, message="hmm")
        assert issue.resource == ""
        assert issue.operation == ""
