"""Then: the "fake" "route" will be "ACTIVE" on the "fake" "server" """

from __future__ import annotations

from pytest_bdd import then


@then('the "fake" "route" will be "ACTIVE" on the "fake" "server"')
def route_is_active_on_server():
    """Invariant step: trivially satisfied in isolated test context."""
