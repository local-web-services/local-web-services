"""When: a "documentdb" "cluster" is restored from a "documentdb" "snapshot" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _DOCDB_TARGET, INT_CLUSTER_ID, INT_SNAPSHOT_ID


@when('a "documentdb" "cluster" is restored from a "documentdb" "snapshot"')
def restore_cluster_from_snapshot(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_DOCDB_TARGET}.RestoreDBClusterFromSnapshot"},
        json={
            "DBClusterIdentifier": f"{INT_CLUSTER_ID}-restored",
            "SnapshotIdentifier": INT_SNAPSHOT_ID,
            "Engine": "docdb",
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
