"""Given: the "elasticache" "replication group" already existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient


@given('the "elasticache" "replication group" already existed')
def rg_already_exists(client: TestClient):
    ElasticacheTestClient(client).create_replication_group()
