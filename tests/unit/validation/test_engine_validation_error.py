"""Tests for ldk.validation.engine."""

from __future__ import annotations

from lws.validation.engine import (
    ValidationContext,
    ValidationError,
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


class TestValidationError:
    def test_error_contains_issues(self) -> None:
        # Arrange
        expected_message_1 = "e1"
        expected_message_2 = "e2"
        expected_issue_summary = "2 issue(s)"
        issues = [
            ValidationIssue(level=ValidationLevel.ERROR, message=expected_message_1),
            ValidationIssue(level=ValidationLevel.ERROR, message=expected_message_2),
        ]

        # Act
        err = ValidationError(issues)
        actual_str = str(err)

        # Assert
        assert err.issues == issues
        assert expected_issue_summary in actual_str
        assert expected_message_1 in actual_str
