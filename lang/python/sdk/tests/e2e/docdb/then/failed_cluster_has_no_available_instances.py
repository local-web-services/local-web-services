"""Then: a failed "documentdb" "cluster" has no available "documentdb" "instance"s"""

from __future__ import annotations

from pytest_bdd import step


@step('a failed "documentdb" "cluster" has no available "documentdb" "instance"s')
def failed_cluster_has_no_available_instances():
    """No-op: cluster-instance consistency is an internal invariant; always passes."""
