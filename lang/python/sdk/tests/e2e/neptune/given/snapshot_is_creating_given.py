"""Given: the "neptune" "snapshot" was "CREATING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient
from ..constants import TEST_CLUSTER, TEST_SNAPSHOT


@given('the "neptune" "snapshot" was "CREATING"')
def snapshot_is_creating_given(lws_session):
    try:
        lws_session.client("neptune").delete_db_cluster_snapshot(
            DBClusterSnapshotIdentifier=TEST_SNAPSHOT
        )
    except Exception:
        pass
    NeptuneTestClient(lws_session).create_cluster()
    lws_session.lifecycle("neptune").create_dwell_ms(5000).apply()
    lws_session.client("neptune").create_db_cluster_snapshot(
        DBClusterSnapshotIdentifier=TEST_SNAPSHOT, DBClusterIdentifier=TEST_CLUSTER
    )
