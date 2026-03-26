"""Given: the subnet group exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient


@given("the subnet group exists")
def subnet_group_exists(client: TestClient):
    ElasticacheTestClient(client).create_subnet_group()
