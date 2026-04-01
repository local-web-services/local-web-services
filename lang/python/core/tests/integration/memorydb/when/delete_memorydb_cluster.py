"""When: a "memorydb" "cluster" is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET, INT_CLUSTER_NAME


@when('a "memorydb" "cluster" is deleted')
def delete_memorydb_cluster(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.DeleteCluster"},
        json={"ClusterName": INT_CLUSTER_NAME},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
