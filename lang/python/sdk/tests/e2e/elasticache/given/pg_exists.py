"""Given: the "elasticache" "parameter group" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given('the "elasticache" "parameter group" existed')
def pg_exists(lws_session):
    ElasticacheTestClient(lws_session).create_parameter_group()
