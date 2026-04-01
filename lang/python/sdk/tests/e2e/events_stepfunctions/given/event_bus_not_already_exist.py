"""Given: the event bus did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the event bus did not already exist")
def event_bus_not_already_exist():
    """No-op: fresh state has no custom buses."""
