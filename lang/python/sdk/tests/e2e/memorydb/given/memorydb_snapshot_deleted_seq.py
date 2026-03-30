"""Given: a snapshot has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient
from ..constants import TEST_SNAPSHOT


@given("a snapshot has been deleted")
def memorydb_snapshot_deleted_seq(lws_session):
    try:
        MemorydbTestClient(lws_session).create_cluster()
        MemorydbTestClient(lws_session).create_snapshot()
    except Exception:
        pass
    MemorydbTestClient(lws_session).delete_snapshot(SnapshotName=TEST_SNAPSHOT)
