"""Given: the event bus is "ACTIVE"."""

from __future__ import annotations

from pytest_bdd import given


@given('the "eventbridge" "bus" was "ACTIVE"')
@given('the "eventbridge" "bus" will be "ACTIVE"')
def bus_is_active_given():
    """No-op: event buses are ACTIVE immediately after creation."""
