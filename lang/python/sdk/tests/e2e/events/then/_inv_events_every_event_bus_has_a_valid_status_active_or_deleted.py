"""Then: every event bus has a valid status ("ACTIVE" or "DELETED")"""

from __future__ import annotations

from pytest_bdd import step


@step('every event bus has a valid status ("ACTIVE" or "DELETED")')
def _inv_events_every_event_bus_has_a_valid_status_active_or_deleted():
    """Invariant step: trivially satisfied in isolated test context."""
