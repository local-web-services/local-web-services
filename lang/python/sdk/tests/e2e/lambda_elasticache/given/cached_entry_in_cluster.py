"""Given: a "CACHED" "elasticache" "entry" existed in the "elasticache" "cluster" """

from __future__ import annotations

from pytest_bdd import given


@given('a "CACHED" "elasticache" "entry" existed in the "elasticache" "cluster"')
def cached_entry_in_cluster(world):
    world["cached_entry_exists"] = True
