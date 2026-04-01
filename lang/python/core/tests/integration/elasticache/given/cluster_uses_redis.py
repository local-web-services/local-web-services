"""Given: the "elasticache" "cluster" uses the redis engine"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient


@given('the "elasticache" "cluster" uses the redis engine')
def cluster_uses_redis(client: TestClient):
    ElasticacheTestClient(client).create_cluster()
