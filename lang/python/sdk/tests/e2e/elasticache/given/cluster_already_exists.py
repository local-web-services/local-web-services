"""Given: the "elasticache" "cluster" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given('the "elasticache" "cluster" already existed')
def cluster_already_exists(lws_session):
    ElasticacheTestClient(lws_session).create_cluster()
