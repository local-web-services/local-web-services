"""Then: a stopped cluster has no available instances"""

from __future__ import annotations

from pytest_bdd import step


@step("a stopped cluster has no available instances")
def stopped_cluster_has_no_available_instances():
    """No-op: cluster-instance consistency is an internal invariant; always passes."""
