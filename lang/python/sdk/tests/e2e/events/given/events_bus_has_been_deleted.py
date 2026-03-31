"""Given: an "eventbridge" "bus" is deleted"""

from __future__ import annotations

from pytest_bdd import given


@given('an "eventbridge" "bus" is deleted')
def events_bus_has_been_deleted():
    """No-op: fresh state has no buses, simulates a previously deleted bus."""
