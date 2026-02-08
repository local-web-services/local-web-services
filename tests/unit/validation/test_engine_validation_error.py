"""Tests for ldk.validation.engine."""

from __future__ import annotations

from ldk.validation.engine import (
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
        issues = [
            ValidationIssue(level=ValidationLevel.ERROR, message="e1"),
            ValidationIssue(level=ValidationLevel.ERROR, message="e2"),
        ]
        err = ValidationError(issues)
        assert err.issues == issues
        assert "2 issue(s)" in str(err)
        assert "e1" in str(err)
