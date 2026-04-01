"""Given: a memcached "elasticache" "cluster" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given('a memcached "elasticache" "cluster" is created')
def elasticache_memcached_cluster_has_been_created(lws_session):
    ElasticacheTestClient(lws_session).create_cluster(engine="memcached")
