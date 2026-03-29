"""When: a database cluster is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import NeptuneTestClient
from ..constants import INT_CLUSTER, _store


@when("a database cluster is deleted")
def delete_db_cluster(client: TestClient, world: dict):
    r = NeptuneTestClient(client).post("DeleteDBCluster", {"DBClusterIdentifier": INT_CLUSTER})
    _store(world, r)
