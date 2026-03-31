"""When: a "neptune" "cluster" deletion completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_CLUSTER


@when('a "neptune" "cluster" deletion completes')
def cluster_deletion_completes(lws_session, world):
    lws_session.inject_state("neptune", "cluster", TEST_CLUSTER, "deleted")
