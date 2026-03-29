"""When: a MemoryDB cluster update completes"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _MDB_TARGET, INT_CLUSTER_NAME


@when("a MemoryDB cluster update completes")
def memorydb_cluster_update_completes(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_MDB_TARGET}.DescribeClusters"},
        json={"ClusterName": INT_CLUSTER_NAME},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
