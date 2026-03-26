"""Given: the parameter group exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient


@given("the parameter group exists")
def param_group_exists(client: TestClient):
    ElasticacheTestClient(client).create_param_group()
