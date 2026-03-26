"""Given: an ElastiCache cluster has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaElasticacheTestClient


@given("an ElastiCache cluster has been created")
def lambda_elasticache_seq_cluster_created(lws_session):
    LambdaElasticacheTestClient(lws_session).create_cluster()
