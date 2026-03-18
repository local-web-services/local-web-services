"""Validation engine framework with configurable strictness.

Provides the core validation infrastructure: a Validator ABC, ValidationIssue
dataclass, ValidationContext, and the ValidationEngine that orchestrates
registered validators.
"""

from __future__ import annotations

import logging
from abc import ABC, abstractmethod
from dataclasses import dataclass, field
from enum import Enum
from typing import TYPE_CHECKING, Any

if TYPE_CHECKING:
    from lws.graph.builder import AppGraph

logger = logging.getLogger(__name__)


# ---------------------------------------------------------------------------
# Enums
# ---------------------------------------------------------------------------


class ValidationLevel(Enum):
    """Severity level for a validation issue."""

    WARN = "warn"
    ERROR = "error"


class StrictnessMode(Enum):
    """How the engine treats validation errors."""

    WARN = "warn"
    STRICT = "strict"


# ---------------------------------------------------------------------------
# Data structures
# ---------------------------------------------------------------------------


class ValidationError(Exception):
    """Raised in strict mode when validation errors are found."""

    def __init__(self, issues: list[ValidationIssue]) -> None:
        self.issues = issues
        messages = [f"[{i.level.value}] {i.message}" for i in issues]
        super().__init__(f"Validation failed with {len(issues)} issue(s): " + "; ".join(messages))


@dataclass
class ValidationIssue:
    """A single validation finding."""

    level: ValidationLevel
    message: str
    resource: str = ""
    operation: str = ""


@dataclass
class ValidationContext:
    """Context passed to each validator for a single operation."""

    handler_id: str
    resource_id: str
    operation: str
    data: dict[str, Any] = field(default_factory=dict)
    app_graph: AppGraph | None = None


# ---------------------------------------------------------------------------
# Validator ABC
# ---------------------------------------------------------------------------


class Validator(ABC):
    """Abstract base class for all validators."""

    @property
    @abstractmethod
    def name(self) -> str:
        """Unique name for this validator."""

    @abstractmethod
    def validate(self, context: ValidationContext) -> list[ValidationIssue]:
        """Validate the given context and return any issues found."""


# ---------------------------------------------------------------------------
# ValidationEngine
# ---------------------------------------------------------------------------


class ValidationEngine:
    """Orchestrates registered validators with configurable strictness.

    Parameters
    ----------
    strictness:
        Global strictness mode. ``"warn"`` logs issues and continues;
        ``"strict"`` raises ``ValidationError`` on any ERROR-level issue.
    validator_overrides:
        Per-validator strictness overrides keyed by validator name.
    """

    def __init__(
        self,
        strictness: str = "warn",
        validator_overrides: dict[str, str] | None = None,
    ) -> None:
        self._strictness = StrictnessMode(strictness)
        self._overrides: dict[str, StrictnessMode] = {}
        for name, mode in (validator_overrides or {}).items():
            self._overrides[name] = StrictnessMode(mode)
        self._validators: list[Validator] = []

    def register(self, validator: Validator) -> None:
        """Register a validator with the engine."""
        self._validators.append(validator)

    def _effective_strictness(self, validator_name: str) -> StrictnessMode:
        """Return the effective strictness for a validator."""
        return self._overrides.get(validator_name, self._strictness)

    def validate(self, context: ValidationContext) -> list[ValidationIssue]:
        """Run all registered validators and collect issues.

        In strict mode (global or per-validator override), raises
        ``ValidationError`` if any ERROR-level issues are found.

        Returns
        -------
        list[ValidationIssue]
            All issues found across all validators.
        """
        all_issues: list[ValidationIssue] = []
        strict_errors: list[ValidationIssue] = []

        for validator in self._validators:
            issues = validator.validate(context)
            all_issues.extend(issues)
            mode = self._effective_strictness(validator.name)
            self._process_issues(issues, mode, strict_errors)

        if strict_errors:
            raise ValidationError(strict_errors)

        return all_issues

    def _process_issues(
        self,
        issues: list[ValidationIssue],
        mode: StrictnessMode,
        strict_errors: list[ValidationIssue],
    ) -> None:
        """Log issues and collect strict-mode errors."""
        for issue in issues:
            if issue.level == ValidationLevel.WARN:
                logger.warning("Validation warning: %s", issue.message)
            elif issue.level == ValidationLevel.ERROR:
                if mode == StrictnessMode.STRICT:
                    strict_errors.append(issue)
                else:
                    logger.warning("Validation error (warn mode): %s", issue.message)
