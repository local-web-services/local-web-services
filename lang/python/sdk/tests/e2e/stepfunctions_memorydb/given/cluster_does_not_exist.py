"""Given: the cluster does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the cluster does not exist")
def cluster_does_not_exist():
    """No-op: fresh state has no MemoryDB clusters."""
