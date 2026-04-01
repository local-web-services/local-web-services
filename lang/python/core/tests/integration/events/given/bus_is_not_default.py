"""Given: the event bus is not the default bus."""

from __future__ import annotations

from pytest_bdd import given


@given('the "eventbridge" "bus" is not the default eventbridge bus')
def bus_is_not_default():
    """No-op: INT_BUS is not the default bus."""
