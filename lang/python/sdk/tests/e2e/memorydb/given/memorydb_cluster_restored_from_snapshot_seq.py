"""Given: a cluster has been restored from a snapshot"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given("a cluster has been restored from a snapshot")
def memorydb_cluster_restored_from_snapshot_seq(lws_session):
    lws_session.inject_state("memorydb", "cluster", TEST_CLUSTER, "available")
