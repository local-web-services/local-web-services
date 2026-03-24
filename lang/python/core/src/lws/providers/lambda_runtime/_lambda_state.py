"""Lambda management state container with invocation tracking."""

from __future__ import annotations

from typing import Any

_INVOCATION_STATE_IN_PROGRESS = "IN_PROGRESS"
_INVOCATION_STATE_SUCCESS = "SUCCESS"
_INVOCATION_STATE_FAILED = "FAILED"


class _LambdaState:
    def __init__(self) -> None:
        self.event_source_mappings: dict[str, dict[str, Any]] = {}
        self.permissions: dict[str, dict[str, Any]] = {}
        self.invocations: dict[str, str] = {}

    def record_invocation(self, invocation_id: str) -> None:
        """Record a new invocation as IN_PROGRESS."""
        self.invocations[invocation_id] = _INVOCATION_STATE_IN_PROGRESS

    def complete_invocation(self, invocation_id: str, *, success: bool) -> None:
        """Transition an invocation to SUCCESS or FAILED."""
        if invocation_id in self.invocations:
            self.invocations[invocation_id] = (
                _INVOCATION_STATE_SUCCESS if success else _INVOCATION_STATE_FAILED
            )

    def get_invocation_state(self, invocation_id: str) -> str | None:
        """Return the current state of an invocation, or None if unknown."""
        return self.invocations.get(invocation_id)
