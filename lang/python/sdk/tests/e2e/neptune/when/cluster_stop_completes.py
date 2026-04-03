"""When: a "neptune" "cluster" stop completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_CLUSTER


@when('a "neptune" "cluster" stop completes')
def cluster_stop_completes(lws_session, world):
    try:
        lws_session.inject_state_unchecked("neptune", "cluster", TEST_CLUSTER, "stopped")
    except RuntimeError as exc:
        world["error"] = exc
