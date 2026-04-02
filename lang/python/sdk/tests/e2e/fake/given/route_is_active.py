"""Given: the "fake" "route" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "fake" "route" was "ACTIVE"')
def route_is_active():
    """No-op: route_exists already added the route in ACTIVE state."""
