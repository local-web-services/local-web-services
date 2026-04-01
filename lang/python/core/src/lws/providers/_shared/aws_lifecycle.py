"""Resource lifecycle simulation for AWS service providers.

Tracks per-resource state (CREATING, ACTIVE, DELETING, DELETED) and
schedules async state transitions after configurable dwell times.
When dwell times are zero (the default), resources transition instantly
and existing behavior is preserved.
"""

from __future__ import annotations

import asyncio
from collections.abc import Callable, Coroutine
from dataclasses import dataclass, field
from typing import TYPE_CHECKING, Any

if TYPE_CHECKING:
    pass

# Registry mapping (service, resource_type) → ResourceStateTracker.
# Created once by the management layer and threaded to each provider factory.
TrackerRegistry = dict[tuple[str, str], "ResourceStateTracker"]


def register_tracker(
    registry: TrackerRegistry,
    service: str,
    resource_type: str,
    tracker: ResourceStateTracker,
) -> None:
    """Register *tracker* under *(service, resource_type)* in *registry*."""
    registry[(service, resource_type)] = tracker


@dataclass
class ResourceLifecycleConfig:
    """Lifecycle simulation configuration for an AWS service provider."""

    enabled: bool = True
    create_dwell_ms: int = 0  # ms to spend in CREATING before ACTIVE
    delete_dwell_ms: int = 0  # ms to spend in DELETING before removal
    modify_dwell_ms: int = 0  # ms to spend in MODIFYING before ACTIVE
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
        self._tasks: dict[str, asyncio.Task[None]] = {}
        self._frozen: set[str] = set()
        self._pending_target: dict[str, str | None] = {}
        config._trackers.append(self)

    @property
    def config(self) -> ResourceLifecycleConfig:
        """Return the lifecycle configuration for this tracker."""
        return self._config

    def get_state(self, resource_id: str) -> str | None:
        """Return the current state of *resource_id*, or None if not tracked."""
        return self._states.get(resource_id)

    def set_state(self, resource_id: str, status: str, frozen: bool = False) -> None:
        """Unconditionally set *resource_id* to *status*.

        When *frozen* is True, any in-flight transition task is cancelled and
        future ``schedule_transition`` calls will store the pending target state
        but will not execute until ``unfreeze`` is called.
        """
        if frozen:
            existing = self._tasks.pop(resource_id, None)
            if existing is not None and not existing.done():
                existing.cancel()
            self._frozen.add(resource_id)
        self._states[resource_id] = status

    def unfreeze(self, resource_id: str, apply: bool = True) -> None:
        """Clear the frozen flag for *resource_id*.

        When *apply* is True, the pending target state (if any) is applied
        synchronously so the resource transitions to its intended next state.
        """
        self._frozen.discard(resource_id)
        if apply:
            target = self._pending_target.pop(resource_id, None)
            if target is not None:
                self.schedule_transition(resource_id, target, 0)
            elif resource_id in self._pending_target:
                # target was explicitly stored as None (delete)
                del self._pending_target[resource_id]
                self.remove(resource_id)

    def remove(self, resource_id: str) -> None:
        """Remove *resource_id* from tracking (resource no longer exists)."""
        self._states.pop(resource_id, None)

    def reset(self) -> None:
        """Clear all tracked states and cancel any pending async transitions."""
        for task in self._tasks.values():
            task.cancel()
        self._tasks.clear()
        self._states.clear()
        self._frozen.clear()
        self._pending_target.clear()

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
        If the resource is frozen the target is stored as pending and no
        transition is scheduled.
        """
        if resource_id in self._frozen:
            self._pending_target[resource_id] = target_state
            return

        if delay_ms <= 0:
            if target_state is None:
                self.remove(resource_id)
            else:
                self._states[resource_id] = target_state
            if on_complete is not None:
                asyncio.ensure_future(on_complete())
            return

        # Cancel any pending transition for the same resource
        existing = self._tasks.pop(resource_id, None)
        if existing is not None and not existing.done():
            existing.cancel()

        async def _run() -> None:
            await asyncio.sleep(delay_ms / 1000.0)
            self._tasks.pop(resource_id, None)
            if target_state is None:
                self.remove(resource_id)
            else:
                self._states[resource_id] = target_state
            if on_complete is not None:
                await on_complete()

        self._tasks[resource_id] = asyncio.ensure_future(_run())


def apply_delete_lifecycle(
    resp: Any,
    resource_id: str,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
) -> Any:
    """Apply delete lifecycle state transitions to *resp*.

    If the response was successful (status_code 200), either schedules a
    DELETING→removed transition (if delete_dwell_ms > 0) or removes the
    resource immediately.  Returns *resp* unchanged.
    """
    if resp.status_code == 200:
        if lc.delete_dwell_ms > 0:
            tracker.set_state(resource_id, "DELETING")
            tracker.schedule_transition(resource_id, None, lc.delete_dwell_ms)
        else:
            tracker.remove(resource_id)
    return resp


def apply_modify_lifecycle(
    resp: Any,
    resource_id: str,
    lc: ResourceLifecycleConfig,
    tracker: ResourceStateTracker,
    active_state: str = "ACTIVE",
    modifying_state: str = "MODIFYING",
) -> Any:
    """Apply modify lifecycle state transitions to *resp*.

    If the response was successful (status_code 200), either schedules a
    MODIFYING→active transition (if modify_dwell_ms > 0) or sets the
    resource to *active_state* immediately.  Returns *resp* unchanged.
    """
    if resp.status_code == 200:
        if lc.modify_dwell_ms > 0:
            tracker.set_state(resource_id, modifying_state)
            tracker.schedule_transition(resource_id, active_state, lc.modify_dwell_ms)
        else:
            tracker.set_state(resource_id, active_state)
    return resp


def parse_lifecycle_config(raw: dict[str, Any]) -> ResourceLifecycleConfig:
    """Parse a raw config dict into a ``ResourceLifecycleConfig``."""
    return ResourceLifecycleConfig(
        enabled=bool(raw.get("enabled", True)),
        create_dwell_ms=int(raw.get("create_dwell_ms", 0)),
        delete_dwell_ms=int(raw.get("delete_dwell_ms", 0)),
        modify_dwell_ms=int(raw.get("modify_dwell_ms", 0)),
    )
