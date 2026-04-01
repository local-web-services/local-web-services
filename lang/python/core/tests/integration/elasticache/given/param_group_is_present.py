"""Given: the "elasticache" parameter group was present"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient


@given('the "elasticache" parameter group was present')
def param_group_is_present(client: TestClient):
    ElasticacheTestClient(client).create_param_group()
