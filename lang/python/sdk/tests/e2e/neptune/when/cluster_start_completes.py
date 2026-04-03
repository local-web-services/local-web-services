"""When: a "neptune" "cluster" start completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_CLUSTER


@when('a "neptune" "cluster" start completes')
def cluster_start_completes(lws_session, world):
    try:
        lws_session.inject_state_unchecked("neptune", "cluster", TEST_CLUSTER, "available")
    except RuntimeError as exc:
        world["error"] = exc
