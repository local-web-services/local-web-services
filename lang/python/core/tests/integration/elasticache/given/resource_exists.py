"""Given: the "api gateway" "resource" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient


@given('the "elasticache" "resource" existed')
@given('the "api gateway" "resource" existed')
def resource_exists(client: TestClient):
    ElasticacheTestClient(client).create_cluster()
