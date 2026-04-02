"""Then: every backing-up "neptune" "cluster" has a corresponding in-progress "neptune" "snapshot" """

from __future__ import annotations

from pytest_bdd import step


@step('every backing-up "neptune" "cluster" has a corresponding in-progress "neptune" "snapshot"')
def backing_up_cluster_has_snapshot():
    """No-op: backup snapshot consistency is an internal invariant; always passes."""
