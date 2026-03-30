"""Given: a cache parameter group has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given("a cache parameter group has been created")
def elasticache_pg_has_been_created(lws_session):
    ElasticacheTestClient(lws_session).create_parameter_group()
