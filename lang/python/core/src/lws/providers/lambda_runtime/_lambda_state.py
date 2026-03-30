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
        self.function_invocations: dict[str, list[dict[str, str]]] = {}

    def record_invocation(self, invocation_id: str, function_name: str = "") -> None:
        """Record a new invocation as IN_PROGRESS."""
        self.invocations[invocation_id] = _INVOCATION_STATE_IN_PROGRESS
        if function_name:
            if function_name not in self.function_invocations:
                self.function_invocations[function_name] = []
            self.function_invocations[function_name].append(
                {"InvocationId": invocation_id, "State": _INVOCATION_STATE_IN_PROGRESS}
            )

    def complete_invocation(self, invocation_id: str, *, success: bool) -> None:
        """Transition an invocation to SUCCESS or FAILED."""
        if invocation_id not in self.invocations:
            return
        new_state = _INVOCATION_STATE_SUCCESS if success else _INVOCATION_STATE_FAILED
        self.invocations[invocation_id] = new_state
        for records in self.function_invocations.values():
            for record in records:
                if record["InvocationId"] == invocation_id:
                    record["State"] = new_state
                    return

    def get_invocation_state(self, invocation_id: str) -> str | None:
        """Return the current state of an invocation, or None if unknown."""
        return self.invocations.get(invocation_id)

    def get_function_invocations(self, function_name: str) -> list[dict[str, str]]:
        """Return all invocation records for a given function."""
        return list(self.function_invocations.get(function_name, []))
