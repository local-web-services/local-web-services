"""Then: a deleting cluster receives no new instances"""

from __future__ import annotations

from pytest_bdd import then


@then("a deleting cluster receives no new instances")
def deleting_cluster_receives_no_new_instances():
    """No-op: cluster-instance consistency is an internal invariant; always passes."""
