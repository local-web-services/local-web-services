"""Given: the "neptune" "cluster" finishes stopping"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given('the "neptune" "cluster" finishes stopping')
def neptune_cluster_finished_stopping_seq(lws_session):
    lws_session.inject_state("neptune", "cluster", TEST_CLUSTER, "stopped")
