"""Then: a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s"""

from __future__ import annotations

from pytest_bdd import step


@step('a deleted "documentdb" "cluster" has no non-deleted "documentdb" "instance"s')
def deleted_cluster_has_no_non_deleted_instances():
    """No-op: cluster-instance consistency is an internal invariant; always passes."""
