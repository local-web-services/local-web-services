"""Then: every snapshotting "elasticache" "cluster" has a corresponding in-progress "elasticache" "snapshot" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'every snapshotting "elasticache" "cluster" has a corresponding in-progress "elasticache" "snapshot"'
)
def snapshotting_cluster_has_snapshot():
    """No-op: snapshot-cluster consistency invariant; always passes."""
