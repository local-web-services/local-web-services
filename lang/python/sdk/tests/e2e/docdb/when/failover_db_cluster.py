"""When: a failover is triggered and a replica is promoted to primary"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_CLUSTER


@when("a failover is triggered and a replica is promoted to primary")
def failover_db_cluster(lws_session, world):
    try:
        lws_session.inject_state("docdb", "cluster", TEST_CLUSTER, "available")
    except RuntimeError as exc:
        world["error"] = exc
