"""When: a "memorydb" "cluster" restore from "memorydb" "snapshot" completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_CLUSTER


@when('a "memorydb" "cluster" restore from "memorydb" "snapshot" completes')
def cluster_restore_completes(lws_session, world):
    try:
        lws_session.inject_state(
            "memorydb",
            "cluster",
            world.get("cluster_id", TEST_CLUSTER),
            "available",
        )
    except RuntimeError as exc:
        world["error"] = exc
