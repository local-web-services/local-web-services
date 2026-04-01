"""Given: the "elasticache" subnet group was present"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient


@given('the "elasticache" subnet group was present')
def subnet_group_is_present(client: TestClient):
    ElasticacheTestClient(client).create_subnet_group()
