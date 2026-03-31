"""Given: the "neptune" "cluster" was "RESTORING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient
from ..constants import TEST_CLUSTER, TEST_SNAPSHOT


@given('the "neptune" "cluster" was "RESTORING"')
def cluster_is_restoring_given(lws_session):
    # Arrange
    NeptuneTestClient(lws_session).delete_cluster()
    lws_session.lifecycle("neptune").create_dwell_ms(0).apply()
    NeptuneTestClient(lws_session).create_cluster()
    NeptuneTestClient(lws_session).create_snapshot()
    NeptuneTestClient(lws_session).delete_cluster()
    lws_session.lifecycle("neptune").modify_dwell_ms(5000).apply()
    # Act
    lws_session.client("neptune").restore_db_cluster_from_snapshot(
        DBClusterIdentifier=TEST_CLUSTER,
        SnapshotIdentifier=TEST_SNAPSHOT,
        Engine="neptune",
    )
    # Assert
    pass
