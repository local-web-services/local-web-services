"""Given: the resource exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticacheTestClient


@given("the resource exists")
def resource_exists(lws_session):
    ElasticacheTestClient(lws_session).create_cluster()
