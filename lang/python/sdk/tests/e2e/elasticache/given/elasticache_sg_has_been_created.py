"""Given: an "elasticache" subnet group is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given('an "elasticache" subnet group is created')
def elasticache_sg_has_been_created(lws_session):
    ElasticacheTestClient(lws_session).create_subnet_group()
