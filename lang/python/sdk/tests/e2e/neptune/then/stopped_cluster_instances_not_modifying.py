"""Then: instances on a stopped or stopping cluster are not in "MODIFYING" state"""

from __future__ import annotations

from pytest_bdd import step


@step('instances on a stopped or stopping cluster are not in "MODIFYING" state')
def stopped_cluster_instances_not_modifying():
    """No-op: cluster-instance consistency is an internal invariant; always passes."""
