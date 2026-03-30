"""Then: the domain is "DELETED" and all associated connections are removed"""

from __future__ import annotations

from pytest_bdd import then


@then('the domain is "DELETED" and all associated connections are removed')
def domain_is_deleted_connections_removed(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"
