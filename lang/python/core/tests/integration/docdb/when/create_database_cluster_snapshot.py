"""When: a database cluster snapshot is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _DOCDB_TARGET, INT_CLUSTER_ID, INT_SNAPSHOT_ID


@when("a database cluster snapshot is created")
def create_database_cluster_snapshot(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_DOCDB_TARGET}.CreateDBClusterSnapshot"},
        json={
            "DBClusterSnapshotIdentifier": INT_SNAPSHOT_ID,
            "DBClusterIdentifier": INT_CLUSTER_ID,
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
