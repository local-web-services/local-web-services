"""Given: the event bus is the default bus."""

from __future__ import annotations

from pytest_bdd import given


@given('the "eventbridge" "bus" is the default eventbridge bus')
def bus_is_default():
    """No-op: will attempt to delete default bus in When step, which should fail."""
