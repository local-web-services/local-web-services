"""Given: the bus is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the bus is "ACTIVE"')
def bus_is_active_given():
    """No-op: event buses are ACTIVE immediately after creation."""
