"""Shared store for injected resource states (test setup only)."""

from __future__ import annotations


class AsyncStateStore:
    """In-memory store for injected resource states.

    Used by the management API to pre-set resource states for test setup,
    and by providers to read injected states during describe operations.
    This store is intended solely for test setup and SHALL NOT be used
    in production workflows.
    """

    def __init__(self) -> None:
        self._states: dict[tuple[str, str, str], str] = {}

    def set(self, service: str, resource_type: str, resource_id: str, state: str) -> None:
        """Inject a state for a resource."""
        self._states[(service, resource_type, resource_id)] = state

    def get(self, service: str, resource_type: str, resource_id: str) -> str | None:
        """Return the injected state for a resource, or None if not injected."""
        return self._states.get((service, resource_type, resource_id))

    def clear(self, service: str, resource_type: str, resource_id: str) -> None:
        """Remove an injected state for a resource."""
        self._states.pop((service, resource_type, resource_id), None)

    def reset(self) -> None:
        """Clear all injected states."""
        self._states.clear()


def resource_state_body(service: str, resource_type: str, resource_id: str, state: str) -> dict:
    """Build a response body dict for a resource state endpoint."""
    return {
        "service": service,
        "resource_type": resource_type,
        "resource_id": resource_id,
        "state": state,
    }
