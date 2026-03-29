"""Given: a memcached cache cluster has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given("a memcached cache cluster has been created")
def elasticache_memcached_cluster_has_been_created(lws_session):
    ElasticacheTestClient(lws_session).create_cluster(engine="memcached")
