"""When: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET, INT_CLUSTER_NAME, INT_SNAPSHOT_NAME


@when('a "memorydb" "cluster" is restored from a "memorydb" "snapshot"')
@when('a "documentdb" "cluster" is restored from a "documentdb" "snapshot"')
def restore_cluster_from_snapshot(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.RestoreCluster"},
        json={
            "ClusterName": f"{INT_CLUSTER_NAME}-restored",
            "SnapshotName": INT_SNAPSHOT_NAME,
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
