"""Given: a standalone "elasticache" "cluster" finishes creating"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given('a standalone "elasticache" "cluster" finishes creating')
def elasticache_standalone_cluster_finished_creating(lws_session):
    ElasticacheTestClient(lws_session).create_cluster()
