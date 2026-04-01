"""Given: an "elasticache" parameter group is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given('an "elasticache" parameter group is created')
def elasticache_pg_has_been_created(lws_session):
    ElasticacheTestClient(lws_session).create_parameter_group()
