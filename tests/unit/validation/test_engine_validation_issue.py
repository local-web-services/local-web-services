"""Tests for ldk.validation.engine."""

from __future__ import annotations

from lws.validation.engine import (
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
        # Arrange
        expected_message = "bad thing"
        expected_resource = "tbl"
        expected_operation = "put"

        # Act
        issue = ValidationIssue(
            level=ValidationLevel.ERROR,
            message=expected_message,
            resource=expected_resource,
            operation=expected_operation,
        )

        # Assert
        assert issue.level == ValidationLevel.ERROR
        assert issue.message == expected_message
        assert issue.resource == expected_resource
        assert issue.operation == expected_operation

    def test_issue_defaults(self) -> None:
        # Arrange
        expected_resource = ""
        expected_operation = ""

        # Act
        issue = ValidationIssue(level=ValidationLevel.WARN, message="hmm")

        # Assert
        assert issue.resource == expected_resource
        assert issue.operation == expected_operation
