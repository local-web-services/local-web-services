"""Given: a "neptune" "cluster" restore from neptune snapshot completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given('a "neptune" "cluster" restore from neptune snapshot completes')
def neptune_cluster_restore_completed_seq(lws_session):
    # Arrange / Act
    lws_session.inject_state("neptune", "cluster", TEST_CLUSTER, "available")
    # Assert
    pass
