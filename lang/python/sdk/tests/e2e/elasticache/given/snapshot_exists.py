"""Given: the "elasticache" "snapshot" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given('the "elasticache" "snapshot" existed')
def snapshot_exists(lws_session):
    ElasticacheTestClient(lws_session).create_cluster()
    ElasticacheTestClient(lws_session).create_snapshot()
