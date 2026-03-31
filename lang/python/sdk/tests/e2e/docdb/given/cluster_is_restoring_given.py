"""Given: the "documentdb" "cluster" was "RESTORING" """

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given('the "documentdb" "cluster" was "RESTORING"')
def cluster_is_restoring_given(lws_session):
    # Arrange / Act
    lws_session.inject_state("docdb", "cluster", TEST_CLUSTER, "restoring")
    # Assert
    pass
