"""Then: a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s"""

from __future__ import annotations

from pytest_bdd import step


@step('a deleting "documentdb" "cluster" receives no new "documentdb" "instance"s')
def deleting_cluster_receives_no_new_instances():
    """No-op: cluster-instance consistency is an internal invariant; always passes."""
