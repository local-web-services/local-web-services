"""Given: an "elasticache" "cluster" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheSnsTestClient


@given('an "elasticache" "cluster" is created')
def elasticache_sns_cluster_created(lws_session):
    ElasticacheSnsTestClient(lws_session).create_cluster()
