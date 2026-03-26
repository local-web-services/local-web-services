"""Given: a MemoryDB cluster has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient
from ..constants import TEST_CLUSTER


@given("a MemoryDB cluster has been deleted")
def memorydb_cluster_has_been_deleted_seq(lws_session):
    try:
        MemorydbTestClient(lws_session).create_cluster()
    except Exception:
        pass
    MemorydbTestClient(lws_session).delete_cluster(ClusterName=TEST_CLUSTER)
