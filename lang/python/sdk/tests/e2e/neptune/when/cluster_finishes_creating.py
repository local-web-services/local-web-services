"""When: a "neptune" "cluster" finishes creating"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_CLUSTER


@when('a "neptune" "cluster" finishes creating')
def cluster_finishes_creating(lws_session, world):
    lws_session.inject_state("neptune", "cluster", TEST_CLUSTER, "available")
