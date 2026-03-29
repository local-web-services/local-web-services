"""Given: the bus does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the bus does not already exist")
def bus_not_already_exist():
    """No-op: fresh state has no custom buses."""
