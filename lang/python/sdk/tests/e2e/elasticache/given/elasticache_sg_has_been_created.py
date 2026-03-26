"""Given: a cache subnet group has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given("a cache subnet group has been created")
def elasticache_sg_has_been_created(lws_session):
    ElasticacheTestClient(lws_session).create_subnet_group()
