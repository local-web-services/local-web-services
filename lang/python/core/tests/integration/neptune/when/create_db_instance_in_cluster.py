"""When: a database instance is created in an available cluster"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import NeptuneTestClient
from ..constants import INT_CLUSTER, INT_INSTANCE, _store


@when("a database instance is created in an available cluster")
def create_db_instance_in_cluster(client: TestClient, world: dict):
    check = NeptuneTestClient(client).post(
        "DescribeDBClusters", {"DBClusterIdentifier": INT_CLUSTER}
    )
    if check.status_code != 200:
        world["result"] = None
        world["error"] = check.json()
        return
    r = NeptuneTestClient(client).post(
        "CreateDBInstance",
        {
            "DBInstanceIdentifier": INT_INSTANCE,
            "DBClusterIdentifier": INT_CLUSTER,
            "DBInstanceClass": "db.r5.large",
            "Engine": "neptune",
        },
    )
    _store(world, r)
