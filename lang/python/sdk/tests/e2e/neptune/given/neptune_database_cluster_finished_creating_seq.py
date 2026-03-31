"""Given: a "neptune" "cluster" finishes creating"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given('a "neptune" "cluster" finishes creating')
def neptune_database_cluster_finished_creating_seq(lws_session):
    lws_session.inject_state("neptune", "cluster", TEST_CLUSTER, "available")
