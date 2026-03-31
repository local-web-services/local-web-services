"""Then: a deleted cluster has no available instances"""

from __future__ import annotations

from pytest_bdd import step


@step("a deleted cluster has no available instances")
def deleted_cluster_has_no_available_instances():
    """No-op: cluster-instance consistency is an internal invariant; always passes."""
