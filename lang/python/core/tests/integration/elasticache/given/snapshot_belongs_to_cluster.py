"""Given: the "elasticache" "snapshot" belongs to this "elasticache" "cluster" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient


@given('the "elasticache" "snapshot" belongs to this "elasticache" "cluster"')
def snapshot_belongs_to_cluster(client: TestClient):
    ElasticacheTestClient(client).create_cluster()
    ElasticacheTestClient(client).create_snapshot()
