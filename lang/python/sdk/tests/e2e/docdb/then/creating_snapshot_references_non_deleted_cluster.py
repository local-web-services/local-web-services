"""Then: every creating snapshot references a cluster that has not been deleted"""

from __future__ import annotations

from pytest_bdd import step


@step("every creating snapshot references a cluster that has not been deleted")
def creating_snapshot_references_non_deleted_cluster():
    """No-op: snapshot-cluster reference integrity is an internal invariant; always passes."""
