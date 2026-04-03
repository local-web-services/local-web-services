"""When: a "documentdb" "cluster" finishes creating"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_CLUSTER


@when('a "documentdb" "cluster" finishes creating')
def cluster_finishes_creating(lws_session, world):
    try:
        lws_session.inject_state_unchecked("docdb", "cluster", TEST_CLUSTER, "available")
    except RuntimeError as exc:
        world["error"] = exc
