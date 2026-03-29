"""Given: a "CACHED" entry exists in the cluster"""

from __future__ import annotations

from pytest_bdd import given


@given('a "CACHED" entry exists in the cluster')
def cached_entry_in_cluster(world):
    world["cached_entry_exists"] = True
