"""When: a snapshot is created from an available cluster"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET, INT_CLUSTER_NAME, INT_SNAPSHOT_NAME


@when("a snapshot is created from an available cluster")
def create_memorydb_snapshot(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.CreateSnapshot"},
        json={"ClusterName": INT_CLUSTER_NAME, "SnapshotName": INT_SNAPSHOT_NAME},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
