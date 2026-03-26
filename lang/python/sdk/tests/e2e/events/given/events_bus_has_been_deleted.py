"""Given: an event bus has been deleted"""

from __future__ import annotations

from pytest_bdd import given


@given("an event bus has been deleted")
def events_bus_has_been_deleted():
    """No-op: fresh state has no buses, simulates a previously deleted bus."""
