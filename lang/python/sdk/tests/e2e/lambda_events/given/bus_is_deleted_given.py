"""Given: the bus was "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the bus was "DELETED"')
def bus_is_deleted_given():
    """No-op: fresh state has no event buses (simulates deleted bus)."""
