"""Given: the route did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the route did not exist")
def route_does_not_exist():
    """No-op: fresh state has no routes."""
