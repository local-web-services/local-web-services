"""When: an "elasticache" "cluster" modification completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_CLUSTER


@when('an "elasticache" "cluster" modification completes')
def cluster_modification_completes(lws_session, world):
    try:
        lws_session.inject_state_unchecked(
            "elasticache",
            "cluster",
            world.get("cluster_id", TEST_CLUSTER),
            "available",
        )
    except RuntimeError as exc:
        world["error"] = exc
