"""Given: the cluster exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given("the cluster exists")
def cluster_exists(lws_session):
    ElasticacheTestClient(lws_session).create_cluster()
