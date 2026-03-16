"""Resource lifecycle simulation for AWS service providers.

Tracks per-resource state (CREATING, ACTIVE, DELETING, DELETED) and
schedules async state transitions after configurable dwell times.
When dwell times are zero (the default), resources transition instantly
and existing behavior is preserved.
"""

from __future__ import annotations

import asyncio
from dataclasses import dataclass, field
from typing import TYPE_CHECKING, Any, Callable, Coroutine

if TYPE_CHECKING:
    pass


@dataclass
class ResourceLifecycleConfig:
    """Lifecycle simulation configuration for an AWS service provider."""

    enabled: bool = False
    create_dwell_ms: int = 0   # ms to spend in CREATING before ACTIVE
    delete_dwell_ms: int = 0   # ms to spend in DELETING before removal
    _trackers: list = field(default_factory=list, init=False, repr=False, compare=False)

    def reset_all_trackers(self) -> None:
        """Reset all ResourceStateTracker instances attached to this config."""
        for tracker in self._trackers:
            tracker.reset()


class ResourceStateTracker:
    """Tracks per-resource lifecycle state and schedules async transitions.

    All methods are synchronous except ``schedule_transition`` which creates
    an asyncio background task.

    Each tracker automatically registers itself with its ``ResourceLifecycleConfig``
    so that the management API reset can clear all tracker states.
    """

    def __init__(self, config: ResourceLifecycleConfig) -> None:
        self._config = config
        self._states: dict[str, str] = {}
        config._trackers.append(self)

    @property
    def config(self) -> ResourceLifecycleConfig:
        return self._config

    def get_state(self, resource_id: str) -> str | None:
        """Return the current state of *resource_id*, or None if not tracked."""
        return self._states.get(resource_id)

    def set_state(self, resource_id: str, status: str) -> None:
        """Unconditionally set *resource_id* to *status*."""
        self._states[resource_id] = status

    def remove(self, resource_id: str) -> None:
        """Remove *resource_id* from tracking (resource no longer exists)."""
        self._states.pop(resource_id, None)

    def reset(self) -> None:
        """Clear all tracked states."""
        self._states.clear()

    def all_states(self) -> dict[str, str]:
        """Return a copy of all tracked states."""
        return dict(self._states)

    def schedule_transition(
        self,
        resource_id: str,
        target_state: str | None,
        delay_ms: int,
        on_complete: Callable[[], Coroutine[Any, Any, None]] | None = None,
    ) -> None:
        """Schedule a state transition after *delay_ms* milliseconds.

        If *delay_ms* <= 0 the transition is applied synchronously.
        If *target_state* is None the resource is removed from tracking.
        """
        if delay_ms <= 0:
            if target_state is None:
                self.remove(resource_id)
            else:
                self.set_state(resource_id, target_state)
            if on_complete is not None:
                asyncio.ensure_future(on_complete())
            return

        async def _run() -> None:
            await asyncio.sleep(delay_ms / 1000.0)
            if target_state is None:
                self.remove(resource_id)
            else:
                self.set_state(resource_id, target_state)
            if on_complete is not None:
                await on_complete()

        asyncio.ensure_future(_run())


def parse_lifecycle_config(raw: dict[str, Any]) -> ResourceLifecycleConfig:
    """Parse a raw config dict into a ``ResourceLifecycleConfig``."""
    return ResourceLifecycleConfig(
        enabled=bool(raw.get("enabled", False)),
        create_dwell_ms=int(raw.get("create_dwell_ms", 0)),
        delete_dwell_ms=int(raw.get("delete_dwell_ms", 0)),
    )
