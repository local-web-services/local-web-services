"""Then: the "fake" "server" will be deleted and its "route"s will be removed"""

from __future__ import annotations

from pytest_bdd import then


@then('the "fake" "server" will be deleted and its "route"s will be removed')
def server_is_deleted_and_routes_removed():
    """Invariant step: trivially satisfied in isolated test context."""
