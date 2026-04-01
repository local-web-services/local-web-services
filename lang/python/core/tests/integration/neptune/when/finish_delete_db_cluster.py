"""When: a "documentdb" "cluster" deletion completes"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import NeptuneTestClient
from ..constants import INT_CLUSTER, _store


@when('a "documentdb" "cluster" deletion completes')
def finish_delete_db_cluster(client: TestClient, world: dict):
    check = NeptuneTestClient(client).post(
        "DescribeDBClusters", {"DBClusterIdentifier": INT_CLUSTER}
    )
    if check.status_code != 200:
        world["result"] = None
        world["error"] = check.json()
        return
    r = NeptuneTestClient(client).post("DeleteDBCluster", {"DBClusterIdentifier": INT_CLUSTER})
    _store(world, r)
