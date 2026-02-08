"""Tests for ldk.validation.engine."""

from __future__ import annotations

from ldk.validation.engine import (
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
        engine = ValidationEngine(strictness="warn")
        issues = engine.validate(_make_context())
        assert issues == []

    def test_warn_validator_returns_issues(self) -> None:
        engine = ValidationEngine(strictness="warn")
        engine.register(_AlwaysWarnValidator())
        issues = engine.validate(_make_context())
        assert len(issues) == 1
        assert issues[0].level == ValidationLevel.WARN

    def test_error_in_warn_mode_does_not_raise(self) -> None:
        engine = ValidationEngine(strictness="warn")
        engine.register(_AlwaysErrorValidator())
        issues = engine.validate(_make_context())
        assert len(issues) == 1
        assert issues[0].level == ValidationLevel.ERROR

    def test_multiple_validators_collect_all(self) -> None:
        engine = ValidationEngine(strictness="warn")
        engine.register(_AlwaysWarnValidator())
        engine.register(_AlwaysErrorValidator())
        engine.register(_NoIssueValidator())
        issues = engine.validate(_make_context())
        assert len(issues) == 2
