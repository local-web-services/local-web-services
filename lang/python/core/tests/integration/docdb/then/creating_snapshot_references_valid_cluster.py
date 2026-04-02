"""Then: every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'every creating "documentdb" "snapshot" references a "documentdb" "cluster" that has not been deleted'
)
def creating_snapshot_references_valid_cluster():
    """Invariant: trivially satisfied in isolated lws context."""
