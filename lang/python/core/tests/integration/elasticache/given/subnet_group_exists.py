"""Given: the "elasticache" "subnet group" will exist"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient


@given('the "elasticache" "subnet group" existed')
@given('the "elasticache" "subnet group" will exist')
def subnet_group_exists(client: TestClient):
    ElasticacheTestClient(client).create_subnet_group()
