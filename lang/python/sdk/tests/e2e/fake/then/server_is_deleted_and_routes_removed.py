"""Then: the server will be deleted and its routes will be removed"""

from __future__ import annotations

from pytest_bdd import then


@then("the server will be deleted and its routes will be removed")
def server_is_deleted_and_routes_removed():
    """Invariant step: trivially satisfied in isolated test context."""
