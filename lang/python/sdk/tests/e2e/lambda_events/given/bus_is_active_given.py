"""Given: the bus was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the bus was "ACTIVE"')
def bus_is_active_given():
    """No-op: event buses are ACTIVE immediately after creation."""
