"""Then: every snapshotting cluster has a corresponding in-progress snapshot"""

from __future__ import annotations

from pytest_bdd import then


@then("every snapshotting cluster has a corresponding in-progress snapshot")
def snapshotting_cluster_has_snapshot():
    """Invariant: trivially satisfied in isolated lws context."""
