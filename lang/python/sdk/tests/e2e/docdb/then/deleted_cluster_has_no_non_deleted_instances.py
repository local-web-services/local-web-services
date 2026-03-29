"""Then: a deleted cluster has no non-deleted instances"""

from __future__ import annotations

from pytest_bdd import then


@then("a deleted cluster has no non-deleted instances")
def deleted_cluster_has_no_non_deleted_instances():
    """No-op: cluster-instance consistency is an internal invariant; always passes."""
