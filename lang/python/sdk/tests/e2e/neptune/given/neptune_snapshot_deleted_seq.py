"""Given: a database cluster snapshot has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient
from ..constants import TEST_SNAPSHOT


@given("a database cluster snapshot has been deleted")
def neptune_snapshot_deleted_seq(lws_session):
    try:
        NeptuneTestClient(lws_session).create_cluster()
        NeptuneTestClient(lws_session).create_snapshot()
    except Exception:
        pass
    NeptuneTestClient(lws_session).delete_db_cluster_snapshot(
        DBClusterSnapshotIdentifier=TEST_SNAPSHOT
    )
