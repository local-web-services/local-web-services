"""Given: the snapshot exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given("the snapshot exists")
def snapshot_exists(lws_session):
    ElasticacheTestClient(lws_session).create_cluster()
    ElasticacheTestClient(lws_session).create_snapshot()
