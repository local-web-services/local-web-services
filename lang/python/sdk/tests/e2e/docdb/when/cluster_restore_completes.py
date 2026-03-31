"""When: a "documentdb" "cluster" restore from documentdb snapshot completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_CLUSTER


@when('a "documentdb" "cluster" restore from documentdb snapshot completes')
def cluster_restore_completes(lws_session, world):
    # Arrange / Act
    lws_session.inject_state("docdb", "cluster", TEST_CLUSTER, "available")
    # Assert
    pass
