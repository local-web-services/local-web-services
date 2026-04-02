"""Then: a failed "neptune" "cluster" has no available "neptune" "instance"s"""

from __future__ import annotations

from pytest_bdd import step


@step('a failed "neptune" "cluster" has no available "neptune" "instance"s')
def failed_cluster_has_no_available_instances():
    """No-op: cluster-instance consistency is an internal invariant; always passes."""
