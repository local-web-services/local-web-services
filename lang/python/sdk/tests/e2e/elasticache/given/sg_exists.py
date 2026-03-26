"""Given: the subnet group exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given("the subnet group exists")
def sg_exists(lws_session):
    ElasticacheTestClient(lws_session).create_subnet_group()
