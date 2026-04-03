"""Given: a shard failover is triggered on a multi-"AZ" "memorydb" "cluster" """

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given('a shard failover is triggered on a multi-"AZ" "memorydb" "cluster"')
def memorydb_shard_failover_triggered_seq(lws_session):
    lws_session.inject_state("memorydb", "cluster", TEST_CLUSTER, "available")
