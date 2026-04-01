"""Given: the "documentdb" "cluster" already existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient


@given('the "elasticache" "cluster" already existed')
@given('the "documentdb" "cluster" already existed')
def cluster_already_exists(client: TestClient):
    ElasticacheTestClient(client).create_cluster()
