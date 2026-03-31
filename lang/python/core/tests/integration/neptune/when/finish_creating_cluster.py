"""When: a "documentdb" "cluster" finishes creating"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import NeptuneTestClient
from ..constants import INT_CLUSTER


@when('a "documentdb" "cluster" finishes creating')
def finish_creating_cluster(client: TestClient, world: dict):
    r = NeptuneTestClient(client).post("DescribeDBClusters", {"DBClusterIdentifier": INT_CLUSTER})
    if r.status_code != 200:
        world["result"] = None
        world["error"] = r.json()
        return
    clusters = r.json().get("DBClusters", [])
    if not clusters:
        world["result"] = None
        world["error"] = {"message": "DB cluster not found"}
        return
    world["result"] = r.json()
    world["error"] = None
