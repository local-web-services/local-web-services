"""Given: the "elasticache" "cluster" is part of this replication group"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient


@given('the "elasticache" "cluster" is part of this replication group')
def cluster_is_part_of_this_rg(client: TestClient):
    ElasticacheTestClient(client).create_replication_group()
