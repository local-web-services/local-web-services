"""Given: the "documentdb" "snapshot" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient


@given('the "elasticache" "snapshot" existed')
@given('the "documentdb" "snapshot" existed')
def snapshot_exists(client: TestClient):
    ElasticacheTestClient(client).create_cluster()
    ElasticacheTestClient(client).create_snapshot()
