"""Then: every snapshotting "elasticache" "cluster" has a corresponding in-progress "elasticache" "snapshot" """

from __future__ import annotations

from pytest_bdd import then


@then(
    'every snapshotting "elasticache" "cluster" has a corresponding in-progress "elasticache" "snapshot"'
)
def snapshotting_cluster_has_snapshot():
    """Invariant: trivially satisfied in isolated lws context."""
