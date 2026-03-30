"""Given: a standalone cache cluster has finished creating"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given("a standalone cache cluster has finished creating")
def elasticache_standalone_cluster_finished_creating(lws_session):
    ElasticacheTestClient(lws_session).create_cluster()
