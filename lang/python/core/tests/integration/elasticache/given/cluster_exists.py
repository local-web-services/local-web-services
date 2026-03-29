"""Given: the cluster exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient


@given("the cluster exists")
def cluster_exists(client: TestClient):
    ElasticacheTestClient(client).create_cluster()
