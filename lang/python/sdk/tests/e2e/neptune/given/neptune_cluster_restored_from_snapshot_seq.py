"""Given: a "neptune" "cluster" is restored from a neptune snapshot"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient
from ..constants import TEST_CLUSTER, TEST_SNAPSHOT


@given('a "neptune" "cluster" is restored from a neptune snapshot')
def neptune_cluster_restored_from_snapshot_seq(lws_session):
    # Arrange
    NeptuneTestClient(lws_session).create_cluster()
    NeptuneTestClient(lws_session).create_snapshot()
    lws_session.inject_state("neptune", "snapshot", TEST_SNAPSHOT, "available")
    lws_session.inject_state("neptune", "cluster", TEST_CLUSTER, "available")
    NeptuneTestClient(lws_session).delete_cluster()
    # Act
    lws_session.client("neptune").restore_db_cluster_from_snapshot(
        DBClusterIdentifier=TEST_CLUSTER,
        SnapshotIdentifier=TEST_SNAPSHOT,
        Engine="neptune",
    )
    lws_session.inject_state("neptune", "cluster", TEST_CLUSTER, "restoring")
    # Assert
    pass
