"""Given: the cluster does not use the redis engine"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given("the cluster does not use the redis engine")
def cluster_does_not_use_redis_engine(lws_session):
    ElasticacheTestClient(lws_session).create_cluster(engine="memcached")
