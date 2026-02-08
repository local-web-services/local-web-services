"""Tests for ldk.validation.engine."""

from __future__ import annotations

import pytest

from ldk.validation.engine import (
    ValidationContext,
    ValidationEngine,
    ValidationError,
)

from ._helpers import _AlwaysErrorValidator, _AlwaysWarnValidator

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
