"""Given: no "CACHED" "elasticache" "entry" existed in the "elasticache" "cluster" """

from __future__ import annotations

from pytest_bdd import given


@given('no "CACHED" "elasticache" "entry" existed in the "elasticache" "cluster"')
def no_cached_entry_exists_in_cluster():
    """No-op: fresh state has no cached entries in the cluster."""
