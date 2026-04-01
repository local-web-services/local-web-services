"""Given: a "neptune" "cluster" deletion completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given('a "neptune" "cluster" deletion completes')
def neptune_database_cluster_deletion_completed_seq(lws_session):
    lws_session.inject_state("neptune", "cluster", TEST_CLUSTER, "deleted")
