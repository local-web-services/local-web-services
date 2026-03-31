"""Given: no "CACHED" entry existed in the cluster"""

from __future__ import annotations

from pytest_bdd import given


@given('no "CACHED" entry existed in the cluster')
def no_cached_entry_exists_in_cluster():
    """No-op: fresh state has no cached entries in the cluster."""
