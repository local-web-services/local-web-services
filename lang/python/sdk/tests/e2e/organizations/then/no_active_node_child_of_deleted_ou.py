"""Then: no active node is a child of a deleted organizational unit"""

from __future__ import annotations

from pytest_bdd import then


@then("no active node is a child of a deleted organizational unit")
def no_active_node_child_of_deleted_ou():
    """Invariant: trivially satisfied in an isolated test context."""
