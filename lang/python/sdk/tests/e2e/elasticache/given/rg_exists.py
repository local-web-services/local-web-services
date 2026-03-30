"""Given: the replication group exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given("the replication group exists")
def rg_exists(lws_session):
    ElasticacheTestClient(lws_session).create_replication_group()
