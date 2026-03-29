"""Given: the subnet group already exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient


@given("the subnet group already exists")
def subnet_group_already_exists(client: TestClient):
    ElasticacheTestClient(client).create_subnet_group()
