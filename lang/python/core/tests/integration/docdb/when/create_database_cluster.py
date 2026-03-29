"""When: a database cluster is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _DOCDB_TARGET, INT_CLUSTER_ID


@when("a database cluster is created")
def create_database_cluster(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_DOCDB_TARGET}.CreateDBCluster"},
        json={
            "DBClusterIdentifier": INT_CLUSTER_ID,
            "Engine": "docdb",
            "MasterUsername": "admin",
            "MasterUserPassword": "int-test-password",
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
