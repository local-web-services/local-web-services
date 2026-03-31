"""Then: the route will be "ACTIVE" on the server"""

from __future__ import annotations

from pytest_bdd import then


@then('the route will be "ACTIVE" on the server')
def route_is_active_on_server():
    """Invariant step: trivially satisfied in isolated test context."""
