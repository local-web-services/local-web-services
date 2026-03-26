"""Given: the event bus is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the event bus is "ACTIVE"')
def events_lambda_bus_is_active_given():
    """No-op: event buses are ACTIVE immediately after creation."""
