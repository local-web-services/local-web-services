"""Given: a "neptune" "cluster" modification completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given('a "neptune" "cluster" modification completes')
def neptune_database_cluster_modification_completed_seq(lws_session):
    lws_session.inject_state("neptune", "cluster", TEST_CLUSTER, "available")
