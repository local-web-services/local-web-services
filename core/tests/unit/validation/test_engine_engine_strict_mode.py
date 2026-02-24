"""Tests for ldk.validation.engine."""

from __future__ import annotations

import pytest

from lws.validation.engine import (
    ValidationContext,
    ValidationEngine,
    ValidationError,
)

from ._helpers import _AlwaysErrorValidator, _AlwaysWarnValidator, _NoIssueValidator

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


class TestEngineStrictMode:
    def test_strict_mode_raises_on_error(self) -> None:
        # Arrange
        expected_issue_count = 1
        engine = ValidationEngine(strictness="strict")
        engine.register(_AlwaysErrorValidator())

        # Act / Assert
        with pytest.raises(ValidationError) as exc_info:
            engine.validate(_make_context())
        assert len(exc_info.value.issues) == expected_issue_count

    def test_strict_mode_warns_do_not_raise(self) -> None:
        # Arrange
        expected_issue_count = 1
        engine = ValidationEngine(strictness="strict")
        engine.register(_AlwaysWarnValidator())

        # Act
        issues = engine.validate(_make_context())

        # Assert
        assert len(issues) == expected_issue_count

    def test_strict_mode_no_issues_ok(self) -> None:
        # Arrange
        engine = ValidationEngine(strictness="strict")
        engine.register(_NoIssueValidator())

        # Act
        issues = engine.validate(_make_context())

        # Assert
        assert issues == []
