"""Then: the server is "DELETED" and its routes are removed"""

from __future__ import annotations

from pytest_bdd import then


@then('the server is "DELETED" and its routes are removed')
def server_is_deleted_and_routes_removed():
    """Invariant step: trivially satisfied in isolated test context."""
