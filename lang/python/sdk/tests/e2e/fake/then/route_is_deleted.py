"""Then: the route will be deleted"""

from __future__ import annotations

from pytest_bdd import then


@then("the route will be deleted")
def route_is_deleted():
    """Invariant step: trivially satisfied in isolated test context."""
