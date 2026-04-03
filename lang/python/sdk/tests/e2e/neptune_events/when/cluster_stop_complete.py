"""When: the "neptune" "cluster" finishes stopping"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_CLUSTER


@when('the "neptune" "cluster" finishes stopping')
def cluster_stop_complete(lws_session, world):
    try:
        lws_session.inject_state(
            "neptune",
            "cluster",
            world.get("cluster_id", TEST_CLUSTER),
            "stopped",
        )
    except RuntimeError as exc:
        world["error"] = exc
