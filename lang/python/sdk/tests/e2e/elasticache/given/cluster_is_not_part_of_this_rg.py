"""Given: the "elasticache" "cluster" is not part of this replication group"""

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" "cluster" is not part of this replication group')
def cluster_is_not_part_of_this_rg():
    """No-op: fresh cluster is not part of a replication group."""
