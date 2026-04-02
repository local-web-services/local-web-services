"""Given: a "route" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('a "route" "slot" was "available"')
def route_slot_available():
    """No-op: fake servers have no maximum route limit."""
