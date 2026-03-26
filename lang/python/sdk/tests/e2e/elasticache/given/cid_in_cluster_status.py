"""Given: cid in cluster_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given("cid in cluster_status")
def cid_in_cluster_status(lws_session):
    ElasticacheTestClient(lws_session).create_cluster()
