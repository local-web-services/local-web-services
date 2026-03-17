"""Execution tracking dataclasses and exceptions for the Step Functions engine."""

from __future__ import annotations

from dataclasses import dataclass, field
from enum import Enum
from typing import Any


# ---------------------------------------------------------------------------
# Execution tracking
# ---------------------------------------------------------------------------


class ExecutionStatus(Enum):
    """Status of a state machine execution."""

    RUNNING = "RUNNING"
    SUCCEEDED = "SUCCEEDED"
    FAILED = "FAILED"
    TIMED_OUT = "TIMED_OUT"
    ABORTED = "ABORTED"


@dataclass
class StateTransition:
    """Record of a single state transition during execution."""

    state_name: str
    state_type: str
    timestamp: float
    input_data: Any = None
    output_data: Any = None
    error: str | None = None
    cause: str | None = None


@dataclass
class ExecutionHistory:
    """Complete history of a state machine execution."""

    execution_arn: str
    state_machine_name: str
    status: ExecutionStatus = ExecutionStatus.RUNNING
    start_time: float = 0.0
    end_time: float | None = None
    input_data: Any = None
    output_data: Any = None
    error: str | None = None
    cause: str | None = None
    transitions: list[StateTransition] = field(default_factory=list)


# ---------------------------------------------------------------------------
# Custom exceptions
# ---------------------------------------------------------------------------


class StatesError(Exception):
    """Base exception for state machine execution errors."""

    def __init__(self, error: str, cause: str | None = None) -> None:
        super().__init__(error)
        self.error = error
        self.cause = cause


class StatesTaskFailed(StatesError):
    """Raised when a task state fails."""


class StatesTimeout(StatesError):
    """Raised when a state times out."""
