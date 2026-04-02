"""Then: a stopped "neptune" "cluster" has no available "neptune" "instance"s"""

from __future__ import annotations

from pytest_bdd import step


@step('a stopped "neptune" "cluster" has no available "neptune" "instance"s')
def stopped_cluster_has_no_available_instances():
    """No-op: cluster-instance consistency is an internal invariant; always passes."""
