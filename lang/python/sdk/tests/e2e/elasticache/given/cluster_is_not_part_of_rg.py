"""Given: the "elasticache" "cluster" is not part of a "elasticache" "replication group" """

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" "cluster" is not part of a "elasticache" "replication group"')
def cluster_is_not_part_of_rg():
    """No-op: clusters are standalone by default."""
