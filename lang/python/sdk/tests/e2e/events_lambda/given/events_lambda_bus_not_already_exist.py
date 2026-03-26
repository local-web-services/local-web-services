"""Given: the event bus does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the event bus does not already exist")
def events_lambda_bus_not_already_exist():
    """No-op: fresh state has no event buses."""
