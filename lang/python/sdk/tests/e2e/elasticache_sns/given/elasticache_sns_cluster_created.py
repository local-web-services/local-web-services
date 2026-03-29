"""Given: an ElastiCache cluster has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheSnsTestClient


@given("an ElastiCache cluster has been created")
def elasticache_sns_cluster_created(lws_session):
    ElasticacheSnsTestClient(lws_session).create_cluster()
