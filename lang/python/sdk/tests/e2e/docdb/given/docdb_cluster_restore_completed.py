"""Given: a "documentdb" "cluster" restore from documentdb snapshot completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given('a "documentdb" "cluster" restore from documentdb snapshot completes')
def docdb_cluster_restore_completed(lws_session):
    # Arrange / Act
    lws_session.inject_state("docdb", "cluster", TEST_CLUSTER, "available")
    # Assert
    pass
