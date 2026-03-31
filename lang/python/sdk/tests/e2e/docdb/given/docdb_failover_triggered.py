"""Given: a failover is triggered and a replica is promoted to primary"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given("a failover is triggered and a replica is promoted to primary")
def docdb_failover_triggered(lws_session):
    # Arrange / Act
    lws_session.inject_state("docdb", "cluster", TEST_CLUSTER, "failing_over")
    # Assert
    pass
