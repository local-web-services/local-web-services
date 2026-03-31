"""When: a "documentdb" "cluster" configuration is modified"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _DOCDB_TARGET, INT_CLUSTER_ID


@when('a "documentdb" "cluster" configuration is modified')
def modify_database_cluster(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_DOCDB_TARGET}.ModifyDBCluster"},
        json={
            "DBClusterIdentifier": INT_CLUSTER_ID,
            "ApplyImmediately": True,
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
