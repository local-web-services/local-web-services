"""Given: the cluster is not part of a replication group"""

from __future__ import annotations

from pytest_bdd import given


@given("the cluster is not part of a replication group")
def cluster_is_not_part_of_rg():
    """No-op: clusters are standalone by default."""
