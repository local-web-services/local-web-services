"""Given: the resource exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient


@given("the resource exists")
def resource_exists(client: TestClient):
    ElasticacheTestClient(client).create_cluster()
