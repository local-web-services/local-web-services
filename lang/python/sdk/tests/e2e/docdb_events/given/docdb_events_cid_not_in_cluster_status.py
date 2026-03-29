"""Given: cid not in cluster_status"""

from __future__ import annotations

from pytest_bdd import given


@given("cid not in cluster_status")
def docdb_events_cid_not_in_cluster_status():
    """No-op: fresh state has no clusters."""
