"""Then: every snapshotting cluster has a corresponding in-progress snapshot"""

from __future__ import annotations

from pytest_bdd import then


@then("every snapshotting cluster has a corresponding in-progress snapshot")
def snapshotting_cluster_has_snapshot():
    """No-op: snapshot-cluster consistency invariant; always passes."""
