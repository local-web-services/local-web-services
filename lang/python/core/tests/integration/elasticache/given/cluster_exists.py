"""Given: the "documentdb" "cluster" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient


@given('the "elasticache" "cluster" existed')
@given('the "documentdb" "cluster" existed')
def cluster_exists(client: TestClient):
    ElasticacheTestClient(client).create_cluster()
