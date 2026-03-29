"""Given: a replica cluster exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient
from ..constants import INT_CLUSTER_ID


@given("a replica cluster exists")
def replica_cluster_exists(client: TestClient):
    ElasticacheTestClient(client).create_cluster(f"{INT_CLUSTER_ID}-replica")
