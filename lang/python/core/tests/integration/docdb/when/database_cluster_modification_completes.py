"""When: a database cluster modification completes"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _DOCDB_TARGET, INT_CLUSTER_ID


@when("a database cluster modification completes")
def database_cluster_modification_completes(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_DOCDB_TARGET}.DescribeDBClusters"},
        json={"DBClusterIdentifier": INT_CLUSTER_ID},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
