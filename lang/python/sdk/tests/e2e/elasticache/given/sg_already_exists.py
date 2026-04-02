"""Given: the "elasticache" "subnet group" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given('the "elasticache" "subnet group" already existed')
def sg_already_exists(lws_session):
    ElasticacheTestClient(lws_session).create_subnet_group()
