"""When: a "documentdb" "cluster" documentdb snapshot finishes creating"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _DOCDB_TARGET, INT_SNAPSHOT_ID


@when('a "documentdb" "cluster" documentdb snapshot finishes creating')
def database_cluster_snapshot_finishes_creating(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_DOCDB_TARGET}.DescribeDBClusterSnapshots"},
        json={"DBClusterSnapshotIdentifier": INT_SNAPSHOT_ID},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
