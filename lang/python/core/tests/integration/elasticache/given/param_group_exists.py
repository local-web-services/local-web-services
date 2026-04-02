"""Given: the "elasticache" "parameter group" will exist"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient


@given('the "elasticache" "parameter group" existed')
@given('the "elasticache" "parameter group" will exist')
def param_group_exists(client: TestClient):
    ElasticacheTestClient(client).create_param_group()
