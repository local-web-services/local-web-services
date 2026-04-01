"""Given: a "neptune" "cluster" start completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given('a "neptune" "cluster" start completes')
def neptune_database_cluster_start_completed_seq(lws_session):
    # Arrange / Act
    lws_session.inject_state("neptune", "cluster", TEST_CLUSTER, "available")
    # Assert
    pass
