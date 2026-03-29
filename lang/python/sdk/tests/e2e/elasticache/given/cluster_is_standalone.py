"""Given: the cluster is standalone (not part of a replication group)"""

from __future__ import annotations

from pytest_bdd import given


@given("the cluster is standalone (not part of a replication group)")
def cluster_is_standalone():
    """No-op: clusters are standalone by default."""
