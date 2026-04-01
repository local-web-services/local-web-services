"""Given: a "elasticache" "replication group" finishes creating"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given('a "elasticache" "replication group" finishes creating')
def elasticache_rg_finished_creating(lws_session):
    ElasticacheTestClient(lws_session).create_replication_group()
