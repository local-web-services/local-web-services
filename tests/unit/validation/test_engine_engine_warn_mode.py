"""Tests for ldk.validation.engine."""

from __future__ import annotations

from lws.validation.engine import (
    ValidationContext,
    ValidationEngine,
    ValidationLevel,
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


class TestEngineWarnMode:
    def test_no_validators_returns_empty(self) -> None:
        # Arrange
        engine = ValidationEngine(strictness="warn")

        # Act
        issues = engine.validate(_make_context())

        # Assert
        assert issues == []

    def test_warn_validator_returns_issues(self) -> None:
        # Arrange
        expected_issue_count = 1
        engine = ValidationEngine(strictness="warn")
        engine.register(_AlwaysWarnValidator())

        # Act
        issues = engine.validate(_make_context())

        # Assert
        assert len(issues) == expected_issue_count
        assert issues[0].level == ValidationLevel.WARN

    def test_error_in_warn_mode_does_not_raise(self) -> None:
        # Arrange
        expected_issue_count = 1
        engine = ValidationEngine(strictness="warn")
        engine.register(_AlwaysErrorValidator())

        # Act
        issues = engine.validate(_make_context())

        # Assert
        assert len(issues) == expected_issue_count
        assert issues[0].level == ValidationLevel.ERROR

    def test_multiple_validators_collect_all(self) -> None:
        # Arrange
        expected_issue_count = 2
        engine = ValidationEngine(strictness="warn")
        engine.register(_AlwaysWarnValidator())
        engine.register(_AlwaysErrorValidator())
        engine.register(_NoIssueValidator())

        # Act
        issues = engine.validate(_make_context())

        # Assert
        assert len(issues) == expected_issue_count
