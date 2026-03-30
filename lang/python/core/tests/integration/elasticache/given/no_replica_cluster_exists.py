"""Given: no replica cluster exists"""

from __future__ import annotations

from pytest_bdd import given


@given("no replica cluster exists")
def no_replica_cluster_exists():
    """No-op: fresh state has no replica clusters."""
