"""Given: a replication group has finished creating"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given("a replication group has finished creating")
def elasticache_rg_finished_creating(lws_session):
    ElasticacheTestClient(lws_session).create_replication_group()
