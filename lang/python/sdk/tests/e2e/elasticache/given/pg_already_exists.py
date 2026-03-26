"""Given: the parameter group already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given("the parameter group already exists")
def pg_already_exists(lws_session):
    ElasticacheTestClient(lws_session).create_parameter_group()
