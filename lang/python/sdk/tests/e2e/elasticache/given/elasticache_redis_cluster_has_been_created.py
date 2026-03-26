"""Given: a redis cache cluster has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given("a redis cache cluster has been created")
def elasticache_redis_cluster_has_been_created(lws_session):
    ElasticacheTestClient(lws_session).create_cluster()
