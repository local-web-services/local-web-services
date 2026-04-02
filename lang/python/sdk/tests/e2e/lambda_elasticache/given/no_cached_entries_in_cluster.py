"""Given: no "CACHED" "elasticache" "entries" existed in the "elasticache" "cluster" """

from __future__ import annotations

from pytest_bdd import given


@given('no "CACHED" "elasticache" "entries" existed in the "elasticache" "cluster"')
def no_cached_entries_in_cluster():
    """No-op: fresh state has no cached entries."""
