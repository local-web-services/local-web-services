"""Given: the "elasticache" "replication group" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given('the "elasticache" "replication group" already existed')
def rg_already_exists(lws_session):
    ElasticacheTestClient(lws_session).create_replication_group()
