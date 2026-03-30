"""Given: the snapshot exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient


@given("the snapshot exists")
def snapshot_exists(client: TestClient):
    ElasticacheTestClient(client).create_cluster()
    ElasticacheTestClient(client).create_snapshot()
