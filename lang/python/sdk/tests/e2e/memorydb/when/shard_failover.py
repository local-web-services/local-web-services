"""When: a shard failover is triggered on a multi-"AZ" "memorydb" "cluster" """

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_CLUSTER


@when('a shard failover is triggered on a multi-"AZ" "memorydb" "cluster"')
def shard_failover(lws_session, world):
    try:
        lws_session.inject_state(
            "memorydb",
            "cluster",
            world.get("cluster_id", TEST_CLUSTER),
            "available",
        )
    except RuntimeError as exc:
        world["error"] = exc
