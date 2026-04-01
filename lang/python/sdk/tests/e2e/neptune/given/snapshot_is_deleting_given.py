"""Given: the "neptune" "snapshot" was "DELETING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient
from ..constants import TEST_SNAPSHOT


@given('the "neptune" "snapshot" was "DELETING"')
def snapshot_is_deleting_given(lws_session):
    NeptuneTestClient(lws_session).create_cluster()
    NeptuneTestClient(lws_session).create_snapshot()
    lws_session.lifecycle("neptune").delete_dwell_ms(5000).apply()
    lws_session.client("neptune").delete_db_cluster_snapshot(
        DBClusterSnapshotIdentifier=TEST_SNAPSHOT
    )
