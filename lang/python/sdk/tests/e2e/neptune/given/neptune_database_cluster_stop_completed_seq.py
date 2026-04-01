"""Given: a "neptune" "cluster" stop completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given('a "neptune" "cluster" stop completes')
def neptune_database_cluster_stop_completed_seq(lws_session):
    # Arrange / Act
    lws_session.inject_state("neptune", "cluster", TEST_CLUSTER, "stopped")
    # Assert
    pass
