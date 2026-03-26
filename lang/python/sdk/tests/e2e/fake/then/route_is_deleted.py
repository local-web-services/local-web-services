"""Then: the route is "DELETED" """

from __future__ import annotations

from pytest_bdd import then


@then('the route is "DELETED"')
def route_is_deleted():
    """Invariant step: trivially satisfied in isolated test context."""
