"""Given: a "elasticache" "replication group" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given('a "elasticache" "replication group" is created')
def elasticache_rg_has_been_created(lws_session):
    ElasticacheTestClient(lws_session).create_replication_group()
