"""Given: the event bus was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the event bus was "ACTIVE"')
def event_bus_is_active_given():
    """No-op: buses are ACTIVE by default."""
