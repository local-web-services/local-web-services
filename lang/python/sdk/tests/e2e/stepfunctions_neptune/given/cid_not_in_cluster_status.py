"""Given: cid not in cluster_status"""

from __future__ import annotations

from pytest_bdd import given


@given("cid not in cluster_status")
def cid_not_in_cluster_status():
    """No-op: guard condition — fresh state has no Neptune clusters."""
