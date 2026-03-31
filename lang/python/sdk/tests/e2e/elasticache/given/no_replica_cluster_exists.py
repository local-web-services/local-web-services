"""Given: no replica "elasticache" "cluster" existed"""

from __future__ import annotations

from pytest_bdd import given


@given('no replica "elasticache" "cluster" existed')
def no_replica_cluster_exists():
    """No-op: fresh state has no replica clusters."""
