"""Given: the "elasticache" "cluster" is not part of a "elasticache" "replication group" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticacheTestClient


@given('the "elasticache" "cluster" is not part of a "elasticache" "replication group"')
def cluster_is_not_part_of_rg(client: TestClient):
    ElasticacheTestClient(client).create_cluster()
