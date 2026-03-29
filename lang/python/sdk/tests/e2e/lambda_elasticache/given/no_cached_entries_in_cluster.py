"""Given: no "CACHED" entries exist in the cluster"""

from __future__ import annotations

from pytest_bdd import given


@given('no "CACHED" entries exist in the cluster')
def no_cached_entries_in_cluster():
    """No-op: fresh state has no cached entries."""
