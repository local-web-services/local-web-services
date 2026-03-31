"""When: a "documentdb" "cluster" is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _DOCDB_TARGET, INT_CLUSTER_ID


@when('a "documentdb" "cluster" is deleted')
def delete_database_cluster(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_DOCDB_TARGET}.DeleteDBCluster"},
        json={
            "DBClusterIdentifier": INT_CLUSTER_ID,
            "SkipFinalSnapshot": True,
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
