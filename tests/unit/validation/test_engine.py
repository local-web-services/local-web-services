"""Tests for ldk.validation.engine."""

from __future__ import annotations

import pytest

from ldk.validation.engine import (
    StrictnessMode,
    ValidationContext,
    ValidationEngine,
    ValidationError,
    ValidationIssue,
    ValidationLevel,
    Validator,
)

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


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


# ---------------------------------------------------------------------------
# ValidationError
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


# ---------------------------------------------------------------------------
# ValidationEngine - warn mode
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


# ---------------------------------------------------------------------------
# ValidationEngine - strict mode
# ---------------------------------------------------------------------------


class TestEngineStrictMode:
    def test_strict_mode_raises_on_error(self) -> None:
        engine = ValidationEngine(strictness="strict")
        engine.register(_AlwaysErrorValidator())
        with pytest.raises(ValidationError) as exc_info:
            engine.validate(_make_context())
        assert len(exc_info.value.issues) == 1

    def test_strict_mode_warns_do_not_raise(self) -> None:
        engine = ValidationEngine(strictness="strict")
        engine.register(_AlwaysWarnValidator())
        issues = engine.validate(_make_context())
        assert len(issues) == 1

    def test_strict_mode_no_issues_ok(self) -> None:
        engine = ValidationEngine(strictness="strict")
        engine.register(_NoIssueValidator())
        issues = engine.validate(_make_context())
        assert issues == []


# ---------------------------------------------------------------------------
# Per-validator overrides
# ---------------------------------------------------------------------------


class TestValidatorOverrides:
    def test_override_strict_for_single_validator(self) -> None:
        """Global warn, but override one validator to strict."""
        engine = ValidationEngine(
            strictness="warn",
            validator_overrides={"always_error": "strict"},
        )
        engine.register(_AlwaysErrorValidator())
        engine.register(_AlwaysWarnValidator())
        with pytest.raises(ValidationError) as exc_info:
            engine.validate(_make_context())
        assert len(exc_info.value.issues) == 1

    def test_override_warn_for_single_validator(self) -> None:
        """Global strict, but override one validator to warn."""
        engine = ValidationEngine(
            strictness="strict",
            validator_overrides={"always_error": "warn"},
        )
        engine.register(_AlwaysErrorValidator())
        issues = engine.validate(_make_context())
        assert len(issues) == 1


# ---------------------------------------------------------------------------
# StrictnessMode
# ---------------------------------------------------------------------------


class TestStrictnessMode:
    def test_warn_value(self) -> None:
        assert StrictnessMode.WARN.value == "warn"

    def test_strict_value(self) -> None:
        assert StrictnessMode.STRICT.value == "strict"


# ---------------------------------------------------------------------------
# ValidationLevel
# ---------------------------------------------------------------------------


class TestValidationLevel:
    def test_warn_value(self) -> None:
        assert ValidationLevel.WARN.value == "warn"

    def test_error_value(self) -> None:
        assert ValidationLevel.ERROR.value == "error"
