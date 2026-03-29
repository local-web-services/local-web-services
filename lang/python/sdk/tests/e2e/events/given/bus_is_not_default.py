"""Given: the event bus is not the default bus"""

from __future__ import annotations

from pytest_bdd import given


@given("the event bus is not the default bus")
def bus_is_not_default():
    """No-op: TEST_BUS is not the default bus."""
