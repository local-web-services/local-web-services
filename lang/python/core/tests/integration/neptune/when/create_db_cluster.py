"""When: a "documentdb" "cluster" is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import NeptuneTestClient
from ..constants import INT_CLUSTER, _store


@when('a "neptune" "cluster" is created')
@when('a "documentdb" "cluster" is created')
def create_db_cluster(client: TestClient, world: dict):
    r = NeptuneTestClient(client).post(
        "CreateDBCluster", {"DBClusterIdentifier": INT_CLUSTER, "Engine": "neptune"}
    )
    _store(world, r)
