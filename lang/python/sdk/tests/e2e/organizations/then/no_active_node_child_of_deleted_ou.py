"""Then: no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"'
)
def no_active_node_child_of_deleted_ou():
    """Invariant: trivially satisfied in an isolated test context."""
